# Start a Terraform module repository from the template

## Responsibility

The template is the starting contents of a new Terraform module repository: the module files, the example, and the tests a new module begins with.

## Boundary

Shared workflows and shared configuration belong in the [skeleton](terraform-skeleton.md), not in a change to the template. The team creates new module repositories from the private repository `launch-terraform-modules`. Work on a published module happens in that module's public repository. What the module is required to contain is the [module contract](../standards/terraform/modules/README.md).

## Where the behavior lives

The template is [launch-terraform-template](https://github.com/launchbynttdata/launch-terraform-template).

[Platform map](README.md)
