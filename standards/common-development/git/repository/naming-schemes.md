# Name a repository for the contract it publishes

**Strength:** Team default

## The problem

People find a repository by its name, and they infer its contract from that name. A scheme that exists only as an example list, or that uses a different order for each kind of repository, makes the inference unreliable. The wrong repository is then used, or a duplicate is created.

## The position

The team has two naming schemes, and a repository uses the one that matches what it publishes.

An infrastructure module or chart uses [tool, provider, and name](naming-schemes/iac-repository-names.md). A sample application maintained by the platform team uses [language, platform, sample, and description](naming-schemes/platform-sample-applications.md). Both schemes are lowercase ASCII, with hyphens between fields and underscores inside a field.

The infrastructure requirement is that hyphen pattern. The field examples on the infrastructure page are guidance for staying consistent with existing repositories and for keeping one contract distinct from another. They are not a closed list.

A repository name is not a reason to adopt the tool in the name. Helm chart repositories that already exist use the infrastructure pattern. Helm is not a standard. It remains a [new idea](../../../../new-ideas/helm-and-argocd.md).

## What the team expects

- Name an infrastructure repository `tool-provider-name`, in lowercase ASCII, with hyphens between the fields.
- Choose each field so the name matches existing repositories of the same kind, and so a reader cannot confuse it with a different contract.
- Name a platform sample with the sample scheme.

## Where implementation details live

The two scheme pages hold the examples. How a Terraform module repository is created, and where the collection-module instructions live, is on [Name infrastructure repositories by tool, provider, and name](naming-schemes/iac-repository-names.md).

[Standards](../../../README.md)
