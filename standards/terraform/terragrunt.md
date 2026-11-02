# Use Terragrunt to orchestrate Terraform across environments and regions

**Strength:** Team default

## The problem

A system that runs in more than one environment, or in more than one region, needs the same Terraform applied with different values. Copying the Terraform once for each environment, or once for each region, makes those copies drift. A fix in one copy is not a fix in the others.

## The position

The team uses Terragrunt to orchestrate Terraform. Terragrunt applies one body of Terraform code to more than one environment, including environments in more than one region. The Terraform is written once. Terragrunt supplies the values that differ by environment or by region, so that shared code stays DRY. DRY means the shared code is not repeated for each environment or region.

Many Terragrunt layouts do this well. This standard does not choose a directory structure, a file name, or a particular way of arranging the Terragrunt files. The team chooses a layout that fits the system.

## What the team expects

- Use Terragrunt to orchestrate Terraform when a system is deployed to more than one environment or more than one region.
- Keep one body of Terraform code. Supply the values that differ by environment or by region through Terragrunt.
- Do not copy the Terraform once per environment or once per region.
- Choose a Terragrunt layout that fits the system. A particular directory structure is not required.

## Where implementation details live

The repository that deploys the system holds its Terragrunt configuration. Terragrunt's own documentation describes the features that keep that configuration from being repeated. This page does not restate those features, and it does not pin a Terragrunt version.

The older Terragrunt repository rules are archived with the previous strategy page at [archive/pre-refresh/standards/iac-development/README.md](../../archive/pre-refresh/standards/iac-development/README.md). Those rules were not carried forward.

[Standards](../README.md)
