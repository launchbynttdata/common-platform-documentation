# The skeleton shares configuration across Terraform module repositories

## Responsibility

Terraform module repositories share configuration, workflows, and tool versions. The skeleton is where the team keeps those shared pieces. When the team publishes an update to the skeleton, the module repositories that use the skeleton receive that update.

## Boundary

The skeleton is shared configuration. It is not a Terraform module, and it does not create a cloud resource. A change that applies to only one module is made in that module's repository. The [template](terraform-module-template.md) is the set of files a new module repository starts with. That page records how the team creates the repository.

## Where the behavior lives

The skeleton is [launch-terraform-skeleton](https://github.com/launchbynttdata/launch-terraform-skeleton). That repository explains how an update reaches a module repository.

[Platform map](README.md)
