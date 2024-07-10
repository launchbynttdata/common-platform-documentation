# Usage Guide: Create a new java service
## **Table of Contents**
1. [Introduction](#introduction)
2. [Basics](#basics)
3. [Deploy Infrastructure](#deploy-infrastructure)
4. [Deploy Java Application](#deploy-java-application)
5. [Maintenance](#maintenance)

## 1. **Introduction**
This guide will describe how to deploy a new java service using Launch's cli utility `launch-cli`. Within this guide, we will deploy necessary infrastructure to host a container application. We will then deploy a java application to this infrastructure.

This guide has been modified to work with the following providers:

- Service provider: **AWS**
- Pipeline provider: **AWS**

These local configurations are required to use this guide:
- Local AWS profile configure.
  - ref: `common-platform-documentation/platform/development-environments/local`
- Git personal access token with access to your organization's SCM
  - ref: //TODO:// `common-platform-documentation/platform/development-environments/local/...`

External dependencies:
- launch-cli is installed
  - ref: `common-platform-documentation/platform/cli/usage-guides/README.md`
- Java application built to Launch's requirements.
  - This guide will use the following repository: https://github.com/NTTDATA-Launch/launch-api-hex-java-template/
  - ref: //TODO:// `common-platform-documentation/standards/common-development/...`

## 2. **Basics**




## 3. **Deploy Infrastructure**

### 3.1 Deploy ECS Platform


launch service create --name sample-demo-platform

#### 3.1.1 Create the inputs

/workspaces/workplace/common-platform-documentation/platform/cli/usage-guides/new-service/java/aws/example_files/platform/.launch_config
/workspaces/workplace/common-platform-documentation/platform/cli/usage-guides/new-service/java/aws/example_files/platform/pipeline.root.us-east-2.yaml
/workspaces/workplace/common-platform-documentation/platform/cli/usage-guides/new-service/java/aws/example_files/platform/service.sandbox.us-east-2.yaml
/workspaces/workplace/common-platform-documentation/platform/cli/usage-guides/new-service/java/aws/example_files/platform/webhooks.root.us-east-2.yaml

#### 3.1.2 Create the service

launch service create --name sample-demo-platform --in-file <path to the saved platform .launch_config>

#### 3.1.3 Generate the service
launch service generate

#### 3.1.4 Deploy the service
launch terragrunt plan --target-environment sandbox --platform-resource all


## 4. **Deploy Java Application**

#### 4.1.1 Create the inputs

/workspaces/workplace/common-platform-documentation/platform/cli/usage-guides/new-service/java/aws/example_files/application/.launch_config
/workspaces/workplace/common-platform-documentation/platform/cli/usage-guides/new-service/java/aws/example_files/application/pipeline.root.us-east-2.yaml
/workspaces/workplace/common-platform-documentation/platform/cli/usage-guides/new-service/java/aws/example_files/application/service.sandbox.us-east-2.yaml
/workspaces/workplace/common-platform-documentation/platform/cli/usage-guides/new-service/java/aws/example_files/application/webhooks.root.us-east-2.yaml

#### 4.1.2 Create the service

launch service create --name sample-demo-platform --in-file <path to the saved application .launch_config>

#### 4.1.3 Generate the service
launch service generate

#### 4.1.4 Deploy the service
launch terragrunt plan --target-environment sandbox --platform-resource all
