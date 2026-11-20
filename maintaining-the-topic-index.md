# Maintain the topic index with the source

**Strength:** Team default

## The problem

An index only helps when it stays synchronized with the canonical pages. If a page moves, a heading changes, or a strength label changes without an index update, readers and AI retrieval tools can route to stale or broken targets.

## The position

`TOPIC-INDEX.md` is a routing layer, not an authority layer. Every entry must point to the current canonical page in this repository, and every active page covered by the index scope must have exactly one source entry.

Update the index in the same pull request as any documentation change that affects:

- page path, title, or anchors
- page strength or status labels
- page lifecycle (new, removed, superseded, compatibility redirect)
- alias language readers use to find that topic

When a canonical page moves and a compatibility page remains, keep the canonical page in `source` and place the old path in `former_paths`. Do not silently reinterpret a superseded topic as current guidance. Link to the replacement source explicitly.

Do not place model instructions, hidden answer keys, or duplicate authoritative definitions in the index. Summaries are for discovery only.

## What the team expects

- Keep topic IDs stable across title edits.
- Keep one source page per entry and one entry per source page in scope.
- When adding a new section index page, update `TOPIC_INDEX_EXEMPT_PAGES` in `scripts/check_docs.py` or the coverage check will fail.
- Use repository-relative links only.
- Keep aliases factual and source-aligned.
- Update `CHANGELOG.md` when index structure or maintenance process changes.
- Run the documentation checker locally before push.

## Where implementation details live

The checker enforces index integrity in `scripts/check_docs.py` with `--require-topic-index`, and unit tests in `tests/test_check_docs.py`.

Run locally:

- `python3 -m pip install -r requirements.txt`
- `python3 scripts/check_docs.py . --require-module-urls --require-topic-index`
- `python3 -m unittest discover -s tests -v`
