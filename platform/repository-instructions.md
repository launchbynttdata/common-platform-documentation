# Carry engineering instructions in the module repository

## Responsibility

A Terraform module repository carries a README and a coding-agent baseline. The README tells a person what the module provides, the supported way to use it, and how to verify that use, as [Keep procedures in the repository that owns them](../standards/documentation-ownership.md) requires. The coding-agent baseline travels with the [skeleton](terraform-skeleton.md). It names the local checks, the file layout, and how to tell the module types apart. The same baseline is copied into each module repository. The repository name and its files show which module type that repository is.

## Boundary

The README is the guide for a person working in that repository. The coding-agent baseline is the guide for an agent working in that repository. This knowledge base holds the team standards. A change to a standard is made here. A change to a repository's checks, or to the coding-agent baseline, is made in the skeleton or in that repository.

## Where the behavior lives

The README is in the module repository. The shared coding-agent baseline starts at [AGENTS.md in the skeleton template](https://github.com/launchbynttdata/launch-terraform-skeleton/blob/main/template/AGENTS.md).

[Platform map](README.md)
