# Shared automation for delivery and for pipelines

## Responsibility

The team keeps shared automation that other repositories use to deliver software and to run pipelines. A repository uses that shared automation. It does not keep a separate copy of the same automation.

The automation runs on the orchestration system the engagement uses. GitHub Actions, Azure DevOps, Jenkins, AWS CodeBuild, AWS CodeDeploy, and Bitbucket Pipelines are examples. Another orchestration system meets the same expectation when the team publishes the shared automation once and the repositories that need it use that shared automation.

The team publishes GitHub Actions workflows in the public repository [launch-workflows](https://github.com/launchbynttdata/launch-workflows). The team keeps Azure DevOps pipeline templates in the private repository `launch-platform-ado-pipeline-templates`.

## Boundary

Automation published for more than one repository stays in the shared repository. A step that only one service needs stays in that service's repository. The files, the inputs, and the versions are recorded in the repository for that orchestration system, because that is where they change.

## Where the behavior lives

The public GitHub Actions workflows are in [launch-workflows](https://github.com/launchbynttdata/launch-workflows). That repository contains the workflow files and describes how the team releases a workflow. The Azure DevOps pipeline templates are in the private repository `launch-platform-ado-pipeline-templates`.

[Platform map](README.md)
