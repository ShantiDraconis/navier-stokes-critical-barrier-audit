# REPRODUCIBILITY

1. Recreate target snapshot from codeload tarball at target SHA.
2. Recompute inventory hashes and reconstructed tree SHA with `git write-tree` over snapshot.
3. Regenerate MASTER_TARGET_OBJECT_INDEX via declaration parser.
4. Re-run repository reconciliation and Zenodo metadata retrieval with cutoff fixed at 2026-09-08T00:00:00Z.
5. Recompute equivalence matrix and final N/I/E/S/C/U with the same ranking rules.
