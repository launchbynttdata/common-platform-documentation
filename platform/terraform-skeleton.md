# Distribute shared Terraform module configuration from the skeleton

## Responsibility

The skeleton is the shared configuration, workflows, and tool pins that Terraform module repositories consume. A published skeleton update is applied to the module repositories that use it.

## Boundary

The skeleton is not a module and it does not define a cloud resource. A change that belongs to one module stays in that module's repository. The [module template](terraform-module-template.md) is the starting contents of a new module repository. The team creates new module repositories from the private repository `launch-terraform-modules`. Work on a published module happens in that module's public repository.

## Where the behavior lives

The skeleton is [launch-terraform-skeleton](https://github.com/launchbynttdata/launch-terraform-skeleton). That repository documents how an update reaches a module repository.

[Platform map](README.md)
