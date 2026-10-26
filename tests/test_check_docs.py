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
from scripts.check_docs import HISTORICAL_BANNER, check_repository  # noqa: E402

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
        self.write(
            "archive/legacy/README.md",
            f"{HISTORICAL_BANNER}\n\nHistorical deprecated acronym.\n",
        )
        self.assertNoViolations()

    def test_requires_historical_banner_on_archived_pages(self):
        self.write("archive/legacy/README.md", "Historical page without a banner.\n")
        self.assertHasViolation("missing historical banner")

    def test_rejects_home_relative_paths(self):
        tilde_path = "~" + "/code/x"
        home_path = "$" + "HOME/x"
        self.write("README.md", f"Use `{tilde_path}` and `{home_path}`.\n")
        violations = check_repository(self.root)
        self.assertTrue(any(tilde_path in item for item in violations), violations)
        self.assertTrue(any(home_path in item for item in violations), violations)

    def test_rejects_sensitive_identifiers_and_allows_placeholders(self):
        account = "123456" + "789012"
        allowed_account = "111111" + "111111"
        arn = "arn:" + "aws:iam::" + account + ":role/example"
        guid = "12345678-1234-1234-1234-" + "123456" + "789012"
        allowed_guid = "00000000-0000-0000-0000-" + ("0" * 6) + ("0" * 6)
        email = "person" + "@" + "example.org"
        allowed_email = "person" + "@" + "example.com"
        example_domain_email = "person" + "@" + "client.example"
        placeholder_arn = "arn:" + "aws:iam::" + allowed_account + ":role/example"
        self.write(
            "README.md",
            "\n".join(
                [
                    account,
                    allowed_account,
                    arn,
                    placeholder_arn,
                    guid,
                    allowed_guid,
                    email,
                    allowed_email,
                    example_domain_email,
                ]
            )
            + "\n",
        )
        violations = check_repository(self.root)
        self.assertTrue(any(account in item for item in violations), violations)
        self.assertTrue(any(arn in item for item in violations), violations)
        self.assertTrue(any(guid in item for item in violations), violations)
        self.assertTrue(any(email in item for item in violations), violations)
        self.assertFalse(
            any(f"account identifier: {allowed_account}" in item for item in violations),
            violations,
        )
        self.assertFalse(
            any(f"tenant identifier: {allowed_guid}" in item for item in violations),
            violations,
        )
        self.assertFalse(
            any(f"email address: {allowed_email}" in item for item in violations),
            violations,
        )
        self.assertFalse(
            any(example_domain_email in item for item in violations),
            violations,
        )
        self.assertFalse(
            any(f"cloud resource name: {placeholder_arn}" in item for item in violations),
            violations,
        )

    def test_rejects_empty_active_markdown(self):
        self.write("principles/empty.md", "# Heading\n\nComing soon.\n")
        self.assertHasViolation("placeholder")

    def test_rejects_machine_local_paths(self):
        local_path = "/" + "Users/example/tool"
        self.write("README.md", f"Use `{local_path}`.\n")
        self.assertHasViolation("machine-local path")

    def test_rejects_windows_backslash_user_path(self):
        local_path = "C:" + "\\" + "Users\\" + "example\\tool"
        self.write("README.md", f"Use `{local_path}`.\n")
        violations = check_repository(self.root)
        self.assertTrue(any(local_path in item for item in violations), violations)

    def test_rejects_windows_forward_slash_user_path(self):
        local_path = "C:" + "/" + "Users/" + "example/tool"
        self.write("README.md", f"Use `{local_path}`.\n")
        violations = check_repository(self.root)
        self.assertTrue(any(local_path in item for item in violations), violations)

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

    def _write_module_url_pages(self, primitive_link: str) -> None:
        pages = (
            (
                "standards/iac-development/terraform/module/primitive/README.md",
                "standards/terraform/modules/primitive.md",
                primitive_link,
            ),
            (
                "standards/iac-development/terraform/module/collection/README.md",
                "standards/terraform/modules/collection.md",
                "../../../../terraform/modules/collection.md",
            ),
            (
                "standards/iac-development/terraform/module/"
                "reference-architecture/README.md",
                "standards/terraform/modules/reference-architecture.md",
                "../../../../terraform/modules/reference-architecture.md",
            ),
            (
                "standards/iac-development/terraform/module/library/README.md",
                "standards/terraform/modules/library.md",
                "../../../../terraform/modules/library.md",
            ),
        )
        for compatibility, canonical, link in pages:
            self.write(
                canonical,
                "# Canonical module page\n\n"
                "This page states the module contract callers rely on.\n",
            )
            self.write(
                compatibility,
                "# Compatibility page\n\n"
                f"The current page is [the module contract]({link}).\n",
            )

    def test_accepts_module_urls_when_each_page_links_to_its_canonical_page(self):
        self._write_module_url_pages("../../../../terraform/modules/primitive.md")
        violations = check_repository(self.root, require_module_urls=True)
        self.assertFalse(
            any("module URL contract" in item for item in violations),
            violations,
        )

    def test_rejects_compatibility_page_that_links_to_the_wrong_canonical_page(self):
        self._write_module_url_pages("../../../../terraform/modules/library.md")
        violations = check_repository(self.root, require_module_urls=True)
        self.assertTrue(
            any(
                "module/primitive/README.md" in item and "missing link" in item
                for item in violations
            ),
            violations,
        )
        self.assertFalse(
            any("module/library/README.md" in item and "missing link" in item for item in violations),
            violations,
        )

    def test_ignores_link_inside_fenced_code(self):
        self.write(
            "README.md",
            "This page has real content.\n\n"
            "```markdown\n[Missing](./missing.md)\n```\n",
        )
        self.assertNoViolations()


if __name__ == "__main__":
    unittest.main()
