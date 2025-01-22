# LCAF Git Repository Naming Scheme

The Launch Common Automation Framework's platform-level concerns break down into a few types:

- An **Entrypoint** through which IaC modules access platform-level concerns
- A series of **Components** referenced from the **Entrypoint** that contain data and scripts necessary to implement functionality
- A series of **Skeletons** that are intended to be used as templates when creating IaC modules

## Entrypoint

A single **Entrypoint** to the LCAF system is provided, named `launch-common-automation-framework`. This repository holds manifests that reference other repositories and allows for individual modules to consume functionality from composed components. Since there is only one entrypoint, the naming strategy is fixed and will not change.

## Components

**Components** provide some functionality that is composed through the manifests found in the **Entrypoint** repository. A component ties either to a single software tool (like Terraform) or provides tool-agnostic functionality.

Within this family, there are two breakdowns:

- **Platform Components** represent a single software tool (e.g. Terraform, Terragrunt) or provide tool-agnostic data (Policy). Their naming scheme always follows the pattern of `lcaf-component-<name>`. The shortest reasonable `<name>` should be selected, and if multiple words are required for specificity, the `<name>` field must contain only underscores, dashes are not permitted. The singular form of the `<name>` is mandated. Some examples are:
    - lcaf-component-container
    - lcaf-component-policy
    - lcaf-component-terratest
- **Pipeline Components** represent all files or scripts necessary to implement a pipeline. The naming scheme for these will contain both the provider platform we're deploying to, as well as the platform from which we're deploying, in the form `lcaf-component-provider_<cloud>-pipeline_<ci_system>`:
    - lcaf-component-provider_az-pipeline_azdo (Azure resources deployed by Azure DevOps Pipelines)
    - lcaf-component-provider_aws-pipeline_aws (AWS resources deployed by AWS Pipelines)
    - lcaf-component-provider_gcp-pipeline_gha (Hypothetical Google Cloud resources deployed by GitHub Actions Pipelines)

## Skeletons

Our **Skeleton** repositories serve as a template to accelerate the creation of additional modules from a consistent starting place. Skeleton modules must be named with the format `lcaf-skeleton-<name>` where `<name>` is generally the IaC tool. Some examples might be:
- lcaf-skeleton-terraform
- lcaf-skeleton-terragrunt
- lcaf-skeleton-helm (Hypothetical template for Helm charts)
- lcaf-skeleton-python (Hypothetical template for Python projects)
