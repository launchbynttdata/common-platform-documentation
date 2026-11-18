"""Read-only validation for repository documentation.

Reports repository-relative violations for active-content boundaries, links,
portable paths, and optional Terraform module URL contracts. This script
never modifies files.
"""

from __future__ import annotations

import argparse
import os
import re
import subprocess
import sys
from collections.abc import Iterator, Sequence
from pathlib import Path
from urllib.parse import unquote, urlsplit

import yaml

ARCHIVE_PART = "archive"
# Keep each entry split so this source file does not contain a contiguous
# banned term and the checker does not report itself.
DEPRECATED_TERMS = (
    "lc" + "af",
    "launch common automation " + "framework",
)
PLACEHOLDER_TEXT = {
    "",
    "coming soon",
    "todo",
    "tbd",
}
LOCAL_PATH_PATTERNS = (
    re.compile(r"(?<![\w])/(?:Users|home)/[^`\s)]+"),
    re.compile(r"(?<![\w])" + re.escape("~" + "/") + r"[^\s`)]+"),
    re.compile(r"(?<![\w])" + re.escape("$" + "HOME") + r"(?:/|\\)[^\s`)]+"),
    re.compile(r"\b" + re.escape("file" + "://") + r"[^\s)]+"),
    re.compile(r"\b[A-Za-z]:([/\\])Users\1[^`\s)]+"),
)
_ACCOUNT_ID = re.compile(r"(?<!\d)\d{12}(?!\d)")
_ARN = re.compile(re.escape("arn:" + "aws") + r"(?:-[a-z]+)?:[^\s)`]+")
_GUID = re.compile(
    r"\b[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-"
    r"[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\b"
)
_EMAIL = re.compile(r"\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b")
_ALLOWED_ACCOUNT_IDS = {digit * 12 for digit in "0123456789"}
_ALLOWED_ACCOUNT_IDS.add("012345" + "678912")
_NIL_GUID = ("00000000-0000-0000-0000-" + ("0" * 6) + ("0" * 6))
_ALLOWED_GUIDS = {_NIL_GUID.casefold()}
_ALLOWED_EMAIL_DOMAINS = {"example.com", "job." + "job"}
ARCHIVE_CURRENT_PAGES = {
    Path("archive/README.md"),
    Path("archive/content-disposition.md"),
}
HISTORICAL_BANNER = "> **Historical.** This page is not current guidance."
MODULE_URL_PAIRS = (
    (
        Path("standards/iac-development/terraform/module/primitive/README.md"),
        Path("standards/terraform/modules/primitive.md"),
    ),
    (
        Path("standards/iac-development/terraform/module/collection/README.md"),
        Path("standards/terraform/modules/collection.md"),
    ),
    (
        Path(
            "standards/iac-development/terraform/module/"
            "reference-architecture/README.md"
        ),
        Path("standards/terraform/modules/reference-architecture.md"),
    ),
    (
        Path("standards/iac-development/terraform/module/library/README.md"),
        Path("standards/terraform/modules/library.md"),
    ),
)
TOPIC_INDEX_FILE = Path("TOPIC-INDEX.md")
TOPIC_INDEX_ID = re.compile(r"^[a-z0-9]+(?:\.[a-z0-9-]+)+$")
TOPIC_INDEX_TYPES = {
    "principle",
    "practice",
    "standard",
    "platform-map",
    "new-idea",
    "knowledge-base",
}
TOPIC_INDEX_ALLOWED_FIELDS = {
    "id",
    "title",
    "summary",
    "aliases",
    "type",
    "strength",
    "status",
    "source",
    "related",
    "former_paths",
}
TOPIC_INDEX_REQUIRED_FIELDS = {"id", "title", "summary", "aliases", "type", "source"}
TOPIC_INDEX_CONTENT_DIRS = (
    "principles",
    "practices",
    "standards",
    "platform",
    "new-ideas",
    "strategies",
)
TOPIC_INDEX_ROOT_ACTIVE_PAGES = {
    Path("how-to-read-these-docs.md"),
    Path("promoting-an-idea.md"),
}
TOPIC_INDEX_EXEMPT_PAGES = {
    Path("principles/README.md"),
    Path("practices/README.md"),
    Path("standards/README.md"),
    Path("platform/README.md"),
    Path("new-ideas/README.md"),
    Path("new-ideas/idea-template.md"),
    Path("standards/iac-development/README.md"),
    Path("standards/helm-development/README.md"),
    Path("standards/helm-development/charts/deployment/README.md"),
    Path("standards/helm-development/charts/library/README.md"),
    Path("standards/helm-development/helpers/README.md"),
    Path("README.md"),
    Path("CHANGELOG.md"),
    Path("TOPIC-INDEX.md"),
}
TOPIC_INDEX_COMPATIBILITY_PAGES = {
    pair[0] for pair in MODULE_URL_PAIRS
}

_ATX_HEADING = re.compile(r"^[ \t]{0,3}#{1,6}(?:[ \t].*)?$")
_SETEXT_UNDERLINE = re.compile(r"^[ \t]{0,3}(?:=|-){3,}[ \t]*$")
_FENCE_OPEN = re.compile(r"^[ \t]{0,3}(`{3,}|~{3,})")
_IGNORED_LINK_SCHEMES = {"http", "https", "mailto"}
_TRAILING_PUNCTUATION = ".,;:!?\"'"


def check_repository(
    root: Path,
    require_module_urls: bool = False,
    require_topic_index: bool = False,
) -> list[str]:
    """Return sorted repository-relative violation messages for ``root``."""
    root = Path(root).resolve()
    violations: list[str] = []
    if root.is_dir():
        for path in _iter_files(root):
            relative = path.relative_to(root)
            if not relative.parts or ".git" in relative.parts:
                continue
            text = _read_text(path)
            if text is None:
                continue
            historical = ARCHIVE_PART in relative.parts
            if relative.suffix.casefold() == ".md":
                if not historical:
                    violations.extend(_deprecated_violations(relative, text))
                    violations.extend(_placeholder_violations(relative, text))
                else:
                    violations.extend(_historical_banner_violations(relative, text))
                violations.extend(_link_violations(root, path, relative, text))
            violations.extend(_local_path_violations(relative, text))
            violations.extend(_sensitive_identifier_violations(relative, text))
    if require_module_urls:
        violations.extend(_module_url_violations(root))
    if require_topic_index:
        violations.extend(_topic_index_violations(root))
    return sorted(set(violations))


def main(argv: Sequence[str] | None = None) -> int:
    """Run the CLI and return its process status."""
    parser = argparse.ArgumentParser(
        description="Report repository documentation violations.",
    )
    parser.add_argument(
        "root",
        nargs="?",
        default=".",
        type=Path,
        help="Repository root to inspect. Defaults to the current directory.",
    )
    parser.add_argument(
        "--require-module-urls",
        action="store_true",
        help="Require Terraform module compatibility and canonical pages.",
    )
    parser.add_argument(
        "--require-topic-index",
        action="store_true",
        help="Require a valid topic index that covers active pages.",
    )
    args = parser.parse_args(argv)
    violations = check_repository(
        args.root,
        require_module_urls=args.require_module_urls,
        require_topic_index=args.require_topic_index,
    )
    if violations:
        print("\n".join(violations))
        return 1
    return 0


def _iter_files(root: Path) -> list[Path]:
    listed = _git_listed_files(root)
    if listed is not None:
        return listed
    files: list[Path] = []
    for directory, dirnames, filenames in os.walk(root):
        dirnames[:] = [name for name in dirnames if name != ".git"]
        for name in filenames:
            if name == ".git":
                continue
            files.append(Path(directory) / name)
    return files


def _git_listed_files(root: Path) -> list[Path] | None:
    """Return tracked and unignored untracked files when ``root`` is a work tree."""
    toplevel = _git_output(root, ["rev-parse", "--show-toplevel"])
    if toplevel is None:
        return None
    if Path(toplevel).resolve() != root:
        return None
    listed = _git_output(
        root,
        ["ls-files", "-z", "--cached", "--others", "--exclude-standard"],
        binary=True,
    )
    if listed is None:
        return None
    files: list[Path] = []
    for raw in listed.split(b"\0"):
        if not raw:
            continue
        relative = Path(os.fsdecode(raw))
        if ".git" in relative.parts:
            continue
        path = root / relative
        if path.is_file():
            files.append(path)
    return files


def _git_output(
    root: Path,
    args: Sequence[str],
    binary: bool = False,
) -> str | bytes | None:
    try:
        completed = subprocess.run(
            ["git", "-C", os.fspath(root), *args],
            check=False,
            capture_output=True,
        )
    except OSError:
        return None
    if completed.returncode != 0:
        return None
    if binary:
        return completed.stdout
    return completed.stdout.decode("utf-8", errors="surrogateescape").strip()


def _read_text(path: Path) -> str | None:
    try:
        data = path.read_bytes()
    except OSError:
        return None
    if b"\0" in data:
        return None
    try:
        return data.decode("utf-8")
    except UnicodeDecodeError:
        return None


def _deprecated_violations(relative: Path, text: str) -> list[str]:
    folded = text.casefold()
    violations: list[str] = []
    for term in DEPRECATED_TERMS:
        if term.casefold() in folded:
            violations.append(
                f"{relative.as_posix()}: deprecated terminology: {term}"
            )
    return violations


def _placeholder_violations(relative: Path, text: str) -> list[str]:
    if _normalized_body(text) in PLACEHOLDER_TEXT:
        return [f"{relative.as_posix()}: placeholder"]
    return []


def _normalized_body(text: str) -> str:
    body = " ".join(
        line.strip() for line in _content_lines(text) if line.strip()
    )
    return body.casefold().strip(_TRAILING_PUNCTUATION)


def _content_lines(text: str) -> list[str]:
    raw = text.splitlines()
    skipped: set[int] = set()
    in_fence = False
    fence_char = ""
    fence_length = 0
    for index, line in enumerate(raw):
        fence = _fence_marker(line)
        if fence is not None:
            if not in_fence:
                in_fence = True
                fence_char, fence_length = fence
            elif fence[0] == fence_char and fence[1] >= fence_length:
                in_fence = False
            continue
        if in_fence:
            continue
        if _ATX_HEADING.match(line):
            skipped.add(index)
            continue
        if index == 0 or not _SETEXT_UNDERLINE.match(line):
            continue
        previous = index - 1
        if previous in skipped or not raw[previous].strip():
            continue
        skipped.add(previous)
        skipped.add(index)
    return [line for index, line in enumerate(raw) if index not in skipped]


def _account_allowed(value: str) -> bool:
    return value in _ALLOWED_ACCOUNT_IDS


def _historical_banner_violations(relative: Path, text: str) -> list[str]:
    if relative in ARCHIVE_CURRENT_PAGES:
        return []
    for line in text.splitlines():
        if not line.strip():
            continue
        if line.strip() == HISTORICAL_BANNER:
            return []
        break
    return [f"{relative.as_posix()}: missing historical banner"]


def _sensitive_identifier_violations(relative: Path, text: str) -> list[str]:
    violations: list[str] = []
    seen: set[str] = set()

    def add(kind: str, value: str) -> None:
        key = f"{kind}:{value.casefold()}"
        if key in seen:
            return
        seen.add(key)
        violations.append(f"{relative.as_posix()}: {kind}: {value}")

    for match in _ACCOUNT_ID.finditer(text):
        value = match.group(0)
        if not _account_allowed(value):
            add("account identifier", value)
    for match in _ARN.finditer(text):
        value = match.group(0)
        account_ids = _ACCOUNT_ID.findall(value)
        if not account_ids or any(not _account_allowed(item) for item in account_ids):
            add("cloud resource name", value)
    for match in _GUID.finditer(text):
        value = match.group(0)
        if value.casefold() not in _ALLOWED_GUIDS:
            add("tenant identifier", value)
    for match in _EMAIL.finditer(text):
        value = match.group(0)
        domain = value.rpartition("@")[2].casefold()
        if domain not in _ALLOWED_EMAIL_DOMAINS and not domain.endswith("." + "example"):
            add("email address", value)
    return violations


def _local_path_violations(relative: Path, text: str) -> list[str]:
    violations: list[str] = []
    seen: set[str] = set()
    for pattern in LOCAL_PATH_PATTERNS:
        for match in pattern.finditer(text):
            value = match.group(0)
            if value in seen:
                continue
            seen.add(value)
            violations.append(f"{relative.as_posix()}: machine-local path: {value}")
    return violations


def _link_violations(
    root: Path,
    source: Path,
    relative: Path,
    text: str,
) -> list[str]:
    violations: list[str] = []
    for raw in _inline_link_targets(_without_fenced_code(text)):
        if _repository_relative_path(raw) is None:
            continue
        if _target_exists(root, source, raw):
            continue
        violations.append(f"{relative.as_posix()}: missing link target: {raw}")
    return violations


def _module_url_violations(root: Path) -> list[str]:
    violations: list[str] = []
    for compatibility, canonical in MODULE_URL_PAIRS:
        compatibility_path = root / compatibility
        canonical_path = root / canonical
        if not compatibility_path.is_file():
            violations.append(
                f"{compatibility.as_posix()}: module URL contract: missing page"
            )
        if not canonical_path.is_file():
            violations.append(
                f"{canonical.as_posix()}: module URL contract: missing page"
            )
        if not compatibility_path.is_file():
            continue
        text = _read_text(compatibility_path)
        if text is not None and _links_to(root, compatibility_path, text, canonical):
            continue
        violations.append(
            f"{compatibility.as_posix()}: module URL contract: "
            f"missing link to {canonical.as_posix()}"
        )
    return violations


def _topic_index_violations(root: Path) -> list[str]:
    path = root / TOPIC_INDEX_FILE
    if not path.is_file():
        return [f"{TOPIC_INDEX_FILE.as_posix()}: missing topic index"]
    text = _read_text(path)
    if text is None:
        return [f"{TOPIC_INDEX_FILE.as_posix()}: unreadable topic index"]
    blocks = _yaml_fence_blocks(text)
    if not blocks:
        return [f"{TOPIC_INDEX_FILE.as_posix()}: missing yaml entries"]
    entries: list[dict[str, object]] = []
    violations: list[str] = []
    seen_ids: set[str] = set()
    source_to_entry: dict[Path, str] = {}
    all_paths = _iter_files(root)
    all_relative = {
        item.relative_to(root) for item in all_paths if item.suffix.casefold() == ".md"
    }
    active_pages = _topic_index_active_pages(all_relative)
    for block_number, block in enumerate(blocks, start=1):
        try:
            loaded = yaml.safe_load(block)
        except yaml.YAMLError as error:
            violations.append(
                f"{TOPIC_INDEX_FILE.as_posix()}: yaml block {block_number} parse error: {error}"
            )
            continue
        if not isinstance(loaded, list):
            violations.append(
                f"{TOPIC_INDEX_FILE.as_posix()}: yaml block {block_number} is not a list"
            )
            continue
        for index, item in enumerate(loaded, start=1):
            label = (
                f"{TOPIC_INDEX_FILE.as_posix()}: block {block_number} entry {index}"
            )
            if not isinstance(item, dict):
                violations.append(f"{label}: entry is not a mapping")
                continue
            entries.append(item)
            unknown = set(item) - TOPIC_INDEX_ALLOWED_FIELDS
            for key in sorted(unknown):
                violations.append(f"{label}: unknown field: {key}")
            missing = TOPIC_INDEX_REQUIRED_FIELDS - set(item)
            for key in sorted(missing):
                violations.append(f"{label}: missing required field: {key}")
            if missing:
                continue
            violations.extend(_topic_index_entry_type_violations(label, item))
            entry_id = str(item.get("id", ""))
            if TOPIC_INDEX_ID.fullmatch(entry_id) is None:
                violations.append(f"{label}: invalid id format: {entry_id}")
            elif entry_id in seen_ids:
                violations.append(f"{label}: duplicate id: {entry_id}")
            else:
                seen_ids.add(entry_id)
            source_target = _path_and_anchor(str(item.get("source", "")))
            if source_target is None:
                violations.append(f"{label}: invalid source: {item.get('source')}")
                continue
            source_relative, source_anchor = source_target
            source_path = (path.parent / source_relative).resolve()
            try:
                source_repo = source_path.relative_to(root)
            except ValueError:
                violations.append(f"{label}: source escapes repository: {source_relative}")
                continue
            if not source_path.is_file():
                violations.append(f"{label}: source missing: {source_relative}")
                continue
            if ARCHIVE_PART in source_repo.parts:
                violations.append(f"{label}: source cannot be archived: {source_repo.as_posix()}")
            if source_repo in TOPIC_INDEX_EXEMPT_PAGES or source_repo in TOPIC_INDEX_COMPATIBILITY_PAGES:
                violations.append(f"{label}: source cannot be exempt page: {source_repo.as_posix()}")
            existing = source_to_entry.get(source_repo)
            if existing is not None:
                violations.append(
                    f"{label}: duplicate source page: {source_repo.as_posix()} (already used by {existing})"
                )
            else:
                source_to_entry[source_repo] = entry_id
            source_text = _read_text(source_path) or ""
            if source_anchor:
                slugs = _markdown_heading_slugs(source_text)
                if source_anchor not in slugs:
                    violations.append(
                        f"{label}: source anchor missing: {source_repo.as_posix()}#{source_anchor}"
                    )
            violations.extend(
                _topic_index_declared_label_violations(label, item, source_repo, source_text)
            )
            violations.extend(
                _topic_index_link_list_violations(
                    root,
                    path.parent,
                    label,
                    item,
                    source_repo,
                )
            )
    missing_pages = sorted(page for page in active_pages if page not in source_to_entry)
    for page in missing_pages:
        violations.append(
            f"{TOPIC_INDEX_FILE.as_posix()}: missing entry for active page: {page.as_posix()}"
        )
    return violations


def _topic_index_entry_type_violations(
    label: str, item: dict[str, object]
) -> list[str]:
    violations: list[str] = []
    if not isinstance(item.get("title"), str):
        violations.append(f"{label}: title must be a string")
    if not isinstance(item.get("summary"), str):
        violations.append(f"{label}: summary must be a string")
    aliases = item.get("aliases")
    if not isinstance(aliases, list) or any(not isinstance(entry, str) for entry in aliases):
        violations.append(f"{label}: aliases must be a list of strings")
    entry_type = item.get("type")
    if not isinstance(entry_type, str) or entry_type not in TOPIC_INDEX_TYPES:
        violations.append(f"{label}: invalid type: {entry_type}")
    if "strength" in item and not isinstance(item.get("strength"), str):
        violations.append(f"{label}: strength must be a string")
    if "status" in item and not isinstance(item.get("status"), str):
        violations.append(f"{label}: status must be a string")
    for field in ("related", "former_paths"):
        if field not in item:
            continue
        value = item[field]
        if not isinstance(value, list) or any(not isinstance(entry, str) for entry in value):
            violations.append(f"{label}: {field} must be a list of strings")
    return violations


def _topic_index_declared_label_violations(
    label: str,
    item: dict[str, object],
    source_repo: Path,
    source_text: str,
) -> list[str]:
    violations: list[str] = []
    expected_strength = _declared_line(source_text, "Strength")
    actual_strength = item.get("strength")
    if expected_strength is None and actual_strength is not None:
        violations.append(
            f"{label}: strength must be omitted for {source_repo.as_posix()}"
        )
    if expected_strength is not None and actual_strength != expected_strength:
        violations.append(
            f"{label}: strength mismatch for {source_repo.as_posix()}: expected '{expected_strength}'"
        )
    expected_status = _declared_line(source_text, "Status")
    actual_status = item.get("status")
    if expected_status is None and actual_status is not None:
        violations.append(
            f"{label}: status must be omitted for {source_repo.as_posix()}"
        )
    if expected_status is not None and actual_status != expected_status:
        violations.append(
            f"{label}: status mismatch for {source_repo.as_posix()}: expected '{expected_status}'"
        )
    return violations


def _topic_index_link_list_violations(
    root: Path,
    base_dir: Path,
    label: str,
    item: dict[str, object],
    source_repo: Path,
) -> list[str]:
    violations: list[str] = []
    for field in ("related", "former_paths"):
        values = item.get(field)
        if not isinstance(values, list):
            continue
        for raw in values:
            target = _path_and_anchor(raw)
            if target is None:
                violations.append(f"{label}: invalid {field} target: {raw}")
                continue
            relative, anchor = target
            candidate = (base_dir / relative).resolve()
            try:
                candidate_repo = candidate.relative_to(root)
            except ValueError:
                violations.append(f"{label}: {field} escapes repository: {raw}")
                continue
            if not candidate.is_file():
                violations.append(f"{label}: {field} missing target: {raw}")
                continue
            if field == "former_paths" and candidate_repo == source_repo:
                violations.append(f"{label}: former_paths cannot include source page")
            if anchor:
                text = _read_text(candidate) or ""
                if anchor not in _markdown_heading_slugs(text):
                    violations.append(
                        f"{label}: {field} anchor missing: {candidate_repo.as_posix()}#{anchor}"
                    )
    return violations


def _topic_index_active_pages(all_relative: set[Path]) -> set[Path]:
    pages: set[Path] = set()
    for relative in all_relative:
        if relative.suffix.casefold() != ".md":
            continue
        if any(part == ".git" for part in relative.parts):
            continue
        if any(relative.as_posix().startswith(prefix + "/") for prefix in TOPIC_INDEX_CONTENT_DIRS):
            pages.add(relative)
    pages.update(TOPIC_INDEX_ROOT_ACTIVE_PAGES)
    for exempt in TOPIC_INDEX_EXEMPT_PAGES | TOPIC_INDEX_COMPATIBILITY_PAGES:
        pages.discard(exempt)
    return pages


def _links_to(root: Path, source: Path, text: str, canonical: Path) -> bool:
    expected = (root / canonical).resolve()
    for raw in _inline_link_targets(_without_fenced_code(text)):
        if _repository_relative_path(raw) is None:
            continue
        candidate = _candidate_target(root, source, raw)
        if candidate == expected:
            return True
    return False


def _target_exists(root: Path, source: Path, raw: str) -> bool:
    candidate = _candidate_target(root, source, raw)
    return candidate is not None and candidate.exists()


def _path_and_anchor(raw: str) -> tuple[str, str] | None:
    target = raw.strip()
    if not target:
        return None
    pieces = urlsplit(target)
    if pieces.scheme.casefold() in _IGNORED_LINK_SCHEMES or pieces.netloc:
        return None
    if pieces.scheme and pieces.scheme.casefold() != "file":
        return None
    path = unquote(pieces.path)
    if not path:
        return None
    return path, unquote(pieces.fragment).casefold()


def _candidate_target(root: Path, source: Path, raw: str) -> Path | None:
    relative = _repository_relative_path(raw)
    if relative is None:
        return None
    candidate = (source.parent / relative).resolve()
    try:
        candidate.relative_to(root)
    except ValueError:
        return None
    return candidate


def _repository_relative_path(raw: str) -> str | None:
    target = raw.strip()
    if not target or target.startswith("#"):
        return None
    pieces = urlsplit(target)
    if pieces.scheme.casefold() in _IGNORED_LINK_SCHEMES or pieces.netloc:
        return None
    if pieces.scheme and pieces.scheme.casefold() != "file":
        return None
    path = unquote(pieces.path)
    if not path:
        return None
    return path


def _declared_line(text: str, label: str) -> str | None:
    pattern = re.compile(rf"^\*\*{re.escape(label)}:\*\*\s*(.+)$", re.MULTILINE)
    match = pattern.search(text)
    if match is None:
        return None
    return match.group(1).strip()


def _yaml_fence_blocks(text: str) -> list[str]:
    blocks: list[str] = []
    lines = text.splitlines()
    in_block = False
    current: list[str] = []
    for line in lines:
        marker = line.strip()
        if marker.startswith("```"):
            language = marker[3:].strip().casefold()
            if not in_block and language in {"yaml", "yml"}:
                in_block = True
                current = []
                continue
            if in_block:
                blocks.append("\n".join(current))
                in_block = False
                current = []
            continue
        if in_block:
            current.append(line)
    return blocks


def _markdown_heading_slugs(text: str) -> set[str]:
    counts: dict[str, int] = {}
    slugs: set[str] = set()
    for line in text.splitlines():
        match = re.match(r"^[ \t]{0,3}#{1,6}[ \t]+(.+?)\s*$", line)
        if match is None:
            continue
        heading = match.group(1).strip()
        if heading.endswith("#"):
            heading = heading.rstrip("#").rstrip()
        base = _heading_slug(heading)
        if not base:
            continue
        count = counts.get(base, 0)
        slug = base if count == 0 else f"{base}-{count}"
        counts[base] = count + 1
        slugs.add(slug)
    return slugs


def _heading_slug(heading: str) -> str:
    slug = heading.casefold()
    slug = re.sub(r"[^\w\s-]", "", slug)
    slug = re.sub(r"\s+", "-", slug)
    slug = re.sub(r"-{2,}", "-", slug)
    return slug.strip("-")


def _without_fenced_code(text: str) -> str:
    """Drop fenced code so example links are not repository links."""
    kept: list[str] = []
    in_fence = False
    fence_char = ""
    fence_length = 0
    for line in text.splitlines():
        fence = _fence_marker(line)
        if fence is not None:
            if not in_fence:
                in_fence = True
                fence_char, fence_length = fence
            elif fence[0] == fence_char and fence[1] >= fence_length:
                in_fence = False
            continue
        if not in_fence:
            kept.append(line)
    return "\n".join(kept)


def _fence_marker(line: str) -> tuple[str, int] | None:
    match = _FENCE_OPEN.match(line)
    if match is None:
        return None
    marker = match.group(1)
    return marker[0], len(marker)


def _inline_link_targets(text: str) -> Iterator[str]:
    cursor = 0
    while True:
        start = text.find("](", cursor)
        if start == -1:
            return
        if _label_start(text, start) is None:
            cursor = start + 2
            continue
        target, end = _read_destination(text, start + 2)
        if target is None:
            cursor = start + 2
            continue
        yield target
        cursor = end


def _label_start(text: str, close_bracket: int) -> int | None:
    index = close_bracket - 1
    while index >= 0 and text[index] != "\n":
        if text[index] == "[" and (index == 0 or text[index - 1] != "\\"):
            return index
        index -= 1
    return None


def _read_destination(text: str, start: int) -> tuple[str | None, int]:
    index = start
    length = len(text)
    while index < length and text[index] in " \t":
        index += 1
    if index >= length:
        return None, start
    if text[index] == "<":
        end = text.find(">", index + 1)
        newline = text.find("\n", index + 1)
        if end == -1 or (newline != -1 and newline < end):
            return None, start
        target = text[index + 1 : end].strip()
        index = end + 1
    else:
        dest_start = index
        depth = 0
        while index < length:
            char = text[index]
            if char == "\\" and index + 1 < length:
                index += 2
                continue
            if char.isspace() or char == "\n":
                break
            if char == "(":
                depth += 1
            elif char == ")":
                if depth == 0:
                    break
                depth -= 1
            index += 1
        target = text[dest_start:index]
        if not target:
            return None, start
    while index < length and text[index] in " \t":
        index += 1
    if index < length and text[index] in "\"'":
        quote = text[index]
        end_quote = text.find(quote, index + 1)
        newline = text.find("\n", index + 1)
        if end_quote == -1 or (newline != -1 and newline < end_quote):
            return None, start
        index = end_quote + 1
        while index < length and text[index] in " \t":
            index += 1
    if index >= length or text[index] != ")":
        return None, start
    return target, index + 1


if __name__ == "__main__":
    sys.exit(main())
