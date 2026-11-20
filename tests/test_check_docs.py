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

    def _write_topic_index_fixture(self) -> None:
        self.write("principles/example-principle.md", "# Example principle\n\n**Strength:** Principle\n\n## The position\nText.\n")
        self.write("practices/example-practice.md", "# Example practice\n\n**Strength:** Team default\n\n## The position\nText.\n")
        self.write("standards/terraform/modules/example.md", "# Example standard\n\n**Strength:** Team default\n\n## The position\nText.\n")
        self.write("platform/reusable-workflows.md", "# Reusable workflows\n\n## The position\nText.\n")
        self.write("strategies/poly-git-repo-strategy.md", "# Repository topology\n\n**Strength:** Context-dependent choice. The team default is labeled below.\n\n## The position\nText.\n")
        self.write("new-ideas/helm-and-argocd.md", "# Helm and Argo CD\n\n**Status:** Exploring\n\n## Current hypothesis\nText.\n")
        self.write("how-to-read-these-docs.md", "# How to read these docs\n\n## How pages are organized\nText.\n")
        self.write("promoting-an-idea.md", "# Promote a new idea into active guidance\n\n**Strength:** Team default\n\n## The position\nText.\n")
        self.write("maintaining-the-topic-index.md", "# Maintain the topic index with the source\n\n**Strength:** Team default\n\n## The position\nText.\n")

        # Exempt pages should not require entries.
        self.write("principles/README.md", "# Principles\n\nIndex body.\n")
        self.write("practices/README.md", "# Practices\n\nIndex body.\n")
        self.write("standards/README.md", "# Standards\n\nIndex body.\n")
        self.write("platform/README.md", "# Platform map\n\nIndex body.\n")
        self.write("new-ideas/README.md", "# New ideas\n\nIndex body.\n")
        self.write("new-ideas/idea-template.md", "# <Idea title>\n\nIndex body.\n")
        self.write("standards/iac-development/README.md", "# Exclusive and shared services\n\nIndex body.\n")
        self.write("standards/helm-development/README.md", "# Helm chart tools and practices\n\nIndex body.\n")
        self.write("standards/helm-development/charts/deployment/README.md", "# Helm deployment charts\n\nIndex body.\n")
        self.write("standards/helm-development/charts/library/README.md", "# Helm library charts\n\nIndex body.\n")
        self.write("standards/helm-development/helpers/README.md", "# Helm chart helpers\n\nIndex body.\n")

        self.write("standards/terraform/modules/primitive.md", "# Primitive\n\n**Strength:** Team default\n\n## The position\nText.\n")
        self.write("standards/terraform/modules/collection.md", "# Collection\n\n**Strength:** Team default\n\n## The position\nText.\n")
        self.write("standards/terraform/modules/library.md", "# Library\n\n**Strength:** Team default\n\n## The position\nText.\n")
        self.write("standards/terraform/modules/reference-architecture.md", "# Reference architecture\n\n**Strength:** Team default\n\n## The position\nText.\n")
        self.write("standards/iac-development/terraform/module/primitive/README.md", "# Compatibility\n\nBody.\n")
        self.write("standards/iac-development/terraform/module/collection/README.md", "# Compatibility\n\nBody.\n")
        self.write("standards/iac-development/terraform/module/library/README.md", "# Compatibility\n\nBody.\n")
        self.write("standards/iac-development/terraform/module/reference-architecture/README.md", "# Compatibility\n\nBody.\n")

    def _write_valid_topic_index(self) -> None:
        self.write(
            "TOPIC-INDEX.md",
            "\n".join(
                [
                    "# Topic index",
                    "",
                    "```yaml",
                    "- id: principle.example",
                    "  title: Example principle",
                    "  summary: Summary",
                    "  aliases: [example principle]",
                    "  type: principle",
                    "  strength: Principle",
                    "  source: principles/example-principle.md#the-position",
                    "- id: practice.example",
                    "  title: Example practice",
                    "  summary: Summary",
                    "  aliases: [example practice]",
                    "  type: practice",
                    "  strength: Team default",
                    "  source: practices/example-practice.md#the-position",
                    "- id: standard.example",
                    "  title: Example standard",
                    "  summary: Summary",
                    "  aliases: [example standard]",
                    "  type: standard",
                    "  strength: Team default",
                    "  source: standards/terraform/modules/example.md#the-position",
                    "  former_paths:",
                    "    - standards/iac-development/terraform/module/primitive/README.md",
                    "- id: standard.collection",
                    "  title: Collection",
                    "  summary: Summary",
                    "  aliases: [collection]",
                    "  type: standard",
                    "  strength: Team default",
                    "  source: standards/terraform/modules/collection.md#the-position",
                    "- id: standard.library",
                    "  title: Library",
                    "  summary: Summary",
                    "  aliases: [library]",
                    "  type: standard",
                    "  strength: Team default",
                    "  source: standards/terraform/modules/library.md#the-position",
                    "- id: standard.primitive",
                    "  title: Primitive",
                    "  summary: Summary",
                    "  aliases: [primitive]",
                    "  type: standard",
                    "  strength: Team default",
                    "  source: standards/terraform/modules/primitive.md#the-position",
                    "- id: standard.reference-architecture",
                    "  title: Reference architecture",
                    "  summary: Summary",
                    "  aliases: [reference architecture]",
                    "  type: standard",
                    "  strength: Team default",
                    "  source: standards/terraform/modules/reference-architecture.md#the-position",
                    "- id: platform.example",
                    "  title: Reusable workflows",
                    "  summary: Summary",
                    "  aliases: [workflows]",
                    "  type: platform-map",
                    "  source: platform/reusable-workflows.md#the-position",
                    "  related:",
                    "    - standards/terraform/modules/example.md#the-position",
                    "- id: strategy.topology",
                    "  title: Repository topology",
                    "  summary: Summary",
                    "  aliases: [poly-git]",
                    "  type: knowledge-base",
                    "  strength: Context-dependent choice. The team default is labeled below.",
                    "  source: strategies/poly-git-repo-strategy.md#the-position",
                    "- id: idea.helm-argocd",
                    "  title: Helm and Argo CD",
                    "  summary: Summary",
                    "  aliases: [helm, argocd]",
                    "  type: new-idea",
                    "  status: Exploring",
                    "  source: new-ideas/helm-and-argocd.md#current-hypothesis",
                    "- id: docs.how-to-read",
                    "  title: How to read these docs",
                    "  summary: Summary",
                    "  aliases: [reader guide]",
                    "  type: knowledge-base",
                    "  source: how-to-read-these-docs.md#how-pages-are-organized",
                    "- id: docs.promoting-ideas",
                    "  title: Promote ideas",
                    "  summary: Summary",
                    "  aliases: [promotion process]",
                    "  type: knowledge-base",
                    "  strength: Team default",
                    "  source: promoting-an-idea.md#the-position",
                    "- id: docs.maintaining-topic-index",
                    "  title: Maintain topic index",
                    "  summary: Summary",
                    "  aliases: [index maintenance]",
                    "  type: knowledge-base",
                    "  strength: Team default",
                    "  source: maintaining-the-topic-index.md#the-position",
                    "```",
                    "",
                ]
            ),
        )

    def test_requires_topic_index_file_when_enabled(self):
        violations = check_repository(self.root, require_topic_index=True)
        self.assertTrue(any("missing topic index" in item for item in violations), violations)

    def test_accepts_valid_topic_index_when_enabled(self):
        self._write_topic_index_fixture()
        self._write_valid_topic_index()
        violations = check_repository(self.root, require_topic_index=True)
        self.assertFalse(any("TOPIC-INDEX.md" in item for item in violations), violations)

    def test_rejects_invalid_topic_index_schema(self):
        self._write_topic_index_fixture()
        self.write("TOPIC-INDEX.md", "# Topic index\n\n```yaml\n- id: bad\n  title: Bad\n```\n")
        violations = check_repository(self.root, require_topic_index=True)
        self.assertTrue(any("missing required field" in item for item in violations), violations)

    def test_rejects_missing_anchor_for_topic_index_source(self):
        self._write_topic_index_fixture()
        self._write_valid_topic_index()
        self.write(
            "TOPIC-INDEX.md",
            "# Topic index\n\n```yaml\n- id: principle.example\n  title: Example principle\n  summary: Summary\n  aliases: [example principle]\n  type: principle\n  strength: Principle\n  source: principles/example-principle.md#missing-anchor\n```\n",
        )
        violations = check_repository(self.root, require_topic_index=True)
        self.assertTrue(any("source anchor missing" in item for item in violations), violations)

    def test_rejects_topic_index_strength_mismatch(self):
        self._write_topic_index_fixture()
        self.write(
            "TOPIC-INDEX.md",
            "# Topic index\n\n```yaml\n- id: principle.example\n  title: Example principle\n  summary: Summary\n  aliases: [example principle]\n  type: principle\n  strength: Team default\n  source: principles/example-principle.md#the-position\n```\n",
        )
        violations = check_repository(self.root, require_topic_index=True)
        self.assertTrue(any("strength mismatch" in item for item in violations), violations)

    def test_rejects_topic_index_entries_that_point_to_exempt_pages(self):
        self._write_topic_index_fixture()
        self.write(
            "TOPIC-INDEX.md",
            "# Topic index\n\n```yaml\n- id: principle.bad\n  title: Principles index\n  summary: Summary\n  aliases: [principles]\n  type: principle\n  source: principles/README.md\n```\n",
        )
        violations = check_repository(self.root, require_topic_index=True)
        self.assertTrue(any("source cannot be exempt page" in item for item in violations), violations)

    def test_rejects_topic_index_when_active_page_entry_missing(self):
        self._write_topic_index_fixture()
        self.write(
            "TOPIC-INDEX.md",
            "# Topic index\n\n```yaml\n- id: docs.how-to-read\n  title: How to read these docs\n  summary: Summary\n  aliases: [reader guide]\n  type: knowledge-base\n  source: how-to-read-these-docs.md#how-pages-are-organized\n```\n",
        )
        violations = check_repository(self.root, require_topic_index=True)
        self.assertTrue(any("missing entry for active page" in item for item in violations), violations)

    def test_heading_slug_keeps_repeated_hyphens_like_github(self):
        slugs = check_docs._markdown_heading_slugs("# A - B\n")
        self.assertIn("a---b", slugs)
        self.assertNotIn("a-b", slugs)

    def test_heading_slug_ignores_headings_inside_fenced_code(self):
        slugs = check_docs._markdown_heading_slugs(
            "# Real heading\n\n```md\n# Fake heading\n```\n"
        )
        self.assertIn("real-heading", slugs)
        self.assertNotIn("fake-heading", slugs)


if __name__ == "__main__":
    unittest.main()
