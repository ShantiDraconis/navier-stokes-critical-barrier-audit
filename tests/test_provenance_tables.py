"""Integrity tests for the audit's machine-readable provenance tables.

These tests validate data shape and epistemic labels. They do not prove any
Millennium problem.
"""

from __future__ import annotations

import csv
import datetime as dt
import pathlib
import re
import unittest

ROOT = pathlib.Path(__file__).resolve().parents[1]
HEX40 = re.compile(r"^[0-9a-f]{40}$")


def read_csv(rel):
    with (ROOT / rel).open(newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))


class ProvenanceTableTests(unittest.TestCase):
    def test_chronology_required_columns(self):
        rows = read_csv("data/chronology.csv")
        self.assertTrue(rows)
        required = {
            "id", "date_utc", "date_type", "repository", "commit_sha",
            "object", "classification", "verification", "notes",
        }
        self.assertTrue(required.issubset(rows[0].keys()))

    def test_known_chronology_dates_parse(self):
        for row in read_csv("data/chronology.csv"):
            value = row["date_utc"]
            if not value or value == "UNKNOWN":
                continue
            parsed = dt.datetime.fromisoformat(value.replace("Z", "+00:00"))
            self.assertIsNotNone(parsed.tzinfo, row["id"])

    def test_full_commit_shas_when_present(self):
        for row in read_csv("data/chronology.csv"):
            sha = row["commit_sha"]
            if sha in {"", "UNKNOWN"}:
                continue
            self.assertRegex(sha, HEX40, row["id"])

    def test_edge_vocabulary_and_endpoints(self):
        allowed = {
            "PRECEDES", "DERIVED_FROM", "REFINES", "GENERALIZES",
            "SPECIALIZES", "FORMALIZES", "RELATED_TO", "OPEN_BRIDGE",
            "STRUCTURAL_PRECURSOR", "PARALLEL_REFINEMENT",
            "DEFINITIONAL_EXTENSION", "CLASSICAL_THEOREM",
        }
        for row in read_csv("data/provenance_edges.csv"):
            self.assertTrue(row["source"].strip(), row["edge_id"])
            self.assertTrue(row["target"].strip(), row["edge_id"])
            self.assertIn(row["edge_type"], allowed, row["edge_id"])

    def test_open_bridge_is_never_labeled_proved(self):
        for row in read_csv("data/provenance_edges.csv"):
            if row["edge_type"] == "OPEN_BRIDGE":
                self.assertNotIn(row["status"].upper(), {"PROVED", "VERIFIED"}, row["edge_id"])

    def test_unique_ids(self):
        chronology = read_csv("data/chronology.csv")
        edges = read_csv("data/provenance_edges.csv")
        ids = [r["id"] for r in chronology]
        edge_ids = [r["edge_id"] for r in edges]
        self.assertEqual(len(ids), len(set(ids)))
        self.assertEqual(len(edge_ids), len(set(edge_ids)))


if __name__ == "__main__":
    unittest.main()
