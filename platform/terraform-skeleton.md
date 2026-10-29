# Distribute shared Terraform module configuration from the skeleton

## Responsibility

The skeleton is the shared configuration, workflows, and tool pins that Terraform module repositories consume. A published skeleton update is applied to the module repositories that use it.

## Boundary

The skeleton is not a module and it does not define a cloud resource. A change that belongs to one module stays in that module's repository. The [module template](terraform-module-template.md) is the starting contents of a new module repository. New module repositories are created from the private repository `launch-terraform-modules`. A reader outside the organization does not need those creation steps.

## Where the behavior lives

The skeleton is [launch-terraform-skeleton](https://github.com/launchbynttdata/launch-terraform-skeleton). That repository documents how an update reaches a module repository.

[Platform map](README.md)
