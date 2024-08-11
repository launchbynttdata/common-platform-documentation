# `common-automation-framework`
## **Table of Contents**
1. [Introduction](#1-introduction)
2. [Prerequisites](#2-prerequisites)
3. [Architecture Compatibility](#3-architecture-compatibility)
4. [Service examples](#4-service-examples)  
  4.1. [Shared Services](#41-shared-services)    
  4.2. [Exclusive Services](#42-exclusive-services)  

## 1. Introduction

## 2. Prerequisites
Local development environment:
- [MacOS local developer environment](./../../../../../development-environments/local/mac/README.md)
- [Windows local developer environment](./../../../../../development-environments/local/java/windows/README.md)

## 3. Template Architecture Compatibility
Template architecture compatibility matrix that shows each our of our templates and their certified compute platform. 

| App Template | [AWS ECS](./shared-services/aws/ecs/README.md) | AWS EKS | Azure AKS | Google GKE |
|------|-------|-------|-------|-------|
| [Java Hexagonal OpenAPI](https://github.com/launchbynttdata/launch-api-hex-java-template) | &check; | &cross; | &cross; | &cross; |
| [Next.js Web App](https://github.com/NTTDATA-Launch/launch-accelerators-site) | &check; | &cross; | &cross; | &cross; |

## 4. Service examples

### 4.1 Shared Services

#### 4.1.1 AWS:
- [Elastic Container Registry (ECR)](./shared-services/aws/ecr/README.md)
- [Elastic Container Service (ECS)](./shared-services/aws/ecs/README.md)
- [Identity and Access Management (IAM)](./shared-services/aws/iam//README.md)
- [Key Management Services (KMS)](./shared-services/aws/kms/README.md)
- [Secrets Manager](./shared-services/aws/secretsmanager/README.md)

#### 4.1.2 AZ:

### 4.2 Exclusive Services

#### 4.2.1 AWS:
- [Java application on Elastic Container Service (ECS)](./exclusive-services/java/aws/ecs/README.md)

#### 4.2.2 AZ:


