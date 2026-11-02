# The registry is where Terraform downloads a public module

## Responsibility

The Launch by NTT DATA Platform Engineering team publishes Terraform modules that are public. Terraform downloads one of those modules from the registry. The registry hostname is `terraform.registry.launch.nttdata.com`. The registry serves the modules that are public in the [launchbynttdata organization](https://github.com/launchbynttdata).

## Boundary

The registry does not list every module, and it does not state what a module must contain. HashiCorp documents how to write a [registry source](https://developer.hashicorp.com/terraform/language/modules/sources#terraform-registry). A registry source is the address Terraform uses to download a module from a registry. The version a configuration uses is chosen according to [Version published modules semantically](../../../standards/common-development/versioning/README.md).

## Where the behavior lives

The hostname above is the public service. [Hold shared Terraform modules to one contract](../../../standards/terraform/modules/README.md) states what a module must contain. [Name infrastructure repositories by tool, provider, and name](../../../standards/common-development/git/repository/naming-schemes/iac-repository-names.md) states how the team forms a repository name. An older page showed how to build a registry address by hand from that name. That page is archived at [archive/pre-refresh/platform/launch-public-service/terraform-module-registry/README.md](../../../archive/pre-refresh/platform/launch-public-service/terraform-module-registry/README.md).

[Platform map](../../README.md)
