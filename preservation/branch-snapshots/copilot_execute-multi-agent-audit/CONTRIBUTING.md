# Contributing

## Rules

- Keep **priority/provenance** updates separate from **mathematical audit** updates.
- Do not rewrite historical claims without citing new evidence nodes.
- Mark unverifiable values as `UNKNOWN`.
- Do not label a claim `REFUTED` without an explicit contradiction proof reference.
- Do not add any OpenAI ↔ Fagliari `derived_from` relation without direct evidence.

## Workflow

1. Add or update evidence nodes (`evidence/*.yaml`).
2. Update graph edges/nodes and run `python/graph_validate.py`.
3. Update claim statuses and run `python/claim_status.py`.
4. Add results under `results/` with UTC timestamped metadata.
