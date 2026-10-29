# Standards

A standard states how the Launch by NTT DATA Platform Engineering team would implement a capability when the team is free to choose. The team owns the modules in the `launchbynttdata` organization, and a standard is a requirement for those modules. Client work can drive a change to a module the team owns. That change still meets the standard or records a documented reason where the work is done. An engagement owns the client code that calls those modules. This knowledge base does not govern code the client owns.

A standard is more specific than the practice it comes from. The practice says what kind of decision the team makes. The standard says the default itself: the name, the version, the test, or the contract another repository is expected to meet.

Consulting engagements rarely begin with that freedom. A client may already have tools, contracts, delivery processes, security controls, or organizational boundaries that do not match these standards. The team does not treat the client as an obstacle or impose a replacement faster than the client can sustain it. The team meets the client where the client is, learns why the current environment works as it does, and works with the client at the pace the engagement and the people can support.

The standards still provide direction in that environment. When a standard cannot be applied directly, engineers preserve as much of its intended outcome as the engagement allows, make the constraint and the resulting trade-off visible, and take the next useful step toward it. The goal is not compliance for its own sake. The goal is the client's long-term success, including a system the client can understand, operate, and continue improving after the engagement.

Commands and configuration stay in the component repository that owns them.

## What belongs here

A default the team uses now and expects engineers to meet. Examples are repository names, semantic versions, tool pins, the Terraform module contract and module types, module testing, version floors, the check that confirms a claim, and the split between this knowledge base and a repository README.

## What does not belong here

- A reason that should survive a tool change. That is a [principle](../principles/README.md).
- How to apply a principle on a delivery or operations task. That is a [practice](../practices/README.md).
- A capability-level description of a platform component. That belongs on the [platform map](../platform/README.md).
- A proposal that is not yet a default. That belongs in [new ideas](../new-ideas/README.md). An idea becomes a standard only through the process in [Promote a new idea into active guidance](../promoting-an-idea.md).
- A copy of a component's install or verification steps. [Keep procedures in the repository that owns them](documentation-ownership.md) is the rule.

## Pages

Repository and evidence:

- [Name a repository for the contract it publishes](common-development/git/repository/naming-schemes.md)
- [Name infrastructure repositories by tool, provider, and name](common-development/git/repository/naming-schemes/iac-repository-names.md)
- [Name platform sample applications by language, platform, and purpose](common-development/git/repository/naming-schemes/platform-sample-applications.md)
- [Version published modules semantically](common-development/versioning/README.md)
- [Pin the tools a repository requires](common-development/tool-versions.md)
- [Keep procedures in the repository that owns them](documentation-ownership.md)
- [Confirm a claim with a check that would fail](confirming-a-claim.md)

Terraform modules:

- [Hold shared Terraform modules to one contract](terraform/modules/README.md)
- [Build a primitive around one resource type](terraform/modules/primitive.md)
- [Compose primitives into a collection](terraform/modules/collection.md)
- [Publish a reference architecture as one deployable environment](terraform/modules/reference-architecture.md)
- [Use a library module to transform inputs into shared outputs](terraform/modules/library.md)
- [Test the behavior a module claims](terraform/testing.md)
- [Show that the declared version floor works](terraform/version-compatibility.md)

The previous addresses under `standards/iac-development/terraform/module/` remain as compatibility pages. Each one links to the page above.

## Awaiting review

These pages still need a review for relevance and currency. Until that review replaces or retires a page, treat it as it is labeled today. An active page is still current. An archived page is still historical. The review decides whether each page stays as it is, is replaced by a new standard, or has a rule restored from it. [Content disposition](../archive/content-disposition.md) records how the legacy paths were handled.

Active page:

- [The Terraform state strategy page](iac-development/README.md). It describes exclusive and shared services and a provider approach. It has not yet been compared with the module contract.

Active files with no standard text:

- The diagrams under `standards/common-development/java/hexagonal/pictures/`.

Archived standards:

- [Git tagging note](../archive/pre-refresh/standards/common-development/git/tagging/README.md). The versioning standard above replaces it for published modules.
- The archived framework repository-naming page in `archive/framework-era/standards/common-development/git/repository/naming-schemes/`. The file name contains the retired product acronym, so this index does not repeat it.
- [DNS deploy note](../archive/framework-era/standards/iac-development/terraform/module/wrapper/deploy/dns.md) and [ExpressRoute deploy note](../archive/framework-era/standards/iac-development/terraform/module/wrapper/deploy/expressroute.md).

The Helm chart pages are not in the lists above. They are not a current standard. The 2024 notes are archived under `archive/pre-refresh/standards/helm-development/`, and the current addresses point at [Deliver Kubernetes workloads with Helm and Argo CD](../new-ideas/helm-and-argocd.md).

[Knowledge base home](../README.md)
