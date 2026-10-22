# Name a repository for the contract it publishes

**Strength:** Team default

## The problem

People find a repository by its name, and they infer its contract from that name. A scheme that exists only as an example list, or that uses a different order for each kind of repository, makes the inference unreliable. The wrong repository is then used, or a duplicate is created.

## The position

The team has two naming schemes, and a repository uses the one that matches what it publishes.

An infrastructure module or chart uses [tool, provider, type, and resource](naming-schemes/iac-repository-names.md). A sample application maintained by the platform team uses [language, platform, sample, and description](naming-schemes/platform-sample-applications.md). Both schemes are lowercase ASCII, with hyphens between fields and underscores inside a field.

A repository name is not a reason to adopt the tool in the name. A Helm chart repository, if one is created, is named with the infrastructure scheme. The name does not make Helm a supported path. Helm as a delivery path is a [new idea](../../../../new-ideas/helm-and-argocd.md).

## What the team expects

- Name an infrastructure repository with the infrastructure scheme before the repository is created.
- Name a platform sample with the sample scheme.
- Do not invent a third field order for a one-off repository.
- Open a change to the scheme before introducing a new tool, provider, or type. Do not start a repository on a type this standard does not list.

## Where implementation details live

The two scheme pages hold the field lists and the examples. New Terraform module repositories are created from the [module generator](https://github.com/launchbynttdata/launch-terraform-modules).

[Standards](../../../README.md)
