#!/usr/bin/env python3
"""Turn declaration gap certificates into explicit resolution obligations.

Resolution order is deliberately fixed:
  1 DIRECT_PROOF
  2 LIBRARY_OR_EXTERNAL_THEOREM
  3 SPECIFICATION_CORRECTION
  4 EXPLICIT_TYPED_HYPOTHESIS

This program never upgrades a certificate to PROVED. It proposes the next
review action from the scanner classification. A separate exact-object build
and mathematical review are required to change proof status.
"""
from __future__ import annotations
import argparse,csv
from pathlib import Path

ORDER="DIRECT_PROOF > LIBRARY_OR_EXTERNAL_THEOREM > SPECIFICATION_CORRECTION > EXPLICIT_TYPED_HYPOTHESIS"

def route(status:str)->tuple[str,str]:
    if status=="SOURCE_CLEAN_REQUIRES_BUILD":
        return "BUILD_EXACT_OBJECT","Source is gap-marker clean; compile exact object and inspect assumptions."
    if status=="PROOF_DEBT_CANDIDATE":
        return "DIRECT_PROOF","Attempt a proof from local premises; then search the prover library."
    if status=="SPECIFICATION_GAP_CANDIDATE":
        return "SPECIFICATION_CORRECTION","Check statement truth/domain first; replace false specification rather than prove it."
    if status=="OPEN_BRIDGE_CANDIDATE":
        return "EXPLICIT_TYPED_HYPOTHESIS","Do not fabricate a proof; expose the unresolved theorem as a typed interface."
    if status=="EXPLICIT_ASSUMPTION":
        return "DEPENDENCY_AUDIT","Keep assumption explicit and determine whether an external theorem discharges it."
    return "MANUAL_MATHEMATICAL_REVIEW","Try the fixed resolution order and record the first justified outcome."

def main()->int:
    ap=argparse.ArgumentParser(); ap.add_argument("certificates",type=Path); ap.add_argument("--out",required=True,type=Path); a=ap.parse_args()
    rows=list(csv.DictReader(a.certificates.open(encoding="utf-8")))
    out=[]
    for r in rows:
        action,note=route(r["latest_status"])
        out.append({
          "certificate_id":r["certificate_id"],"repository":r["repository"],"path":r["path"],
          "declaration":r["declaration"],"current_status":r["latest_status"],
          "resolution_order":ORDER,"next_action":action,"review_note":note,
          "final_proof_status":"UNRESOLVED_PENDING_REVIEW",
          "external_theorem_reference":"","corrected_statement":"","typed_hypothesis":"",
          "exact_build_commit":"","exact_build_result":"NOT_RUN"
        })
    a.out.parent.mkdir(parents=True,exist_ok=True)
    fields=list(out[0]) if out else ["certificate_id"]
    with a.out.open("w",newline="",encoding="utf-8") as f:
        w=csv.DictWriter(f,fieldnames=fields); w.writeheader(); w.writerows(out)
    print(f"obligations={len(out)}")
    return 0
if __name__=="__main__": raise SystemExit(main())
