# Launch `common-automation-framework`
## **Table of Contents**
1. [Introduction](#1-introduction)
2. [Prerequisites](#2-prerequisites)  
3. [Template Architecture Compatibility](#3-template-architecture-compatibility)  
4. [Service examples](#4-service-examples)  
  4.1. [Shared Services](#41-shared-services)    
  4.2. [Exclusive Services](#42-exclusive-services)  
5. [References](#5-references)

## 1. Introduction
Welcome to the capability matrix for the Launch Common Automation Framework (LCAF) platform. This document provides a quick reference to the compatibility and feature set of our technology templates across various cloud environments.

## 2. Prerequisites
In order to use this framework successfully, there may be assumptions within your current environment. Please follow these other guides that are dependencies to successfully utilizes the `common-automation-framework`.

Local development environment:
- [MacOS local developer environment](./../development-environments/local/mac/README.md)
- [Windows local developer environment](./../development-environments/local/windows/README.md)

Developer Containers:
- [Jetbrains IDEs](./../development-environments/local/tools/jetbrains/dev-containers/README.md)
- [Visual Studio Code](./../development-environments/local/tools/vscode/dev-containers/README.md)

If not using Launch's developer container:
- [asdf](./../development-environments/local/tools/asdf/README.md)
- [launch-cli](./../development-environments/local/tools/)

## 3. Template Architecture Compatibility
Template architecture compatibility matrix that shows each our of our templates and their certified compute platform. 

| App Template | [AWS ECS](./shared-services/aws/ecs/README.md) | AWS EKS | Azure AKS | Google GKE |
|------|-------|-------|-------|-------|
| [Java Hexagonal OpenAPI](https://github.com/launchbynttdata/launch-api-hex-java-template) | &check; | &cross; | &cross; | &cross; |
| [Next.js Web App](https://github.com/NTTDATA-Launch/launch-accelerators-site) | &check; | &cross; | &cross; | &cross; |

## 4. Service examples
We have created several examples of services across our supported cloud platform. Utilize these guides to see example inputs and examples on how to deploy Launch's accelerators. 

### 4.1 Shared Services
Shared services are cloud services deployed that are utilized by many other services. 

#### 4.1.1 AWS:
- [Elastic Container Registry (ECR)](./shared-services/aws/ecr/README.md)
- [Elastic Container Service (ECS)](./shared-services/aws/ecs/README.md)
- [Identity and Access Management (IAM)](./shared-services/aws/iam//README.md)
- [Key Management Services (KMS)](./shared-services/aws/kms/README.md)
- [Secrets Manager](./shared-services/aws/secretsmanager/README.md)

#### 4.1.2 AZ:

### 4.2 Exclusive Services
Exclusive services are services deployed that are self contained. These services might use one or many shared services. 

#### 4.2.1 AWS:
- [Java application on Elastic Container Service (ECS)](./exclusive-services/java/aws/ecs/README.md)

#### 4.2.2 AZ:


## 5. **References**
- [MacOS local developer environment](./../development-environments/local/mac/README.md)
- [Windows local developer environment](./../development-environments/local/windows/README.md)
- [Jetbrains IDEs](./../development-environments/local/tools/jetbrains/dev-containers/README.md)
- [Visual Studio Code](./../development-environments/local/tools/vscode/dev-containers/README.md)
- [asdf](./../development-environments/local/tools/asdf/README.md)
- [launch-cli](./../development-environments/local/tools/)