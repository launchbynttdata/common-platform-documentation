# Changelog

This file records notable changes to the knowledge base, such as new or rewritten pages, changes to its structure, and changes to how the documentation is checked. Each entry links to the pull request that made the change. Corrections to spelling and minor wording are not listed.

Each open pull request records its changes under "Unreleased", with the pull request number and title in the heading. After that pull request merges, the next pull request replaces "Unreleased" with the merge date.

## Unreleased: #25, Publish the platform capability map

### Added

- A platform map for reusable workflows, the Terraform skeleton, the Terraform module template, public modules, the module registry, repository engineering instructions, and readiness.
- A standard for exclusive services and shared services.

### Changed

- The registry page now states what the registry serves. The source-construction recipe is archived.
- The previous Terraform strategy page now points at the exclusive and shared service standard. The provider-fork procedure, the older module class list, and the Terragrunt repository rules stay on the archived page.

### Removed

- The Java hexagonal diagrams under `standards/common-development/java/hexagonal/pictures/`. Nothing in the knowledge base used them.

## 2026-10-29: #24, Publish current engineering standards

### Added

- Standards for repository names, semantic versions, tool pins, documentation ownership, and the check that confirms a claim.
- The Terraform module contract, the four module types, module testing, and version-floor checks. Existing module-definition addresses remain as compatibility pages.
- A process for promoting or abandoning a new idea.
- A Helm and Argo CD proposal. The 2024 Helm pages are archived at `archive/pre-refresh/standards/helm-development/`. The previous addresses remain as pointers to that proposal.

### Changed

- The documentation check now requires the canonical Terraform module pages and the compatibility links to them.
- A standard now states how the team would implement a capability when free to choose. It is a requirement for modules the team owns in the `launchbynttdata` organization. It does not govern code the client owns. On that work, platform engineers extend it as far as the engagement can support.
- Pages now keep one meaning for each term. Shared jargon is defined once and reused, and a page defines a local term only when a reader could otherwise take it to mean something else.
- A breaking change bumps the major version at every stage, including below 1.0. The changelog for that release points to documentation that tells consumers how to take the change. A version-floor change uses that same contract test. In the general case it is breaking because callers lose a version they were allowed to use.
- The CI version-floor check confirms the oldest Terraform version a module supports. The page points at the public skeleton script for how that check runs. A provider version floor is verified by the engineer implementing the module. There is no automated provider-floor check today.
- A collection that contains security-sensitive resources sets secure values for those configurations by default. Examples include data stores, network connections, and server configurations.
- An infrastructure repository name is required to follow `tool-provider-name`. The token lists are consistency guidance, not a closed list. Helm remains a new idea.
- The module generator is named, not linked. Its creation steps stay in the private repository `launch-terraform-modules`. The public skeleton skills remain the instructions for building a module.
- A primitive is one provider resource. A related resource type is its own primitive. Secure defaults apply inside that module. A primitive does not generate names. Its examples and tests may call `resource_name`.
- The module-URL check now has a test where the compatibility links are correct and a test where a compatibility page points at the wrong canonical page.

## 2026-10-22: Publish core platform engineering practices ([#23](https://github.com/launchbynttdata/common-platform-documentation/pull/23))

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
