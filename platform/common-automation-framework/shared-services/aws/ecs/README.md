# Shared-service: Elastic Container Service (ECS)
### **Table of Contents**
1. [Introduction](#1-introduction)
2. [Prerequisites](#2-Prerequisites)
3. [Getting Started](#3-getting-started)  
  3.1. [Create the repository](#31-create-the-repository)  
  3.2. [Configure the inputs](#32-configure-the-inputs)  
4. [Deploy Service](#4-deploy-service)  
  4.1. [Deploy Infrastructure](#41-deploy-infrastructure)  
  4.2. [Connect Webhooks](#42-connect-webhooks)  
  4.3. [Deploy Service](#43-deploy-service)  
5. [Appendix](#5-appendix)

## 1. **Introduction**
This guide will deploy an Elastic Container Service (ECS) cluster compute platform to host an application along with the necessary infrastructure for CICD.

<p align="center">
  <img src="./pictures/ecs-complete.png" />
</p>

## 2. **Prerequisites:**

In order to use this guide successfully, there may be assumptions within your current environment. Please follow these other guides that are dependencies to successfully utilizes this one. 

Local development environment:
  - [MacOS local developer environment](./../../../../../development-environments/local/mac/README.md)
  - [Windows local developer environment](./../../../../../development-environments/local/java/windows/README.md)
  
## 3. **Getting Started**

### 3.1. Configure the inputs
This guide has provided basic inputs to be used with the services we are deploying. However, we cannot use these right out of the box and we need to quickly update some paths within our `.launch_config` file.

The launch config for the platform in this guide is at the following:
- [./example_files/platform/.launch_config](./example_files/platform/.launch_config)

Open this file and update the `properties_file` key with the absolute path from your system to the input files to be used, and then save it.

We are going to be using the following inputs for our `.launch_config` files. 
- [Service `properties file` ./example_files/platform/service.sandbox.us-east-2.tfvars](./example_files/platform/service.sandbox.us-east-2.tfvars)
- [Pipeline `properties file` ./example_files/platform/pipeline.root.us-east-2.tfvars](./example_files/platform/pipeline.root.us-east-2.tfvars)
- [Webhooks `properties file` ./example_files/platform/webhooks.root.us-east-2.tfvars](./example_files/platform/webhooks.root.us-east-2.tfvars)

<p align="center">
  <img src="./pictures/launch_config-paths-platform.png" /> 
</p>

### 3.2. Create the repository
We are now going to create the ECS platform properties repository. This service is the ECS cluster that the java application will deploy too.

- Replace the path in the `--in-file` argument to the absolute path of the `.launch_config` file saved in the previous section. 
- We are going to use the `--name` of `launch-demo-ecs-platform` in this demo, but you can name it what ever you want.

```sh
$ launch service create --name launch-demo-ecs-platform --in-file /workspaces/workplace/common-platform-documentation/platform/common-automation-framework/shared-services/aws/ecs/inputs/.launch_config
```

<p align="center">
  <img src="./pictures/launch-service-create-platform-output.png" /> 
</p>

## 4. **Deploy service**

### Pre-flight
Ensure your environmental variable `GIT_TOKEN` is set and you are logged into aws cli.

```sh
$ export GIT_TOKEN="YOUR_TOKEN"
$ aws sso login --profile "YOUR_AWS_PROFILE"
```

### 4.1. Deploy Infrastructure
Deploy the pipeline for the ECS service. This step will deploy all the CICD pipeline infrastructure to manage this repository. 

```sh
$ cd launch-demo-ecs-platform # Ensure you are in the newly created repository's directory
$ launch terragrunt --target-environment root --platform-resource pipeline --apply --generation
```

<p align="center">
  <img src="./pictures/launch-terragrunt-pipeline-apply-platform-output-01.png" /><br>
  output truncated... <br>
  <img src="./pictures/launch-terragrunt-pipeline-apply-platform-output-02.png" />
</p>

Deploy the webhooks for the ECS service. This will deploy lambda functions that we can connect to a SCM for pull request building events and triggering deployment pipelines. 

```sh
$ launch terragrunt --target-environment root --platform-resource webhook --apply --generation
```

<p align="center">
  <img src="./pictures/launch-terragrunt-webhook-apply-platform-output-01.png" /><br>
  output truncated... <br>
  <img src="./pictures/launch-terragrunt-webhook-apply-platform-output-02.png" />
</p>

### 4.2. Connect webhooks
In this section, we will connect the webhooks we deployed to lambda to github. 

In the previous section when deploying the webhooks, there were outputs of the lambda function urls that will be needed for use in this section. 

```
lambda_function_urls = {
  "pr_closed" = "https://ezf4qxjpe3gcr4dwokpyhq5bz40tholo.lambda-url.us-east-2.on.aws/"
  "pr_edited" = "https://kiuq5yazpzdmklgb52ytf74eaa0vpyoo.lambda-url.us-east-2.on.aws/"
  "pr_opened" = "https://r4lt6fpncydxtxvsiv4bwoxvyq0cibpa.lambda-url.us-east-2.on.aws/"
  "pr_sync" = "https://ajeswab6dtejbj6vbjxdsssgsa0hyylg.lambda-url.us-east-2.on.aws/"
}
```

Alternatively, you can find the function URL by navigating to the lambdas in the AWS console.

<p align="center">
  <img src="./pictures/lambdas.png" /><br>
  <img src="./pictures/lambda-describe.png" />
</p>

Using `launch-cli`, you will need to run this for each of the 4 lambdas' functional URLs.

[WARNING]: You can not copy and paste this command directly. You need to update `MY_SECRET` with the value of the git secret created in the Secrets Manager section.

```sh
$ launch github hooks create --repository-name launch-demo-ecs-platform --events '["pull_request"]'  --secret MY_SECRET --url FUNCTION_URL_1
$ launch github hooks create --repository-name launch-demo-ecs-platform --events '["pull_request"]'  --secret MY_SECRET --url FUNCTION_URL_2
$ launch github hooks create --repository-name launch-demo-ecs-platform --events '["pull_request"]'  --secret MY_SECRET --url FUNCTION_URL_3
$ launch github hooks create --repository-name launch-demo-ecs-platform --events '["pull_request"]'  --secret MY_SECRET --url FUNCTION_URL_4
```

<p align="center">
  <img src="./pictures/launch-github-hooks-create-platform.png" />
</p>

The webhooks will initially fail as the lambda does not allow ping requests.

<p align="center">
  <img src="./pictures/github-settings-webhook-complete-platform.png" />
</p>


### 4.3. Deploy Service

#### 4.3.1 Open and merge your first pull request (PR)

#### 4.3.2 Manually deploy service
Deploy the ECS service. This is the actual ECS cluster. 

```sh
$ cd launch-demo-ecs-platform # Ensure you are in your created repository's directory
$ launch terragrunt --target-environment sandbox --platform-resource service --apply --generation
```

<p align="center">
  <img src="./pictures/launch-terragrunt-service-apply-platform-output-01.png" /><br>
  output truncated... <br>
  <img src="./pictures/launch-terragrunt-service-apply-platform-output-02.png" />
</p>


## 5. Appendix 
- [Platform Application Naming Schema](./../../../../../standards/common-development/git/repository/naming-schemes/platform-sample-applications.md)