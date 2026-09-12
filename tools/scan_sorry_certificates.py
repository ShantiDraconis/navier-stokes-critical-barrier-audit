#!/usr/bin/env python3
"""Declaration-level historical gap scanner and certificate generator.

Run against local Git clones that the reviewer is authorized to inspect.
The output is sanitized: repository alias, relative path, Git hashes, declaration
names/kinds, line spans, marker counts, normalized dependency candidates and
certificate hashes. Source bodies and absolute paths are never emitted.

The scanner answers, for every declaration seen in history:
  * first Git object in which the declaration is observed;
  * first object where its own declaration block contains a proof-gap marker;
  * first later source-clean version (if one exists);
  * latest observed version and status;
  * premise/dependent candidates by exact declaration-name references;
  * a deterministic certificate SHA-256.

It does NOT claim semantic dependency or proof validity. Build/kernel certificates
must be attached separately after compiling the exact Git object.
"""
from __future__ import annotations

import argparse
import csv
import hashlib
import json
import re
import subprocess
from collections import defaultdict
from dataclasses import dataclass, asdict
from pathlib import Path
from typing import Iterable

FORMAL_EXTS = {".lean", ".v", ".thy", ".agda"}
LANG = {".lean":"lean", ".v":"coq", ".thy":"isabelle", ".agda":"agda"}

DECL_RX = {
    "lean": re.compile(r"(?m)^\s*(theorem|lemma|def|opaque|abbrev|structure|class|inductive|axiom)\s+([A-Za-z0-9_'.]+)"),
    "coq": re.compile(r"(?m)^\s*(Theorem|Lemma|Fact|Remark|Corollary|Proposition|Definition|Fixpoint|Inductive|Record|Axiom|Parameter)\s+([A-Za-z0-9_'.]+)"),
    "isabelle": re.compile(r"(?m)^\s*(theorem|lemma|corollary|definition|fun|primrec|datatype|record|axiomatization)\s+([A-Za-z0-9_'.]+)"),
    "agda": re.compile(r"(?m)^\s*(?:postulate\s+)?([A-Za-z0-9_'.]+)\s*:\s*"),
}

MARKERS = {
    "sorry": re.compile(r"\bsorry\b", re.I),
    "admit": re.compile(r"\badmit\b", re.I),
    "admitted": re.compile(r"\bAdmitted\b"),
    "postulate": re.compile(r"\bpostulate\b", re.I),
    "axiom": re.compile(r"\b(?:axiom|Axiom|axiomatization)\b"),
    "true_placeholder": re.compile(r"(?<![A-Za-z])True(?![A-Za-z])"),
    "todo": re.compile(r"\bTODO\b", re.I),
}

OPEN_HINTS = re.compile(
    r"actual independence|open problem|millennium|would require.*(?:proof|theorem)|"
    r"global regularity|mass gap|riemann hypothesis|p\s*(?:=|≠|vs)\s*np|"
    r"birch|hodge|yang.?mills|unknown", re.I)
PROOF_DEBT_HINTS = re.compile(
    r"more detailed proof|routine|straightforward|by completeness|triangle|"
    r"well[- ]defined|algebraic manipulation", re.I)
SPEC_HINTS = re.compile(r"placeholder|skeleton|implementation specific|to be proven|requires model restriction", re.I)


def run(repo: Path, *args: str) -> str:
    p = subprocess.run(["git","-C",str(repo),*args], check=True,
                       stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    return p.stdout


def sha256(s: str) -> str:
    return hashlib.sha256(s.encode("utf-8", errors="replace")).hexdigest()


def commits(repo: Path) -> Iterable[dict]:
    fmt = "%H%x1f%P%x1f%aI%x1f%cI%x1f%T%x1f%s%x1e"
    for rec in run(repo,"log","--all","--reverse",f"--format={fmt}").split("\x1e"):
        rec = rec.strip("\n")
        if not rec.strip(): continue
        parts = rec.split("\x1f")
        if len(parts) != 6: continue
        sha, parents, adate, cdate, tree, subject = parts
        yield dict(sha=sha, parents=parents.split() if parents else [],
                   author_date=adate, committer_date=cdate, tree_sha=tree,
                   subject=subject)


def files_at(repo: Path, sha: str) -> list[str]:
    return [x for x in run(repo,"ls-tree","-r","--name-only",sha).splitlines()
            if Path(x).suffix.lower() in FORMAL_EXTS]


def text_at(repo: Path, sha: str, rel: str) -> str | None:
    try: return run(repo,"show",f"{sha}:{rel}")
    except subprocess.CalledProcessError: return None


def blob_at(repo: Path, sha: str, rel: str) -> str:
    return run(repo,"rev-parse",f"{sha}:{rel}").strip()


def line_no(text: str, pos: int) -> int:
    return text.count("\n", 0, pos) + 1


def declaration_blocks(text: str, language: str) -> list[dict]:
    rx = DECL_RX[language]
    ms = list(rx.finditer(text))
    out = []
    for i,m in enumerate(ms):
        start = m.start(); end = ms[i+1].start() if i+1 < len(ms) else len(text)
        if language == "agda": kind, name = "declaration", m.group(1)
        else: kind, name = m.group(1), m.group(2)
        block = text[start:end]
        counts = {k: len(r.findall(block)) for k,r in MARKERS.items()}
        out.append(dict(kind=kind, name=name, start_line=line_no(text,start),
                        end_line=line_no(text,max(start,end-1)), block=block,
                        markers=counts, block_sha256=sha256(block)))
    return out


def has_gap(d: dict) -> bool:
    m=d["markers"]
    return any(m.get(k,0) for k in ("sorry","admit","admitted","postulate","axiom","true_placeholder"))


def classify(d: dict) -> str:
    kind=d["kind"].lower(); block=d["block"]
    if kind in {"axiom","parameter","axiomatization"} or d["markers"].get("postulate",0):
        return "EXPLICIT_ASSUMPTION"
    if not has_gap(d): return "SOURCE_CLEAN_REQUIRES_BUILD"
    if OPEN_HINTS.search(block): return "OPEN_BRIDGE_CANDIDATE"
    if PROOF_DEBT_HINTS.search(block): return "PROOF_DEBT_CANDIDATE"
    if SPEC_HINTS.search(block): return "SPECIFICATION_GAP_CANDIDATE"
    return "UNCLASSIFIED_GAP_REVIEW_REQUIRED"


def norm(s: str) -> str:
    return re.sub(r"[^a-z0-9]+","_",s.lower()).strip("_")

@dataclass
class Version:
    repo:str; sha:str; author_date:str; committer_date:str; tree_sha:str
    path:str; blob_sha:str; language:str; kind:str; name:str
    start_line:int; end_line:int; block_sha256:str; status:str
    markers_json:str


def main() -> int:
    ap=argparse.ArgumentParser()
    ap.add_argument("repos", nargs="+", type=Path)
    ap.add_argument("--certificates", required=True, type=Path)
    ap.add_argument("--nodes", required=True, type=Path)
    ap.add_argument("--edges", required=True, type=Path)
    args=ap.parse_args()

    versions: dict[tuple[str,str,str], list[Version]] = defaultdict(list)
    latest_blocks: dict[tuple[str,str,str], str] = {}
    latest_names_by_repo: dict[str,set[str]] = defaultdict(set)

    for repo in args.repos:
        if not (repo/".git").exists(): raise SystemExit(f"Not a Git clone: {repo.name}")
        alias=repo.name
        for c in commits(repo):
            for rel in files_at(repo,c["sha"]):
                text=text_at(repo,c["sha"],rel)
                if text is None: continue
                language=LANG[Path(rel).suffix.lower()]
                blob=blob_at(repo,c["sha"],rel)
                for d in declaration_blocks(text,language):
                    key=(alias,rel,norm(d["name"]))
                    v=Version(alias,c["sha"],c["author_date"],c["committer_date"],c["tree_sha"],
                              rel,blob,language,d["kind"],d["name"],d["start_line"],d["end_line"],
                              d["block_sha256"],classify(d),json.dumps(d["markers"],sort_keys=True))
                    versions[key].append(v)
                    latest_blocks[key]=d["block"]
                    latest_names_by_repo[alias].add(d["name"])

    certs=[]; nodes=[]; edges=[]
    for key, hist in versions.items():
        hist.sort(key=lambda v:(v.committer_date,v.sha))
        first=hist[0]; latest=hist[-1]
        first_gap=next((v for v in hist if v.status not in {"SOURCE_CLEAN_REQUIRES_BUILD"}),None)
        resolution=None
        if first_gap:
            seen=False
            for v in hist:
                if v.sha==first_gap.sha: seen=True
                elif seen and v.status=="SOURCE_CLEAN_REQUIRES_BUILD":
                    resolution=v; break
        cert_material="|".join([first.repo,first.path,norm(first.name),first.sha,
                                latest.sha,latest.block_sha256,latest.status])
        cid="GAPCERT-"+sha256(cert_material)[:20].upper()
        certs.append({
            "certificate_id":cid,"repository":first.repo,"path":first.path,
            "declaration":first.name,"kind":first.kind,"language":first.language,
            "first_seen_sha":first.sha,"first_seen_date":first.committer_date,
            "first_gap_sha":first_gap.sha if first_gap else "",
            "first_gap_date":first_gap.committer_date if first_gap else "",
            "first_source_clean_after_gap_sha":resolution.sha if resolution else "",
            "first_source_clean_after_gap_date":resolution.committer_date if resolution else "",
            "latest_sha":latest.sha,"latest_date":latest.committer_date,
            "latest_blob_sha":latest.blob_sha,"latest_block_sha256":latest.block_sha256,
            "latest_status":latest.status,"latest_markers":latest.markers_json,
            "build_status":"NOT_EXECUTED_BY_SCANNER",
            "semantic_status":"REVIEW_REQUIRED" if latest.status!="SOURCE_CLEAN_REQUIRES_BUILD" else "SOURCE_CLEAN_ONLY",
        })
        nid=f"{first.repo}::{first.path}::{norm(first.name)}"
        nodes.append({"node_id":nid,"certificate_id":cid,"repository":first.repo,
                      "path":first.path,"declaration":first.name,"latest_status":latest.status})

    # Candidate premise edges: exact declaration-name reference in latest block.
    id_by=( {(n["repository"],n["declaration"]):n["node_id"] for n in nodes} )
    for key,block in latest_blocks.items():
        repo,path,nname=key
        target=next((n for n in nodes if n["repository"]==repo and n["path"]==path and norm(n["declaration"])==nname),None)
        if not target: continue
        for depname in latest_names_by_repo[repo]:
            if depname==target["declaration"]: continue
            if re.search(rf"(?<![A-Za-z0-9_']){re.escape(depname)}(?![A-Za-z0-9_'])",block):
                src=id_by.get((repo,depname))
                if src:
                    edges.append({"source":src,"target":target["node_id"],
                                  "edge_kind":"TEXTUAL_REFERENCE_CANDIDATE",
                                  "confidence":"LOW","review_required":"true"})

    for p in (args.certificates,args.nodes,args.edges): p.parent.mkdir(parents=True,exist_ok=True)
    def write(path,rows,fields):
        with path.open("w",newline="",encoding="utf-8") as f:
            w=csv.DictWriter(f,fieldnames=fields); w.writeheader(); w.writerows(rows)
    cfields=list(certs[0]) if certs else ["certificate_id"]
    nfields=list(nodes[0]) if nodes else ["node_id"]
    efields=["source","target","edge_kind","confidence","review_required"]
    write(args.certificates,certs,cfields); write(args.nodes,nodes,nfields); write(args.edges,edges,efields)
    print(f"certificates={len(certs)} nodes={len(nodes)} edges={len(edges)}")
    return 0

if __name__=="__main__": raise SystemExit(main())
