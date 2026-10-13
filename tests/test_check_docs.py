"""Isolated behavior tests for the repository documentation checker.

The fixture writer substitutes a synthetic marker for the phrase
"deprecated acronym". Tests patch ``DEPRECATED_TERMS`` to that marker so
this file does not contain a real deprecated-framework term.
"""

from __future__ import annotations

import sys
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from scripts import check_docs  # noqa: E402
from scripts.check_docs import check_repository  # noqa: E402

MARKER = "DEPRECATED_FRAMEWORK_TERM"


class CheckDocsTests(unittest.TestCase):
    def setUp(self) -> None:
        self._temporary = tempfile.TemporaryDirectory()
        self.root = Path(self._temporary.name)
        self._terms = patch.object(check_docs, "DEPRECATED_TERMS", (MARKER,))
        self._terms.start()

    def tearDown(self) -> None:
        self._terms.stop()
        self._temporary.cleanup()

    def write(self, relative: str, content: str) -> None:
        content = content.replace("deprecated acronym", MARKER)
        path = self.root / relative
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(content, encoding="utf-8")

    def assertHasViolation(self, snippet: str) -> None:
        violations = check_repository(self.root)
        self.assertTrue(
            any(snippet in item for item in violations),
            violations,
        )

    def assertNoViolations(self) -> None:
        self.assertEqual(check_repository(self.root), [])

    def test_rejects_deprecated_term_in_active_markdown(self):
        self.write("README.md", "The deprecated acronym appears here.\n")
        self.assertHasViolation("deprecated terminology")

    def test_allows_deprecated_term_in_archive(self):
        self.write("archive/legacy/README.md", "Historical deprecated acronym.\n")
        self.assertNoViolations()

    def test_rejects_empty_active_markdown(self):
        self.write("principles/empty.md", "# Heading\n\nComing soon.\n")
        self.assertHasViolation("placeholder")

    def test_rejects_machine_local_paths(self):
        local_path = "/" + "Users/example/tool"
        self.write("README.md", f"Use `{local_path}`.\n")
        self.assertHasViolation("machine-local path")

    def test_rejects_missing_relative_link(self):
        self.write("README.md", "[Missing](./missing.md)\n")
        self.assertHasViolation("missing link target")

    def test_accepts_heading_anchor_and_external_link(self):
        self.write(
            "README.md",
            "# Local heading\n\n[Local](#local-heading) "
            "[External](https://example.com)\n",
        )
        self.assertNoViolations()

    def test_requires_module_urls_when_enabled(self):
        violations = check_repository(self.root, require_module_urls=True)
        self.assertTrue(any("module URL contract" in item for item in violations))

    def test_ignores_link_inside_fenced_code(self):
        self.write(
            "README.md",
            "This page has real content.\n\n"
            "```markdown\n[Missing](./missing.md)\n```\n",
        )
        self.assertNoViolations()


if __name__ == "__main__":
    unittest.main()
