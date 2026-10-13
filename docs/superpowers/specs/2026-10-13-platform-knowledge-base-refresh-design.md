# Platform knowledge base refresh design

## Outcome

Refresh this repository into the public, high-level knowledge base for the
Launch by NTT DATA Platform Engineering team: a durable explanation of why
the team works as it does, with clear prescriptions where a team default is
justified.

The first pass will cover the substantive topics represented in the current
repository while separating current guidance from historical procedures.

## Audience and scope

The primary audience is the Launch by NTT DATA Platform Engineering team. The
repository is publicly accessible, so active guidance must also be safe and
understandable for engineers outside the team.

This refresh includes:

- a new information architecture and root navigation;
- current principles, practices, standards, and a high-level platform map;
- an incubation area for ideas that are not ready to become standards;
- a historical archive for obsolete procedures and assets;
- compatibility pages for established Terraform module-definition URLs;
- removal of empty placeholder trees; and
- repeatable checks for documentation-specific invariants.

This refresh does not include:

- a documentation site generator;
- detailed component runbooks that belong in component repositories;
- private agent procedures, fleet operations, or internal account mechanics;
- a redesign of repository CI unrelated to documentation validation; or
- a license change.

## Evidence from the current repository

The current default branch contains 172 Markdown files, of which roughly 118
are empty or nearly empty. The substantive content is split among a small
number of principles and standards, detailed framework-era deployment
procedures, tool setup walkthroughs, and conceptual delivery guidance. The
root page presents the deprecated framework as the product and does not route
readers to most standards or principles.

The repository also contains historical screenshots, diagrams, configuration
examples, tenant and account details, and extensive empty platform and
pipeline hierarchies. These create an appearance of completeness that the
content does not support.

## Source authority

Sources have distinct roles:

1. The platform engineering kit supplies the most current operational lessons
   and technical understanding.
2. Owning component repositories define component behavior, configuration,
   and verification mechanics.
3. The team's platform engineering point of view supplies the thesis, mental
   models, voice, and justified prescriptions.
4. Existing documentation supplies topic coverage, historical intent, and
   material to evaluate; it is not authoritative merely because it already
   exists.

When sources disagree, current observed component behavior takes precedence
for factual claims. The refreshed knowledge base owns durable rationale and
team-level expectations, while fast-changing mechanics remain with their
owning component or operational source.

## Information architecture

### `README.md`

The root page explains the repository's purpose, audience, content types, and
navigation. It distinguishes active guidance, incubating ideas, and historical
material.

### `principles/`

Durable explanations of why the team works this way. Initial topics include:

- outcomes over platform activity;
- trust and evidence;
- stewardship and enablement;
- safe speed and human accountability; and
- rigor that increases as others depend on a capability.

### `practices/`

How the principles shape engineering work. Initial topics include:

- the application-platform boundary;
- trustworthy software delivery;
- infrastructure as a software system;
- observability and operability;
- security as shared responsibility;
- disciplined use of AI-assisted engineering;
- the platform engineer as a technical backstop; and
- Sprint 0 platform readiness.

Security and AI are cross-cutting concerns. Their dedicated explanations do
not remove the obligation to address them in relevant delivery,
infrastructure, and operations guidance.

### `standards/`

Current team defaults and compatibility contracts. Initial topics include:

- repository boundaries and versioning;
- Terraform module taxonomy, composition, testing, and version compatibility;
- evidence and verification expectations;
- documentation ownership and layering; and
- Helm guidance that is sufficiently established to be a team default.

Detailed implementation instructions remain in the repositories that own the
relevant components.

### `platform/`

A capability-level map of the current Launch platform ecosystem. It explains
what each major component is for, how the components relate, and where current
implementation documentation lives. It does not duplicate component
configuration or operating procedures.

### `new-ideas/`

An explicitly non-canonical incubation area. It records intent and direction
without implying that an idea is supported or required.

Each idea must state:

- the problem or opportunity;
- the current hypothesis and intended direction;
- why it may be worth pursuing;
- known trade-offs and open questions;
- evidence or experiments needed;
- an owner and last-reviewed date; and
- criteria for promotion or abandonment.

Partially formed Helm direction and similar topics belong here until they are
ready to become active guidance. Empty placeholder pages are not permitted.

### `archive/`

Historical procedures and assets that remain useful as context but are not
current guidance. The archive is excluded from normal topic navigation and
has a prominent non-authoritative warning.

References to the deprecated framework are permitted only within the archive.
Archived material must still be sanitized to remove credentials, account and
tenant identifiers, personal filesystem paths, personal contact details, and
other information that should not remain in a public repository.

## Editorial contract

Every active guidance page answers:

1. What problem does this address?
2. Why does the team take this position?
3. What does the team expect engineers to do?
4. Where do current implementation details live?

Guidance uses three levels of strength:

- **Principle:** a durable claim expected to survive tool changes.
- **Team default:** a prescriptive choice followed unless a documented reason
  justifies an exception.
- **Context-dependent choice:** a valid pattern whose trade-offs must be
  evaluated locally.

The prose is direct, plainspoken, and evidence-based. It explains why before
what, avoids unsupported absolutes, and labels contextual choices honestly.
Volatile counts, version pins, screenshots, commands, and operational
procedures do not become durable guidance.

Active public documentation must not contain private repository links,
machine-local paths, client details, account identifiers, personal biography,
transcript content, or internal account and authorization mechanics.

## Terraform module URL compatibility

Existing module-definition URLs are already referenced elsewhere and form a
compatibility contract. New canonical definitions will live at:

- `standards/terraform/modules/primitive.md`
- `standards/terraform/modules/collection.md`
- `standards/terraform/modules/reference-architecture.md`
- `standards/terraform/modules/library.md`

The existing pages remain as concise compatibility pages that identify the
new canonical definition and provide a direct link:

- `standards/iac-development/terraform/module/primitive/README.md`
- `standards/iac-development/terraform/module/collection/README.md`
- `standards/iac-development/terraform/module/reference-architecture/README.md`
- `standards/iac-development/terraform/module/library/README.md`

If current evidence shows that a category is no longer part of the supported
taxonomy, its canonical page explains its status and replacement rather than
silently redefining or deleting it.

## Legacy topic disposition

- Framework capability material becomes the current platform purpose and
  ecosystem map.
- Repository and poly-repository principles become principles plus
  repository-boundary standards. Repository topology is not treated as a
  universal principle.
- Continuous delivery and evolutionary database material becomes trustworthy
  delivery guidance.
- Local tool setup becomes a high-level developer-environment standard;
  obsolete step-by-step procedures move to the archive.
- IaC, Terraform, Terragrunt, testing, and module material becomes
  infrastructure-as-software guidance and current Terraform standards.
- Helm material becomes a standard only where present practice supports it;
  otherwise it becomes a documented new idea or is archived.
- Git naming, tagging, and versioning become repository standards.
- Registry and public-service material becomes part of the platform map with
  links to owning repositories.
- Empty architecture, language, provider, infrastructure, and pipeline
  scaffolding is removed.
- Service-specific deprecated-framework walkthroughs and screenshots move to
  the historical archive.

Every non-empty legacy document receives one recorded disposition: rewrite,
retain, archive, or remove.

## Delivery sequence

The refresh is delivered as five sequential, reviewable pull requests. Each
branch starts from the latest default branch after the previous pull request
merges.

### 1. Foundation and archive

- Establish root navigation and the editorial contract.
- Create the historical archive and move obsolete procedures and assets.
- Sanitize archived content.
- Remove empty placeholder trees.
- Add the documentation checker.

### 2. Principles

- Publish the initial principle set.
- Refresh repository and self-contained delivery principles.
- Explain repository topology as a trade-off rather than universal doctrine.

### 3. Core practices

- Publish the application-platform boundary, delivery, infrastructure,
  observability, security, AI, technical-backstop, and Sprint 0 guidance.

### 4. Standards

- Publish repository, versioning, Terraform, testing, evidence,
  documentation-ownership, and supported Helm standards.
- Add canonical module definitions and old-path compatibility pages.

### 5. Platform map and reconciliation

- Publish the current capability-level platform map.
- Reconcile the full legacy-content inventory.
- Complete terminology, privacy, link, and consistency reviews.

## Verification

A small repository-owned documentation checker will provide repeatable
validation across the pull-request series. It will fail when:

- deprecated-framework terminology appears outside `archive/`;
- active Markdown is empty or only a placeholder;
- a repository-relative link or image target is missing;
- a machine-local filesystem path appears in tracked content; or
- a required Terraform module compatibility page or canonical target is
  missing.

Each pull request also receives human editorial review for:

- unsupported factual claims;
- prescriptions stated more broadly than the evidence supports;
- drift between principles, practices, and standards;
- private or sensitive details;
- archive material presented as current guidance; and
- links that resolve but point to the wrong owning source.

## Completion criteria

The first pass is complete when:

- the active repository has clear root navigation;
- every active page follows the editorial contract;
- every substantive legacy document has a recorded disposition;
- no deprecated-framework terminology appears outside the archive;
- historical material is clearly non-authoritative and sanitized;
- established Terraform module URLs lead readers to canonical definitions;
- no empty active documentation remains;
- the platform map links to current owning repositories;
- the documentation checker passes; and
- the five-pull-request series has received editorial review.

## Risks and mitigations

- **The archive dominates the repository.** Keep it out of normal topic
  navigation and place a clear warning at its entry point.
- **Current operational detail becomes stale prose.** Link to owning
  repositories and retain only durable rationale here.
- **Prescriptions become unsupported absolutes.** Label guidance strength and
  require evidence-based editorial review.
- **The migration breaks established links.** Preserve old module paths as
  compatibility pages and test them.
- **Incubating ideas look like promises.** Keep them in `new-ideas/` with
  explicit status, ownership, evidence, and promotion criteria.
- **Large archive moves obscure review.** Separate structural moves from
  substantive rewrites in the pull-request sequence.
