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

_ATX_HEADING = re.compile(r"^[ \t]{0,3}#{1,6}(?:[ \t].*)?$")
_SETEXT_UNDERLINE = re.compile(r"^[ \t]{0,3}(?:=|-){3,}[ \t]*$")
_FENCE_OPEN = re.compile(r"^[ \t]{0,3}(`{3,}|~{3,})")
_IGNORED_LINK_SCHEMES = {"http", "https", "mailto"}
_TRAILING_PUNCTUATION = ".,;:!?\"'"


def check_repository(root: Path, require_module_urls: bool = False) -> list[str]:
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
    args = parser.parse_args(argv)
    violations = check_repository(
        args.root,
        require_module_urls=args.require_module_urls,
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
