# Publish reusable delivery and pipeline workflows

## Responsibility

Shared delivery workflows and shared pipeline workflows live in one public repository. A repository calls a published workflow instead of keeping a private copy of the same workflow.

## Boundary

A workflow in that repository is shared. A step that exists for one service stays in that service's repository. This page does not list workflow files, inputs, or versions. Those change in the workflow repository.

## Where the behavior lives

The workflows are in [launch-workflows](https://github.com/launchbynttdata/launch-workflows). That repository holds the workflow files and the release process.

[Platform map](README.md)
