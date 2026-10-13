# Platform Knowledge Base Refresh Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the deprecated-framework-centered repository with a public-safe, high-level knowledge base for the Launch by NTT DATA Platform Engineering team, delivered as five sequential pull requests.

**Architecture:** Active Markdown is organized into principles, practices, standards, a platform map, and non-canonical new ideas. Historical procedures move under `archive/`; component repositories continue to own detailed mechanics. A dependency-free Python checker enforces active-content boundaries, links, path portability, and stable Terraform module URLs.

**Tech Stack:** GitHub-flavored Markdown, Python 3 standard library, `unittest`, Git, GitHub pull requests.

## Global constraints

- Start every pull-request branch from the latest `origin/main` after the preceding pull request merges.
- Keep active guidance public-safe and free of deprecated-framework terminology.
- Permit historical terminology only below `archive/`.
- Do not commit private repository links, client details, account or tenant identifiers, personal contact details, transcripts, credentials, or machine-local paths.
- Keep implementation mechanics in their owning repositories; this repository owns durable rationale and team expectations.
- Preserve established Terraform module-definition URLs with compatibility pages.
- Use plain Markdown; do not add a site generator.
- Do not change the repository license.
- Do not create empty placeholder pages or directories.
- Sign every commit as `Ben Vaughan <ben.vaughan@nttdata.com>`.
- Before every push, merge the latest `origin/main`, run the repository's documentation checker, and run `pre-commit run --all-files` if `.pre-commit-config.yaml` exists.
- Treat every push, pull-request creation, and pull-request update as a draft-and-approve remote write.

## File structure

The completed active tree has these responsibilities:

- `README.md`: audience, purpose, content status, and navigation.
- `principles/`: durable reasons for the team's engineering posture.
- `practices/`: application of those principles to delivery and operations.
- `standards/`: supported team defaults and compatibility contracts.
- `standards/terraform/modules/`: canonical module-type definitions.
- `platform/`: capability-level map with links to public owning repositories.
- `new-ideas/`: explicitly non-canonical proposals.
- `archive/`: sanitized historical material and migration disposition.
- `scripts/check_docs.py`: repository-specific documentation validation.
- `tests/test_check_docs.py`: isolated checker behavior tests.

The approved design is:

- `docs/superpowers/specs/2026-10-13-platform-knowledge-base-refresh-design.md`

---

## Pull request 1: Foundation and archive

### Task 1: Add the documentation checker

**Files:**

- Create: `scripts/check_docs.py`
- Create: `tests/test_check_docs.py`

**Interfaces:**

- `check_repository(root: Path, require_module_urls: bool = False) -> list[str]`
- `main(argv: Sequence[str] | None = None) -> int`
- CLI: `python3 scripts/check_docs.py [ROOT] [--require-module-urls]`
- Exit `0`: no violations.
- Exit `1`: print one repository-relative violation per line, sorted.

- [ ] **Step 1: Write isolated failing tests**

Create `tests/test_check_docs.py` with `unittest` and `tempfile.TemporaryDirectory`.
Cover these exact cases:

```python
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
```

In the test helper, use a synthetic marker such as `DEPRECATED_FRAMEWORK_TERM`
instead of the real acronym. Pass it to `check_repository` through a module
constant patched by the test so the test file itself does not violate the
active-content rule.

- [ ] **Step 2: Verify the tests fail**

Run:

```bash
python3 -m unittest tests/test_check_docs.py -v
```

Expected: import failure because `scripts.check_docs` does not exist.

- [ ] **Step 3: Implement the checker**

Implement with the Python standard library only:

```python
ARCHIVE_PART = "archive"
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
    re.compile(r"\b" + re.escape("file" + "://") + r"[^\s)]+"),
    re.compile(r"\b[A-Za-z]:([/\\])Users\1[^`\s)]+"),
)
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
```

Implementation requirements:

1. Recursively inspect tracked-style Markdown and image links below `root`;
   skip `.git/`.
2. Treat any path containing the `archive` path component as historical.
3. In active Markdown, reject each case-folded entry in `DEPRECATED_TERMS`.
   Keep the source fragments split so the checker does not report its own
   source file.
4. Strip Markdown headings and whitespace before checking for empty or
   placeholder-only active pages. Reject bodies containing only a standard
   placeholder marker.
5. Reject macOS, Linux, Windows, and local-filesystem URI paths in all tracked
   text, including the archive. A Windows user-profile path is machine-local
   when a drive letter and colon are followed by one backslash or one forward
   slash, the Users directory, and that same separator.
6. Parse inline Markdown links and images. Ignore `http`, `https`, `mailto`,
   and heading-only links. URL-decode repository-relative targets, remove
   query strings and fragments, resolve from the source file, and require the
   target to exist below `root`.
7. When `require_module_urls` is true, require every path in
   `MODULE_URL_PAIRS`. Require each compatibility page to link to its paired
   canonical page.
8. Return sorted, repository-relative messages and never modify files.

- [ ] **Step 4: Verify unit tests pass**

Run:

```bash
python3 -m unittest tests/test_check_docs.py -v
```

Expected: all tests pass.

- [ ] **Step 5: Confirm the checker exposes current migration work**

Run:

```bash
python3 scripts/check_docs.py .
```

Expected: exit `1` with deprecated terminology, placeholder pages, broken
relative links, or machine-local paths from the current tree. Save the output
for Task 3; do not weaken checks to make the baseline pass.

- [ ] **Step 6: Commit**

Run:

```bash
python3 ~/code/ben/local_scripts/git_identity_guard.py assert
git add scripts/check_docs.py tests/test_check_docs.py
git commit -S -m "Add documentation validation"
```

### Task 2: Establish navigation, status, and idea incubation

**Files:**

- Rewrite: `README.md`
- Create: `principles/README.md`
- Create: `practices/README.md`
- Rewrite: `standards/README.md`
- Rewrite: `platform/README.md`
- Create: `new-ideas/README.md`
- Create: `new-ideas/idea-template.md`
- Create: `archive/README.md`
- Create: `archive/content-disposition.md`

**Interfaces:**

- Root navigation exposes only active sections, `new-ideas/`, and the archive
  entry point.
- Section indexes explain scope and status; they do not promise nonexistent
  pages.
- `new-ideas/idea-template.md` defines the proposal lifecycle.

- [ ] **Step 1: Rewrite the root page**

Include:

- purpose: the public knowledge base for the Launch by NTT DATA Platform Engineering team;
- primary audience: platform engineers, readable by external engineers;
- definitions of principle, practice, standard, platform map, and new idea;
- a statement that implementation detail belongs with the owning component;
- links only to section indexes that exist in this pull request; and
- an archive warning without naming the deprecated framework in active text.

Remove product marketing, unsupported capability claims, the broken contact
link, and procedural getting-started links.

- [ ] **Step 2: Add active section indexes**

Each index must explain:

- what belongs in that section;
- what does not belong there;
- the editorial questions active pages answer; and
- links to currently existing substantive pages only.

Do not add a page merely to reserve a future title.

- [ ] **Step 3: Add the new-idea template**

Use these exact headings:

```markdown
# <Idea title>

**Status:** Exploring
**Owner:** <team or role>
**Last reviewed:** YYYY-MM-DD

## Problem or opportunity
## Current hypothesis
## Why this may be worth pursuing
## Trade-offs and open questions
## Evidence or experiments needed
## Promotion or abandonment criteria
```

Explain in `new-ideas/README.md` that proposals are neither commitments nor
supported standards.

- [ ] **Step 4: Start the disposition record**

In `archive/content-disposition.md`, define the four outcomes: rewritten,
retained, archived, and removed. Record the path-level decisions implemented
in Task 3. Do not include private source locations.

- [ ] **Step 5: Run focused validation**

Run:

```bash
python3 -m unittest tests/test_check_docs.py -v
git diff --check
```

Expected: unit tests pass and no whitespace errors.

- [ ] **Step 6: Commit**

Run:

```bash
python3 ~/code/ben/local_scripts/git_identity_guard.py assert
git add README.md principles/README.md practices/README.md standards/README.md \
  platform/README.md new-ideas archive/README.md archive/content-disposition.md
git commit -S -m "Add knowledge base navigation"
```

### Task 3: Move historical material and remove false scaffolding

**Files:**

- Move: `platform/common-automation-framework/` to
  `archive/framework-era/platform/common-automation-framework/`
- Move: `platform/development-environments/` to
  `archive/framework-era/platform/development-environments/`
- Move: `standards/iac-development/terraform/module/wrapper/deploy/` to
  `archive/framework-era/standards/iac-development/terraform/module/wrapper/deploy/`
- Move: `platform/pipeline/iac/azure-subscription-bootstrapping/` to
  `archive/framework-era/platform/pipeline/iac/azure-subscription-bootstrapping/`
- Modify: `archive/content-disposition.md`
- Remove: empty Markdown and `.keep` scaffolding under `platform/pipeline/`,
  `platform/infrastructure/`, `standards/common-development/`,
  `standards/iac-development/`, and
  `platform/development-environments/serverless/`
- Remove after inventory: directories left empty by those deletions

**Interfaces:**

- `archive/framework-era/` contains historical framework procedures and their
  supporting assets.
- No active file contains deprecated-framework terminology.
- No active Markdown file is empty or placeholder-only.

- [ ] **Step 1: Inventory sensitive strings before moving**

Search the material to be archived for:

- cloud account IDs and ARNs;
- tenant and subscription identifiers;
- email addresses and personal names;
- absolute filesystem paths;
- credentials, tokens, certificate material, and secret-like values; and
- client or former-company hostnames.

Record each affected path in local review notes. Do not commit the sensitive
values to the disposition record.

- [ ] **Step 2: Move historical directories with `git mv`**

Create the archive hierarchy and use `git mv` so Git can preserve rename
history. Do not copy files and leave active duplicates.

- [ ] **Step 3: Sanitize or remove unsafe archived artifacts**

For prose and diagrams that remain useful, replace sensitive values with
obvious neutral examples. Remove configuration examples or screenshots when
redaction would make them misleading or when they contain operational
secrets. Historical terminology may remain.

- [ ] **Step 4: Delete empty scaffolding**

Use the checker output from Task 1 to remove placeholder-only Markdown.
Remove `.keep`-only infrastructure trees. Preserve non-empty documents until
their rewrite, archive, or removal task later in the series.

- [ ] **Step 5: Complete the PR 1 disposition entries**

For every move or deletion in this task, record:

- former path or path family;
- outcome (`archived` or `removed`);
- archive destination when applicable; and
- one-sentence reason.

- [ ] **Step 6: Verify the active/archive boundary**

Run:

```bash
python3 scripts/check_docs.py .
python3 -m unittest tests/test_check_docs.py -v
git diff --check
```

Expected: all commands exit `0`.

- [ ] **Step 7: Commit**

Run:

```bash
python3 ~/code/ben/local_scripts/git_identity_guard.py assert
git add -A
git commit -S -m "Archive obsolete platform documentation"
```

### Task 4: Review and hand off pull request 1

- [ ] **Step 1: Review the complete branch**

Check that:

- moves are separated from substantive active prose where Git permits;
- archived files do not leak sensitive values;
- root navigation does not present the archive as current;
- no non-empty legacy file disappeared without a disposition; and
- the design specification still matches the implementation.

- [ ] **Step 2: Run branch validation**

Run:

```bash
python3 scripts/check_docs.py .
python3 -m unittest discover -s tests -v
git diff --check origin/main...HEAD
git status --short
```

Expected: checks pass and the worktree is clean.

- [ ] **Step 3: Prepare the remote-write draft**

Draft a pull-request title and body summarizing:

- the new active/archive boundary;
- material moved or removed;
- sanitization performed;
- checker coverage; and
- explicit exclusions.

Present the draft and exact push/create commands for user approval. Do not
push or create the pull request without that approval.

- [ ] **Step 4: Before an approved push, synchronize and validate**

Run:

```bash
git fetch origin main
git merge origin/main
python3 scripts/check_docs.py .
python3 -m unittest discover -s tests -v
if test -f .pre-commit-config.yaml; then pre-commit run --all-files; fi
```

Resolve any conflict before pushing. If the merge cannot be resolved safely,
stop instead of opening a conflicting pull request.

---

## Pull request 2: Principles

### Task 5: Publish the core platform engineering principles

**Files:**

- Rewrite: `principles/README.md`
- Create: `principles/outcomes-over-activity.md`
- Create: `principles/trust-and-evidence.md`
- Create: `principles/stewardship-and-enablement.md`
- Create: `principles/safe-speed-and-accountability.md`
- Create: `principles/rigor-follows-dependency.md`
- Rewrite: `principles/single-purpose-repository-principle.md`
- Rewrite: `principles/self-contained-repository-deployment-principle.md`
- Rewrite: `strategies/poly-git-repo-strategy.md`
- Modify: `archive/content-disposition.md`

**Interfaces:**

- Every principle follows the four-question editorial contract.
- `strategies/poly-git-repo-strategy.md` remains as a compatibility page that
  frames poly-repo as a contextual strategy and links to the repository
  principle.

- [ ] **Step 1: Write outcomes, trust, and stewardship**

Use these content requirements:

- platform systems are means to safer, repeatable, confident delivery;
- success is measured by team capability, confidence in change, and trust;
- trust is built through reliability, evidence, approachability, and
  follow-through;
- platform work should leave people and systems more capable; and
- avoid generic claims that could describe any organization without an
  observable engineering implication.

- [ ] **Step 2: Write safe speed and dependency-based rigor**

Explain:

- deterministic controls counterbalance increased human and agent velocity;
- humans remain accountable for consequential actions;
- temporary human approval gates are conscious debt, not permanent design;
- experiments can be lightweight; shared and production dependencies require
  stronger contracts, tests, ownership, and recovery; and
- automation should improve the constrained system, not merely accelerate
  upstream work.

- [ ] **Step 3: Rewrite repository principles**

For the single-purpose principle:

- define a repository around one independently understandable lifecycle;
- distinguish cohesion from artificially tiny repositories;
- require explicit contracts between repositories; and
- present poly-repo as the common Launch default, not universal truth.

For self-contained delivery:

- require build, test, release, deployment, and observability ownership to be
  discoverable from the repository;
- allow external shared services through explicit contracts;
- do not require secrets or environment-specific values in source; and
- avoid prescribing obsolete bootstrap tooling.

- [ ] **Step 4: Update navigation and disposition**

Link every new principle from `principles/README.md`. Record which legacy
principle and strategy pages were rewritten or retained.

- [ ] **Step 5: Validate and commit**

Run:

```bash
python3 scripts/check_docs.py .
git diff --check
python3 ~/code/ben/local_scripts/git_identity_guard.py assert
git add principles strategies/poly-git-repo-strategy.md \
  archive/content-disposition.md
git commit -S -m "Refresh platform engineering principles"
```

### Task 6: Review and hand off pull request 2

Repeat Task 4's review, validation, synchronization, draft, and approval
steps. Add an editorial check that each normative sentence is identifiable as
a principle, team default, or contextual choice.

---

## Pull request 3: Core practices

### Task 7: Publish delivery and application-boundary practices

**Files:**

- Rewrite: `practices/README.md`
- Create: `practices/application-platform-boundary.md`
- Create: `practices/trustworthy-software-delivery.md`
- Create: `practices/infrastructure-as-software.md`
- Rewrite: `platform/continuous-deployment/immutable-application-deployment/README.md`
- Rewrite: `platform/continuous-deployment/evolutionary-database-deployment/README.md`
- Move: `platform/continuous-deployment/kubernetes/README.md` to
  `archive/pre-refresh/platform/continuous-deployment/kubernetes/README.md`
- Modify: `archive/content-disposition.md`

**Interfaces:**

- Practice pages explain behavior and decision boundaries.
- Existing immutable-application and evolutionary-database URLs remain useful
  after their content is rewritten. The Kubernetes page is archived after its
  durable delivery ideas are incorporated into the active practice.

- [ ] **Step 1: Write the application-platform boundary**

Cover:

- application and platform form one production system;
- requests begin discovery rather than order taking;
- the working loop is Understand, Ground, Recommend, Validate;
- application teams retain application decisions;
- platform engineers bring delivery, infrastructure, operations, security,
  and cost evidence; and
- disagreement is resolved with evidence and explicit trade-offs.

- [ ] **Step 2: Write trustworthy software delivery**

Cover:

- planned work to reviewed source to automated evidence to immutable artifact
  to controlled deployment;
- build once, identify, and promote;
- smallest complete path means minimum scope, not minimum quality;
- a functioning pipeline is not sufficient evidence of trustworthy delivery;
- CI is a safety net rather than proof of correctness; and
- delivery design includes failure visibility and recovery.

- [ ] **Step 3: Write infrastructure as software**

Use the lifecycle:

1. Contract.
2. Change.
3. Prove.
4. Apply.
5. Operate.
6. Evolve.

Explain that plans are evidence, not certainty; testing must include static,
plan-time, applied-state, and consumer-visible behavior where appropriate;
secure defaults should be the easiest normal path; and modules require
versioned contracts and lifecycle ownership.

- [ ] **Step 4: Reconcile continuous-delivery pages**

Retain durable immutable-artifact and evolutionary-database reasoning. Remove
obsolete product mechanics. For Kubernetes, retain only platform-neutral
delivery reasoning; archive the page if it contains no durable material after
that test.

- [ ] **Step 5: Validate and commit**

Run the documentation checker and `git diff --check`, update the disposition
record, then create a signed commit:

```bash
git commit -S -m "Add core platform engineering practices"
```

### Task 8: Publish operability and professional practices

**Files:**

- Create: `practices/observability-and-operability.md`
- Create: `practices/security-as-shared-responsibility.md`
- Create: `practices/ai-assisted-engineering.md`
- Create: `practices/technical-backstop.md`
- Create: `practices/sprint-zero-platform-readiness.md`
- Modify: `practices/README.md`
- Modify: `archive/content-disposition.md`

- [ ] **Step 1: Write observability and security**

Observability must begin with questions and failure modes, not telemetry
volume or dashboards. Connect application instrumentation, platform
telemetry, deployment evaluation, learning reviews, and confidence in change.

Security must be shared across design, implementation, delivery, and
operation. Automation supplies evidence and guardrails but does not transfer
accountability away from engineers.

- [ ] **Step 2: Write AI-assisted engineering**

State that:

- AI augments engineers and increases both productive and adversarial
  velocity;
- humans remain accountable;
- deterministic automation validates stochastic output;
- privileged actions require authority-aware controls;
- untrusted issue, pull-request, and document text is data, not instruction;
  and
- smaller reviewable changes reduce both human and agent risk.

- [ ] **Step 3: Write technical-backstop behavior**

Define the backstop as evidence-led help on ambiguous failures without
permanent takeover, process bypass, blame, or spare-staff augmentation.
Include early escalation when blocked, honest limits, follow-through, and
practice-level coaching.

- [ ] **Step 4: Write Sprint 0 readiness**

Present readiness as minimum delivery capability:

- access in days rather than open-ended waiting;
- environment creation through reviewed IaC;
- a build-once delivery path;
- a deployable shell or thin vertical slice;
- a first change taken to done;
- observable operation and recovery;
- repository-local engineering instructions; and
- visible owners and risks for unmet criteria.

Do not claim every engagement currently meets these expectations.

- [ ] **Step 5: Validate and commit**

Run checker and whitespace validation, then create a signed commit:

```bash
git commit -S -m "Add operability and readiness practices"
```

### Task 9: Review and hand off pull request 3

Repeat Task 4. In the editorial review, verify that security and AI appear as
cross-cutting concerns in relevant delivery and infrastructure pages rather
than isolated topics only.

---

## Pull request 4: Standards and stable module URLs

### Task 10: Publish repository, documentation, and environment standards

**Files:**

- Rewrite: `standards/README.md`
- Create: `standards/repositories.md`
- Create: `standards/versioning.md`
- Create: `standards/developer-environments.md`
- Create: `standards/documentation.md`
- Create: `standards/evidence-and-verification.md`
- Move: remaining substantive `standards/common-development/` material to
  `archive/pre-refresh/standards/common-development/` after extraction
- Modify: `archive/content-disposition.md`

- [ ] **Step 1: Write repository and versioning standards**

Specify:

- cohesive, independently reviewable and releasable repository boundaries;
- explicit dependency contracts;
- semantic versioning for reusable artifacts;
- immutable release identifiers;
- compatibility and migration notes for breaking changes; and
- naming conventions that communicate provider, artifact class, and purpose
  without encoding obsolete product branding.

- [ ] **Step 2: Write developer-environment and documentation standards**

Developer environments must be reproducible, version toolchains with the
repository, minimize host mutation, and document required credentials without
embedding them. Avoid prescribing one editor or operating system.

Documentation standards must enforce the principle/practice/standard split,
component ownership of mechanics, evidence-backed claims, public-safe
examples, and reviewed compatibility links.

- [ ] **Step 3: Write evidence and verification standards**

Define Confirmed, Inferred, and Unavailable. Require current evidence for
external state, honest reporting of unrun checks, behavior-focused tests, and
explicit validation boundaries.

- [ ] **Step 4: Archive extracted common-development material**

After the new standards preserve durable ideas, move stale naming, tagging,
Java diagram, and other remaining old common-development pages to
`archive/pre-refresh/`. Do not preserve empty placeholders.

- [ ] **Step 5: Validate and commit**

Run the checker and create a signed commit:

```bash
git commit -S -m "Add engineering standards"
```

### Task 11: Publish canonical Terraform standards and compatibility pages

**Files:**

- Create: `standards/terraform/README.md`
- Create: `standards/terraform/modules/primitive.md`
- Create: `standards/terraform/modules/collection.md`
- Create: `standards/terraform/modules/reference-architecture.md`
- Create: `standards/terraform/modules/library.md`
- Create: `standards/terraform/testing.md`
- Create: `standards/terraform/version-compatibility.md`
- Rewrite: `standards/iac-development/terraform/module/primitive/README.md`
- Rewrite: `standards/iac-development/terraform/module/collection/README.md`
- Rewrite:
  `standards/iac-development/terraform/module/reference-architecture/README.md`
- Rewrite: `standards/iac-development/terraform/module/library/README.md`
- Archive: remaining superseded `standards/iac-development/` content under
  `archive/pre-refresh/standards/iac-development/`
- Modify: `scripts/check_docs.py`
- Modify: `tests/test_check_docs.py`
- Modify: `archive/content-disposition.md`

**Interfaces:**

- Canonical module pages define current taxonomy.
- Old URLs are compatibility pages with direct relative links.
- `python3 scripts/check_docs.py . --require-module-urls` enforces both sets.

- [ ] **Step 1: Define primitive modules**

State that a primitive:

- represents one cloud resource type;
- stays client and business-logic agnostic;
- exposes provider capability through a deliberate, testable contract;
- uses secure defaults where a safe general default exists;
- contains no configured provider block; and
- has a complete example plus apply/destroy and composability evidence.

- [ ] **Step 2: Define collection and reference-architecture modules**

A collection composes related primitives behind a reusable contract without
introducing overlapping bare service resources.

A reference architecture composes primitives and collections into an
opinionated, production-oriented capability. It explains its assumptions,
integration boundaries, and consumer-facing verification.

Both must use sibling Launch primitives when a compatible, non-overlapping
primitive exists.

- [ ] **Step 3: Resolve library-module status**

Current kit taxonomy does not identify `library` as a supported module type.
Document it as a historical category and direct readers to the current
collection/reference model. Before publishing, verify this against current
public repositories and generator configuration. If that evidence shows an
active creation, testing, and release path for library modules, stop and ask
the documentation owner to approve a taxonomy correction rather than silently
changing the plan.

- [ ] **Step 4: Write testing and version compatibility**

Testing standards must include:

- full apply/destroy as the functional baseline;
- readonly composability checks for existing infrastructure;
- assertions on configured values, not only provider round trips;
- real consumer-visible checks for composed capabilities; and
- documented justification for reduced coverage.

Version standards must include:

- empirical testing at the declared Terraform floor;
- root and example constraints that do not contradict each other;
- provider floors based on features actually used; and
- explicit compatibility impact for major provider upgrades.

- [ ] **Step 5: Rewrite old paths as compatibility pages**

Each old page must:

- identify itself as a compatibility location;
- link directly to its canonical page with a repository-relative link;
- contain no duplicate definition; and
- contain no deprecated-framework terminology.

- [ ] **Step 6: Extend checker tests before enforcement**

Add tests that:

- pass when all eight module paths exist and every old page links to its
  canonical target;
- fail when one old page is absent;
- fail when one canonical page is absent; and
- fail when a compatibility page links to the wrong canonical page.

Run the tests and confirm the new wrong-link test fails before modifying
`check_docs.py`.

- [ ] **Step 7: Enforce and verify the URL contract**

Implement the tested URL-pair checks, then run:

```bash
python3 -m unittest tests/test_check_docs.py -v
python3 scripts/check_docs.py . --require-module-urls
git diff --check
```

Expected: all checks pass.

- [ ] **Step 8: Commit**

Create a signed commit:

```bash
git commit -S -m "Publish Terraform module standards"
```

### Task 12: Place Helm direction in new ideas

**Files:**

- Create: `new-ideas/helm.md`
- Move: `standards/helm-development/` to
  `archive/pre-refresh/standards/helm-development/`
- Modify: `new-ideas/README.md`
- Modify: `archive/content-disposition.md`

- [ ] **Step 1: Write the Helm proposal**

Use the idea template. Frame the current hypothesis around reusable chart
contracts, deployment versus library charts, secure defaults, testing, and
clear ownership. Explicitly state that this is direction under evaluation,
not a current team standard.

- [ ] **Step 2: Record promotion evidence**

Require evidence from maintained chart repositories, repeatable validation,
consumer experience, upgrade behavior, and an identified owner before
promotion to `standards/`.

- [ ] **Step 3: Archive prior Helm guidance**

Move the old material after extracting still-useful ideas. Add its disposition
and ensure active navigation points only to the proposal.

- [ ] **Step 4: Validate and commit**

Run the checker and create a signed commit:

```bash
git commit -S -m "Add Helm direction proposal"
```

### Task 13: Review and hand off pull request 4

Repeat Task 4, using:

```bash
python3 scripts/check_docs.py . --require-module-urls
```

Manually open all four old module URLs in GitHub's rendered-file view or
equivalent local link resolution and verify that each reaches the intended
canonical definition in one click.

---

## Pull request 5: Platform map and reconciliation

### Task 14: Publish the current platform capability map

**Files:**

- Rewrite: `platform/README.md`
- Create: `platform/delivery-automation.md`
- Create: `platform/infrastructure-modules.md`
- Create: `platform/pipeline-templates.md`
- Create: `platform/engineering-assistance.md`
- Create: `platform/readiness-and-developer-experience.md`
- Rewrite: `platform/launch-public-service/terraform-module-registry/README.md`
- Archive or remove after extraction: remaining legacy `platform/pipeline/`
  and `platform/launch-public-service/` content
- Modify: `archive/content-disposition.md`

- [ ] **Step 1: Verify public owning sources**

For each capability, verify the current public repository and its purpose.
Link only to a URL that is publicly readable at implementation time. If a
capability has no public owning source, describe it without exposing a private
repository or internal URL.

- [ ] **Step 2: Write the map and capability pages**

Explain relationships among:

- reusable delivery workflows;
- Terraform skeleton and module templates;
- the reusable Terraform module library;
- reusable pipeline templates;
- agent instruction files and deterministic engineering checks; and
- readiness and developer-experience capabilities.

Describe responsibilities and boundaries, not version pins, fleet counts, or
operator commands.

- [ ] **Step 3: Refresh registry guidance**

Keep durable discovery and consumption concepts. Link to the current public
registry and module sources only after verifying them. Remove obsolete CLI or
deprecated-framework mechanics.

- [ ] **Step 4: Remove the remaining false platform hierarchy**

Archive any substantive historical material, remove empty pipeline and
provider trees, and record every outcome.

- [ ] **Step 5: Validate and commit**

Run required-module URL validation, link checks, and whitespace checks. Create
a signed commit:

```bash
git commit -S -m "Add platform capability map"
```

### Task 15: Complete legacy reconciliation and final editorial review

**Files:**

- Modify: `archive/content-disposition.md`
- Modify as findings require: active Markdown files only

- [ ] **Step 1: Reconcile every legacy document**

Compare the original `origin/main` Markdown inventory with the final tree.
For every non-empty original document, confirm exactly one outcome in
`archive/content-disposition.md`: rewritten, retained, archived, or removed.

- [ ] **Step 2: Review claims and prescriptions**

For every active page:

- remove claims not supported by current evidence;
- label principles, defaults, and context-dependent choices consistently;
- ensure “why” precedes implementation guidance;
- confirm security and AI are cross-cutting;
- verify that the page routes mechanics to an owning source; and
- remove prose that could apply unchanged to any organization without an
  observable engineering implication.

- [ ] **Step 3: Review publication safety**

Scan the complete tracked tree for private URLs, client names, identifiers,
emails, secrets, local paths, and transcript-derived personal material.
Review archive matches manually rather than assuming historical status makes
them acceptable.

- [ ] **Step 4: Run final validation**

Run:

```bash
python3 -m unittest discover -s tests -v
python3 scripts/check_docs.py . --require-module-urls
git diff --check origin/main...HEAD
git status --short
```

Expected: all checks pass and the worktree is clean.

- [ ] **Step 5: Commit final corrections**

If review changed files, create a signed commit:

```bash
git commit -S -m "Complete documentation reconciliation"
```

### Task 16: Review and hand off pull request 5

Repeat Task 4. The pull-request body must include:

- the final active information architecture;
- compatibility URL verification;
- the legacy disposition count by outcome;
- checker and editorial-review results;
- known ideas intentionally left non-canonical; and
- confirmation that detailed mechanics remain in owning repositories.

After an approved push, spot-check the pushed commit signature:

```bash
gh api "repos/launchbynttdata/common-platform-documentation/commits/$(git rev-parse HEAD)" \
  --jq '.commit.verification | {verified, reason}'
```

Expected: `verified` is `true`.

## Final acceptance

The series is complete only when:

- all five pull requests have merged in order;
- active navigation is coherent at each merged stage;
- no active deprecated-framework terminology remains;
- every non-empty legacy document has a disposition;
- archived material is both non-authoritative and public-safe;
- stable module URLs lead to canonical definitions;
- the checker and unit tests pass on final `main`;
- no empty active Markdown remains;
- public platform links resolve to the correct owning source; and
- all authored commits are signed and verified.
