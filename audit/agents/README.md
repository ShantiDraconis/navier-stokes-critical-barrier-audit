# Audit Agents — Output Index

This directory holds the machine-generated outputs of the staged priority audit
pipeline described in the project problem statement.

**Authorship under audit:** Tiago Paschoalatto Fagliari (`ShantiDraconis`)  
**Temporal cutoff:** `2026-09-08T00:00:00Z`  
**External comparison target:** `openai/NavierStokesAndEuler`  
**Audit type:** chronological priority audit — not plagiarism investigation

---

## Directory layout

```
audit/agents/
├── README.md                         ← this file
├── target/
│   └── extracted_objects.md          ← OPENAI-NS-* / OPENAI-EU-* object inventory
└── priority/
    └── comparison_matrix.md          ← per-object priority comparison with evidence
```

---

## Stage dependency

```
target/extracted_objects.md        (target-extractor output — read-only view of openai repo)
          ↓
priority/comparison_matrix.md      (global-prior-art-hunter + equivalence-reviewer output)
```

Subsequent stages (genealogy, adversarial review, final audit) MUST NOT modify
the raw evidence in this directory; they must place their own output files in
new subdirectories.

---

## Methodological boundary (applies to all files in this tree)

No agent output in this directory infers:
- copying
- theft
- access
- training-data inclusion
- causal derivation
- plagiarism

from chronology or mathematical similarity alone.

A classification of IDENTICAL or MATHEMATICALLY_EQUIVALENT documents
**chronological anteriority of a mathematical object**, nothing else.
