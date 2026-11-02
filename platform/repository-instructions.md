# A module repository contains a README and instructions for coding agents

## Responsibility

A Terraform module repository contains instructions for two audiences.

The README is for a person. It says what the module provides, the supported way to use the module, and how to check that the use succeeded. [Keep procedures in the repository that owns them](../standards/documentation-ownership.md) requires those three statements.

The instructions for a coding agent come from the [skeleton](terraform-skeleton.md), together with the rest of the shared configuration. Those instructions name the checks to run, describe how the files are arranged, and explain how the module types differ. The same instructions are copied into every module repository, so they do not name the type of one particular repository. The repository name, and the files in the repository, show that type.

## Boundary

A person working in the repository uses the README. A coding agent working in the repository uses the agent instructions. The standards for the whole team are in this knowledge base. A change to a standard is made here. A change to a repository's checks, or to the instructions for coding agents, is made in the skeleton or in that repository.

## Where the behavior lives

The README is in the module repository. The shared instructions for coding agents start at [AGENTS.md in the skeleton template](https://github.com/launchbynttdata/launch-terraform-skeleton/blob/main/template/AGENTS.md).

[Platform map](README.md)
