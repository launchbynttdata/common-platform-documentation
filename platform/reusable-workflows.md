# Shared workflows for delivery and for pipelines

## Responsibility

The team keeps workflows for delivering software, and workflows for running pipelines, in one public repository. Another repository runs a workflow from that repository. It does not keep a separate copy of the same workflow.

## Boundary

The workflows in that repository are shared, so more than one repository can run them. A step that only one service needs stays in that service's repository. The workflow files, the inputs those files accept, and the versions the team has released are recorded in the workflow repository, because that is where they change.

## Where the behavior lives

The workflows are in [launch-workflows](https://github.com/launchbynttdata/launch-workflows). That repository contains the workflow files and describes how the team releases a workflow.

[Platform map](README.md)
