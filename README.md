# Launch DevSecOps `common-platform-documentation`
### **Table of Contents**
1. [Introduction](#1-introduction)


## 1. **Introduction**
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

## Getting Started

This documentation is filled with guides and information related to developing with the `Launch` platform. 

### Environment Guides
- Setting up local environment: 
    - [MacOS local developer environment](./platform/development-environments/local/mac/README.md)
    - [Windows local developer environment](./platform/development-environments/local/windows/README.md)
- [Setting up Visual Studio Code](./platform/development-environments/local/tools/vscode/README.md)
- [Setting up Visual Studio Code Dev Containers](./platform/development-environments/local/tools/vscode/dev-containers/README.md)
- [Installing launch-cli](./platform/common-automation-framework/cli/README.md)
- [Configuring Github Personal Access Token](./platform/development-environments/local/tools/token/README.md)

### Usage-guides and Tutorials
- [Using Launch's platform and common-automation-framework](./platform/common-automation-framework/usage-guides/README.md)

### Quick Start Guides:
- [Create and deploy a new Java service [AWS] (1.5 hours)](./platform/common-automation-framework/usage-guides/new-service/java/aws/README.md)

## License
Unless explicitly stated otherwise, the content of the "common-platform-documentation" repository is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License (CC BY-NC-ND 4.0).

[Read Full License](./LICENSE)