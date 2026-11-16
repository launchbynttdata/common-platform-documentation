# The template is how a new Terraform module repository starts

## Responsibility

When the team creates a Terraform module repository, the repository starts from the template. The template includes the module files, an example, and the tests.

## Boundary

Configuration and workflows that every module repository shares belong in the [skeleton](terraform-skeleton.md). That kind of change is made in the skeleton. The template remains the starting files for a new repository. The internal repository `launch-terraform-modules` creates a new module repository, which starts internal. After the implementation passes the make-public checks in `launch-terraform-modules`, the module repository becomes public and is available through the registry. Further changes to the module are made in that module repository. [Hold shared Terraform modules to one contract](../standards/terraform/modules/README.md) states what the module must contain.

## Where the behavior lives

The template is [launch-terraform-template](https://github.com/launchbynttdata/launch-terraform-template).

[Platform map](README.md)
