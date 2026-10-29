# Serve public Terraform modules from the registry

## Responsibility

The registry is how a caller fetches a public module published by the Launch by NTT DATA Platform Engineering team. The hostname is `terraform.registry.launch.nttdata.com`. It serves modules that are public in the [launchbynttdata organization](https://github.com/launchbynttdata).

## Boundary

The registry is not a catalog of every module, and it is not the module contract. HashiCorp documents how a [registry source](https://developer.hashicorp.com/terraform/language/modules/sources#terraform-registry) is written. The version a caller pins follows [Version published modules semantically](../../../standards/common-development/versioning/README.md).

## Where the behavior lives

The registry hostname above is the public service. [Hold shared Terraform modules to one contract](../../../standards/terraform/modules/README.md) is the standard for what a module contains. [Name infrastructure repositories by tool, provider, and name](../../../standards/common-development/git/repository/naming-schemes/iac-repository-names.md) is how a repository name is formed. The previous source-construction recipe is archived at [archive/pre-refresh/platform/launch-public-service/terraform-module-registry/README.md](../../../archive/pre-refresh/platform/launch-public-service/terraform-module-registry/README.md).

[Platform map](../../README.md)
