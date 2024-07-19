# Usage Guide: Create a new java service [AWS]
## **Table of Contents**
1. [Introduction](#introduction)
2. [Basics](#basics)
3. [Deploy Infrastructure](#deploy-infrastructure)
4. [Deploy Java Application](#deploy-java-application)
5. [Maintenance](#maintenance)

## 1. **Introduction**
This guide will describe how to deploy a new java service using Launch's cli utility `launch-cli`. Within this guide, we will deploy necessary infrastructure to host a container application. Among the infrastructure, We need to deploy an ECR repository to store the new java containers being built. Secrets Manager to host your container's secrets. Finally, it will deploy an ECS cluster to support and serve the new java service. 

High level diagram of the architecture we are going to create in this guide.

<p align="center">
  <img src="./pictures/userguide-ecs-complete.drawio.png" /> 
</p>


This guide has been modified to work with the following providers:

- Service provider: **AWS**
- Pipeline provider: **AWS**

These local configurations are required to use this guide:
- Local AWS profile configured.
  - ref: `common-platform-documentation/platform/development-environments/local`
- Git personal access token with access to your organization's SCM
  - ref: //TODO: <link to doc>

External dependencies:
- launch-cli is installed
  - ref: `common-platform-documentation/platform/cli/usage-guides/README.md`
- Java application built to Launch's requirements.
  - This guide will use the following repository: https://github.com/NTTDATA-Launch/launch-api-hex-java-template/
  - ref: //TODO: <link to doc>

## 2. **Basics**


### aws sso login

## 3. **Deploy Infrastructure**

### 3.X Deploy Secrets Manager 
In this section, we will be deploying the secrets needed for our platform and java appication.

### 3.X Deploy IAM rols 
In this section, we will be deploying the IAM roles needed for our platform and java appication. 

### 3.X Deploy ECR Repository
In this section, we will be deploying the necessary infrastructure to store our java image built. 

### 3.X Deploy ECS Platform
In this section, we will be deploying the ECS platform that our application will be deployed onto. 

#### 3.X.1 Create the inputs

We are going to be using the following inputs for our `.launch_config` files. 
- [./example_files/platform/service.sandbox.us-east-2.tfvars](example_files/platform/service.sandbox.us-east-2.tfvars)
- [./example_files/platform/pipeline.root.us-east-2.yaml](example_files/platform/pipeline.root.us-east-2.yaml)
- [./example_files/platform/webhooks.root.us-east-2.yaml](example_files/platform/webhooks.root.us-east-2.yaml)

The launch config for the platform in this guide is at the following:
- [./example_files/platform/.launch_config](example_files/platform/.launch_config)

#### 3.X.2 Create the service

```
~ $ launch service create --name launch-demo-ecs-platform --in-file <path to the saved platform .launch_config>
```
<p align="center">
  <img src="./pictures/launch-service-create-platform-output.png" /> 
</p>

#### 3.X.3 Generate the service

Change into the directory of the newly created service. 

```
~ $ cd sample-demo-app
~ $ launch service generate
```
![image info](./pictures/launch-service-generate-platform-output.png)
#### 3.X.4 Deploy the service

Deploy the webhooks for the service
```
~ $ launch terragrunt --target-environment root --platform-resource pipeline --apply --generation
```
![image info](./pictures/launch-terragrunt-plan-platform-pipeline-output.png)

Deploy the pipeline for the service
```
~ $ launch terragrunt --target-environment root --platform-resource webhooks --apply --generation
```
![image info](./pictures/launch-terragrunt-plan-platform-webhooks-output.png)

Deploy the service
```
~ $ launch terragrunt --target-environment sandbox --platform-resource service --apply --generation
```
![image info](./pictures/launch-terragrunt-plan-platform-service-output.png)


#### 3.X.5 Connect the webhooks


## 4. **Deploy Java Application**

#### 4.1.1 Create the inputs

We are going to be using the following inputs for our `.launch_config` files. 
- [./example_files/application/service.sandbox.us-east-2.tfvars](example_files/application/service.sandbox.us-east-2.tfvars)
- [./example_files/application/pipeline.root.us-east-2.yaml](example_files/application/pipeline.root.us-east-2.yaml)
- [./example_files/application/webhooks.root.us-east-2.yaml](example_files/application/webhooks.root.us-east-2.yaml)

The launch config for the platform in this guide is at the following:
- [./example_files/application/.launch_config](example_files/application/.launch_config)

#### 4.1.2 Create the service

Replace the path in the `--in-file` with the exact path to your saved application .launch_config
```
~ $ launch service create --name sample-demo-app --in-file /workspaces/workplace/common-platform-documentation/platform/cli/usage-guides/new-service/java/aws/example_files/application/.launch_config
```
![image info](./pictures/launch-service-create-application-output.png)

#### 4.1.3 Connect the webhooks


#### 4.1.4 Build the image and push

#### 4.1.5 Generate the service
Change into the directory of the newly created Java application service. 

```
~ $ cd sample-demo-app
~ $ launch service generate
```
![image info](./pictures/launch-service-generate-application-output.png)
#### 4.1.6 Deploy the service

Deploy the webhooks for the Java application service
```
~ $ launch terragrunt --target-environment root --platform-resource pipeline --apply --generation
```
![image info](./pictures/launch-terragrunt-plan-application-pipeline-output.png)

Deploy the pipeline for the Java application  service
```
~ $ launch terragrunt --target-environment root --platform-resource webhooks --apply --generation
```
![image info](./pictures/launch-terragrunt-plan-application-webhooks-output.png)

Deploy the Java application service
```
~ $ launch terragrunt --target-environment sandbox --platform-resource service --apply --generation
```
![image info](./pictures/launch-terragrunt-plan-application-service-output.png)
