# Standards

A standard is a current team default or a compatibility contract. Engineers follow it unless a documented reason justifies an exception. Detailed commands and configuration stay in the component repository that owns them.

## What belongs here

A page that states a default the team is using now: repository boundaries, versioning, a Terraform module contract, evidence the team expects before a change is called done, or another default that is established enough to require.

## What does not belong here

- A reason that should survive a tool change. That is a [principle](../principles/README.md).
- How to apply a principle on a delivery or operations task. That is a [practice](../practices/README.md).
- A capability-level description of a platform component. That belongs on the [platform map](../platform/README.md).
- A proposal that is not yet a default. That belongs in [new ideas](../new-ideas/README.md).
- Historical service procedures and empty title reservations.
- A copy of a component's install or verification steps.

## Questions an active standard page answers

1. What problem does this address?
2. Why does the team take this position?
3. What does the team expect engineers to do?
4. Where do current implementation details live?

For a standard, the third answer is the default itself, including when an exception is legitimate. The fourth answer points at the owning component rather than embedding its procedure.

## Pages

These are the substantive documents under `standards/` today. Several still describe an older layout. A link means the file exists and has a body. It does not mean the page has been rewritten to the questions above, and it does not by itself make the page a refreshed team default.

This index does not add pages for topics that are not written yet. Placeholder files are omitted. A naming-scheme file whose name contains a deprecated product acronym is omitted so this page does not repeat that name.

### Repository boundaries and versioning

- [Repository naming schemes](common-development/git/repository/naming-schemes.md)
- [Infrastructure-as-code repository names](common-development/git/repository/naming-schemes/iac-repository-names.md)
- [Platform sample application names](common-development/git/repository/naming-schemes/platform-sample-applications.md)
- [Automatic semver tagging](common-development/git/tagging/README.md)
- [Versioning](common-development/versioning/README.md)

The versioning page is a pointer to the tagging page.

### Helm

- [Helm chart tools and practices](helm-development/README.md)
- [Helm deployment charts](helm-development/charts/deployment/README.md)
- [Helm library charts](helm-development/charts/library/README.md)
- [Helm chart helpers](helm-development/helpers/README.md)

Whether each Helm page remains a team default is a later decision. Until then, these are the Helm documents the repository has.

### Terraform

- [Terraform strategy for managed state](iac-development/README.md)
- [Primitive module](iac-development/terraform/module/primitive/README.md)
- [Collection module](iac-development/terraform/module/collection/README.md)
- [Reference architecture module](iac-development/terraform/module/reference-architecture/README.md)
- [Library module](iac-development/terraform/module/library/README.md)

Service-specific deploy notes under `iac-development/terraform/module/wrapper/deploy/` are historical procedures. They are not listed here. The [archive disposition](../archive/content-disposition.md) records that directory's move.

[Knowledge base home](../README.md)
