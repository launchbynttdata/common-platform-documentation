# Publish reusable Terraform modules

## Responsibility

The reusable module library is the set of public Terraform modules the team publishes. A caller fetches a public module from the [registry](launch-public-service/terraform-module-registry/README.md).

## Boundary

This page is not a catalog. A public catalog of the modules is not published here. Public module repositories are in the [launchbynttdata organization](https://github.com/orgs/launchbynttdata/repositories?q=module_). That search finds repositories whose names contain `module_`. It is a way to locate them today, and it is not a maintained list. New module repositories are created from the private repository `launch-terraform-modules`. A reader outside the organization does not need those creation steps.

## Where the behavior lives

[Hold shared Terraform modules to one contract](../standards/terraform/modules/README.md) is the standard for what a module contains. The registry page states how a caller fetches a public module. The search above is the current way to find the public repositories.

[Platform map](README.md)
