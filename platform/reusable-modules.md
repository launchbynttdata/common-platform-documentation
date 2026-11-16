# The team publishes Terraform modules that others can reuse

## Responsibility

The team publishes Terraform modules for other repositories to use. A Terraform configuration that uses one of those public modules downloads it from the [registry](launch-public-service/terraform-module-registry/README.md).

## Boundary

There is no catalog of those modules in this knowledge base. The public repositories are in the [launchbynttdata organization](https://github.com/orgs/launchbynttdata/repositories?q=module_). That search finds repositories whose names contain `module_`. The search is a way to find the repositories today. The team does not treat the search result as a list it maintains. How the team creates a new module repository is recorded on the [template](terraform-module-template.md) page.

## Where the behavior lives

[Hold shared Terraform modules to one contract](../standards/terraform/modules/README.md) states what a module must contain. The registry page explains how a Terraform configuration downloads a public module. The organization search above is the current way to find the public repositories.

[Platform map](README.md)
