"""Validate graph nodes/edges basic consistency."""

from pathlib import Path
import yaml


def main() -> int:
    root = Path(__file__).resolve().parents[1]
    nodes = yaml.safe_load((root / "graph" / "nodes.yaml").read_text())
    edges = yaml.safe_load((root / "graph" / "edges.yaml").read_text())

    node_ids = {n["id"] for n in nodes["nodes"]}
    ok = True
    for e in edges["edges"]:
        if e["from"] not in node_ids or e["to"] not in node_ids:
            print(f"INVALID_EDGE: {e}")
            ok = False

    if ok:
        print("graph_validate: OK")
        return 0
    print("graph_validate: FAIL")
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
