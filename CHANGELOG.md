# Changelog

This file records notable changes to the knowledge base, such as new or rewritten pages, changes to its structure, and changes to how the documentation is checked. Each entry links to the pull request that made the change. Corrections to spelling and minor wording are not listed.

Each open pull request records its changes under "Unreleased", with the pull request number and title in the heading. After that pull request merges, the next pull request replaces "Unreleased" with the merge date.

## Unreleased: #23, Publish core platform engineering practices

### Added

- Eight practice pages: the application and platform boundary, trustworthy software delivery, infrastructure as software, observability, shared security responsibility, AI-assisted engineering, the technical backstop, and the minimum platform path at the start of an engagement.

### Changed

- Rewrote the immutable application deployment and evolutionary database notes into the practice page structure. Their addresses are unchanged.
- Archived the Kubernetes continuous-deployment note after keeping its durable delivery points on the trustworthy-delivery practice.

## 2026-10-19: Publish platform engineering principles ([#22](https://github.com/launchbynttdata/common-platform-documentation/pull/22))

### Added

- Six principle pages: platform work serves delivery outcomes; trust is earned through reliability and evidence; leave people and systems more capable; delivery, security, and observability built in from the start; speed is safe when controls keep pace; and rigor increases as others depend on a capability.
- A page explaining how to read the knowledge base, including document types, page structure, strength labels, and how pages are written.
- Issue templates for documentation change requests and problem reports.
- This changelog.

### Changed

- Rewrote the single-purpose repository and self-contained repository delivery principles to the standard page structure.
- Replaced the repository topology placeholder with the trade-offs between multiple repositories and a single repository.
- Pinned the actions in the documentation check workflow to full commit SHAs.

## 2026-10-15: Establish platform knowledge base foundation and archive ([#15](https://github.com/launchbynttdata/common-platform-documentation/pull/15))

### Added

- Section index pages for principles, practices, standards, the platform map, new ideas, and the archive.
- A new idea template.
- A documentation checker, with unit tests, that verifies links, active-content boundaries, historical banners on archived pages, and the absence of private paths and identifiers.
- A pull request workflow that runs the checker and its tests as a required check.

### Changed

- Rewrote the repository home page as the public knowledge base for the Launch by NTT DATA Platform Engineering team.
- Moved historical procedures into the archive, marked each archived page as historical, and replaced sensitive values with neutral examples.

### Removed

- Placeholder pages and empty directories that only reserved titles.
- Screenshots that could not be safely redacted.

Changes made before this entry are recorded in the repository's commit history.
