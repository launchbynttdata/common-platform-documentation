# Launch DevSecOps `common-platform-documentation`

This repository is a knowledge base repository containing information related to, and associated with, the `Launch` platform.

The `Launch` platform is a DevSecOps platform that integrates security in your development and operations process. It streamlines the creation and management of Infrastructure as Code (IaC) using Terraform and Terragrunt, and automates deployments through secure efficient pipelines. The `Launch` platform integrates with your SCM of choice utilizing webhooks and allows you to utilize the platform on a variety of cloud providers. The `launch-cli` tool enables local repository creation and lifecycle management of your service.

## Supported platforms
The following platforms and environments are currently supported by the `Launch` platform.

### SCM
- Github
- Bitbucket

### Cloud Providers
- AWS

### Local Development Environments
- Windows 11+
- MacOS M1, 14.5+
- Linux, Ubuntu 20.04+

## Getting Started

This documentation is filled with guides and information related to developing with the `Launch` platform. 

### Environment Guides
- Setting up local environment: [Mac](./platform/development-environments/local/java/mac/README.md), [Windows](./platform/development-environments/local/java/windows/README.md)
- [Setting up Visual Studio Code](./platform/development-environments/local/vscode/README.md)
- [Setting up Visual Studio Code dev containers](./platform/development-environments/local/vscode/dev-containers/README.md)

### Quick Start Guides:
- [Deploy a full stack Java application on AWS ECS](./platform/cli/usage-guides/new-service/java/aws/README.md)

### Usage-guides and Tutorials
- [Using the `launch-cli`](./platform/cli/usage-guides/README.md)


## License
Unless explicitly stated otherwise, the content of the "common-platform-documentation" repository is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License (CC BY-NC-ND 4.0).

[Read Full License](./LICENSE)