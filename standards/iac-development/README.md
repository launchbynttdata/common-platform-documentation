# Exclusive and shared services

This address is kept because existing links use it. The current standard for where a service lives is [Put an exclusive service with its consumer and a shared service in one repository](../terraform/exclusive-and-shared-services.md).

The page that used to be here is archived at [archive/pre-refresh/standards/iac-development/README.md](../../archive/pre-refresh/standards/iac-development/README.md). Its exclusive/shared service distinction was superseded by [Put an exclusive service with its consumer and a shared service in one repository](../terraform/exclusive-and-shared-services.md). Its instruction to select the mainstream stable provider was not carried forward as a separate prescription. The current [module contract](../terraform/modules/README.md) governs provider floors, but does not preserve that archived provider-selection prescription. The provider-fork procedure was not carried forward.

Its four module classes—primitive, library, wrapper, and client-specific wrapper—were superseded by the current [module contract](../terraform/modules/README.md) and its [primitive](../terraform/modules/primitive.md), [library](../terraform/modules/library.md), [collection](../terraform/modules/collection.md), and [reference architecture](../terraform/modules/reference-architecture.md) pages; “wrapper” is now “collection,” and client-specific wrapper is not a current module type. Its Terragrunt rules prescribed a repository layout and were not carried forward. Current guidance is [Use Terragrunt to orchestrate Terraform across environments and regions](../terraform/terragrunt.md), which does not choose a layout.

Its resource naming and tagging strategy was superseded by current [`resource_name` guidance](../terraform/modules/library.md). The archived fixed string `<logical product name>-<region>-<class of env>-<instance of env>` and the resource-name suffix pattern were not preserved. Its `tf-module-*` repository naming examples were superseded by [Name infrastructure repositories by tool, provider, and name](../common-development/git/repository/naming-schemes/iac-repository-names.md).

The module type addresses under `terraform/module/` remain compatibility pages for [Hold shared Terraform modules to one contract](../terraform/modules/README.md).

[Standards](../README.md)
