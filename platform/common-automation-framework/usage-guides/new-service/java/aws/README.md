# Usage Guide: Create and deploy a new Java service [AWS] (1.5 hours)
## **Table of Contents**
1. [Introduction](#1-introduction)
2. [Prerequisites](#2-Prerequisites)
3. [Deploy Infrastructure](#3-deploy-infrastructure)
4. [Deploy Java Application](#4-deploy-java-application)
5. [View the Java Application](#5-view-the-java-application)
6. [Maintenance](#6-maintenance)

## 1. **Introduction**
This guide will describe how to deploy a new java service using Launch's cli utility `launch-cli`. Within this guide, we will deploy necessary infrastructure to host a container application. Among the infrastructure, we will deploy an ECR repository to store the new java containers being built. Secrets Manager to host your container's secrets with a new customer managed KMS key. Finally, it will deploy an ECS cluster to support and serve the new java service. 

High level diagram of the architecture we are going to create in this guide.

<p align="center">
  <img src="./pictures/userguide-ecs-complete.png" /> 
</p>

This guide has been modified to work with the following providers:

- Service provider: **AWS**
- Pipeline provider: **AWS**

External dependencies:
- Java application built to [Launch's requirements.](#TODO)
  - This guide will use the following repository: [https://github.com/launchbynttdata/launch-api-hex-java-template](https://github.com/launchbynttdata/launch-api-hex-java-template)

## 2. **Prerequisites:**

In order to use this guide, it is assumed your local development environment is set up to use the `launch-cli` platform. To log into your aws credentials, you can utilize the `aws sso utils`. 

Here is a list of complete guides to follow to set up your local development environment before this guide can be used successfully.
- Setting up local environment:
  - [Mac](./../../../../../development-environments/local/java/mac/README.md)
  - [Windows](./../../../../../development-environments/local/java/windows/README.md)
- [Setting up AWS config](./../../../../../development-environments/local/aws/config/README.md)
- [Setting up `aws-sso-utils`](./../../../../../development-environments/local/aws/sso-login/README.md)
- [Setting up Visual Studio Code](./../../../../../development-environments/local/vscode/README.md) (Optional)
- [Setting up Visual Studio Code dev containers](./../../../../../development-environments/local/vscode/dev-containers/README.md) (Optional)
- [Installing launch-cli](./../../../../README.md)
- [Configuring Github Personal Access Token](./../../../../../development-environments/local/token/README.md)

### Pre-flight
Ensure your environmental variable `GIT_TOKEN` is set and you are logged into aws cli.
```
$ export GIT_TOKEN="YOUR_TOKEN"
$ aws sso login --profile `YOUR_AWS_PROFILE`
```

## 3. **Deploy Infrastructure**

### 3.1 Deploy KMS Key 
In this section, we will be deploying the KMS keys needed for our secrets.

TODO:

Current ARN: `arn:aws:kms:us-east-2:538234414982:key/ba37724b-ea39-45a5-a938-713fb9f88112`  
Key alias: `demo/example/kms`

#### 3.1.1 Create the inputs for the KMS 
#### 3.1.2 Create the KMS service
#### 3.1.3 Generate the Terragrunt files for the KMS service
#### 3.1.4 Deploy the KMS service
#### 3.1.5 Connect the webhooks

### 3.2 Deploy Secrets Manager 
In this section, we will be deploying the secrets needed for our platform and java application.

TODO:

Current ARNs:
```
arn:aws:secretsmanager:us-east-2:538234414982:secret:github/launchbynttdata/tg-aws-shared-ecs_platform/git_secret
arn:aws:secretsmanager:us-east-2:538234414982:secret:launch/dso-platform/github/service_user/http_access_token
arn:aws:secretsmanager:us-east-2:538234414982:secret:launch/dso-platform/github/service_user/username
arn:aws:secretsmanager:us-east-2:538234414982:secret:example/postgres/username
arn:aws:secretsmanager:us-east-2:538234414982:secret:example/postgres/password
arn:aws:secretsmanager:us-east-2:538234414982:secret:example/actuator/username
arn:aws:secretsmanager:us-east-2:538234414982:secret:example/actuator/password
```

#### 3.2.1 Create the inputs for the Secrets Manager 
#### 3.2.2 Create the Secrets Manager service
#### 3.2.3 Generate the Terragrunt files for the Secrets Manager service
#### 3.2.4 Deploy the Secrets Manager service
#### 3.2.5 Connect the webhooks

### 3.3 Deploy IAM roles 
In this section, we will be deploying the IAM roles needed for our platform and java application. 

TODO:

Current ARNs:
```
arn:aws:iam::020127659860:role/dso-demo_tg_iam-useast2-sandbox-000-role-000
arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000
```
#### 3.3.1 Create the inputs for the IAM roles
#### 3.3.2 Create the IAM roles service
#### 3.3.3 Generate the Terragrunt files for the IAM roles service
#### 3.3.4 Deploy the IAM roles service
#### 3.3.5 Connect the webhooks

### 3.4 Deploy ECR Repository
In this section, we will be deploying the necessary infrastructure to store our java image built. 

TODO:

Current ARN: `arn:aws:ecr:us-east-2:538234414982:repository/launch-api`

#### 3.4.1 Create the inputs for the ECR Repository 
#### 3.4.2 Create the ECR Repository service
#### 3.4.3 Generate the Terragrunt files for the ECR Repository service
#### 3.4.4 Deploy the ECR Repository service
#### 3.4.5 Connect the webhooks

### 3.5 Deploy ECS Platform
In this section, we will be deploying the ECS platform that our application will be deployed onto. 

#### 3.5.1 Create the inputs for the ECS Platform
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

#### 3.5.2 Create the ECS Platform service
We are now going to create the ECS platform properties repository. This service is the ECS cluster that the java application will deploy too.

- Replace the path in the `--in-file` argument to the absolute path of the `.launch_config` file saved in the previous section. 
- We are going to use the `--name` of `launch-demo-ecs-platform` in this demo, but you can name it what ever you want.

```
$ launch service create --name launch-demo-ecs-platform --in-file /workspaces/workplace/common-platform-documentation/platform/common-automation-framework/usage-guides/new-service/java/aws/example_files/platform/.launch_config
```
<p align="center">
  <img src="./pictures/launch-service-create-platform-output.png" /> 
</p>

#### 3.5.3 Generate the Terragrunt files for the ECS Platform service

[INFO]: This step is optional and showing how to generate only the terragrunt files. The next step includes a `--generation` flag that does this step for us. You can skip this step.

Change into the directory of the newly created service. Once inside the new repositories' directory, we can generate the Terragrunt code.

```
$ cd launch-demo-ecs-platform
$ launch service generate
```
<p align="center">
  <img src="./pictures/launch-service-create-platform-cd.png" /> 
</p>

<p align="center">
  <img src="./pictures/launch-service-generate-platform-output.png" /> 
</p>

#### 3.5.4 Deploy the ECS Platform service

Deploy the ECS Platform service. This is the actual ECS cluster and related infrastructure. 

If you skipped the previous step, ensure you are in the newly created repository's directory. `cd launch-demo-ecs-platform`

```
$ launch terragrunt --target-environment sandbox --platform-resource service --apply --generation
```
<p align="center">
  <img src="./pictures/launch-terragrunt-service-apply-platform-output-01.png" /><br>
  output truncated... <br>
  <img src="./pictures/launch-terragrunt-service-apply-platform-output-02.png" />
</p>

Deploy the pipeline for the ECS Platform service. This step will deploy all the CICD pipeline infrastructure to manage this repository. 

If you skipped the previous step, ensure you are in the newly created repository's directory.
```
$ launch terragrunt --target-environment root --platform-resource pipeline --apply --generation
```
<p align="center">
  <img src="./pictures/launch-terragrunt-pipeline-apply-platform-output-01.png" /><br>
  output truncated... <br>
  <img src="./pictures/launch-terragrunt-pipeline-apply-platform-output-02.png" />
</p>

Deploy the webhooks for the ECS Platform service. This will deploy lambda functions that we can connect to a SCM for pull request building events and triggering deployment pipelines. 

```
$ launch terragrunt --target-environment root --platform-resource webhook --apply --generation
```
<p align="center">
  <img src="./pictures/launch-terragrunt-webhook-apply-platform-output-01.png" /><br>
  output truncated... <br>
  <img src="./pictures/launch-terragrunt-webhook-apply-platform-output-02.png" />
</p>

#### 3.5.5 Connect the webhooks

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

Using `launch-cli`, you will need to run this for each of the 4 lambda's functional url's.

[WARNING]: You can not copy and paste this command directly. You need to update `MY_SECRET` with the value of the git secret created in the Secrets Manager section.


```
$ launch github hooks create --repository-name launch-demo-ecs-platform --events '["pull_request"]'  --secret MY_SECRET --url FUNCTION_URL
$ launch github hooks create --repository-name launch-demo-ecs-platform --events '["pull_request"]'  --secret MY_SECRET --url FUNCTION_URL
$ launch github hooks create --repository-name launch-demo-ecs-platform --events '["pull_request"]'  --secret MY_SECRET --url FUNCTION_URL
$ launch github hooks create --repository-name launch-demo-ecs-platform --events '["pull_request"]'  --secret MY_SECRET --url FUNCTION_URL
```

<p align="center">
  <img src="./pictures/launch-github-hooks-create-platform.png" />
</p>

The webhooks will initially fail as the lambda does not allow ping requests.
<p align="center">
  <img src="./pictures/github-settings-webhook-complete-platform.png" />
</p>


## 4. **Deploy Java application**

#### 4.1.1 Create the inputs for the Java application

The launch config for the application in this guide is at the following:
- [./example_files/application/.launch_config](example_files/application/.launch_config)

Open this file and update the `properties_file` key with the absolute path from your system to the input files to be used, and then save it.

We are going to be using the following inputs for our `.launch_config` files. 
- [Service `properties file` ./example_files/application/service.sandbox.us-east-2.tfvars](./example_files/application/service.sandbox.us-east-2.tfvars)
- [Pipeline `properties file` ./example_files/application/pipeline.root.us-east-2.tfvars](./example_files/application/pipeline.root.us-east-2.tfvars)
- [Webhooks `properties file` ./example_files/application/webhooks.root.us-east-2.tfvars](./example_files/application/webhooks.root.us-east-2.tfvars)

This file also includes 2 other files for jinja templates. Update these paths as well.
- [Application inputs `properties file` ./example_files/application/service.sandbox.us-east-2.tfvars](./example_files/application/common-application-config-non-secret.env.jinja2)
- [Application secrets `properties file` ./example_files/application/pipeline.root.us-east-2.tfvars](./example_files/application/common-application-config-secret.env.jinja2)


Open this file and update the `properties_file` key with the absolute path from your system to the input files to be used and then save it.
<p align="center">
  <img src="./pictures/launch_config-paths-application.png" /> 
</p>

#### 4.1.2 Create the Java application service
We are now going to create the Java application properties repository.

Ensure you change back into your working directory `cd ..` , as you do not want to accidentally create another repository inside the previously created platform repository. 

- Replace the path in the `--in-file` argument to the absolute path of the `.launch_config` file saved in the previous section. 
- We are going to use the `--name` of `launch-demo-ecs-application` in this demo, but you can name it what ever you want.
```
$ launch service create --name launch-demo-ecs-application --in-file /workspaces/workplace/common-platform-documentation/platform/common-automation-framework/usage-guides/new-service/java/aws/example_files/application/.launch_config
```
<p align="center">
  <img src="./pictures/launch-service-create-application-output.png" /> 
</p>

#### 4.1.3 Build the image and push
Change into the directory of the newly created service. Once inside the new repositories' directory, build the application's Docker image and push it to a container repository. 
```
$ cd launch-demo-ecs-application
$ launch service build --container-registry "538234414982.dkr.ecr.us-east-2.amazonaws.com" --container-image-name "launch-api" --container-image-version "0.0.1-dev" --push
```
<p align="center">
  <img src="./pictures/launch-service-create-application-cd.png" /> <br>
  <img src="./pictures/launch-service-build-application-output-01.png" /> <br>
  output truncated... <br>
  <img src="./pictures/launch-service-build-application-output-02.png" />
</p>

#### 4.1.4 Generate the Terragrunt files for the Java application service

[INFO]: This step is optional and showing how to generate only the terragrunt files. The next step includes a `--generation` flag that does this step for us. You can skip this step.

Generate the Terragrunt code of the Java application.

```
$ launch service generate
```
<p align="center">
  <img src="./pictures/launch-service-generate-platform-output.png" /> 
</p>

#### 4.1.5 Deploy the Java application service

We will now deploy the Java application service. 

```
$ launch terragrunt --target-environment sandbox --platform-resource service --apply --generation --render-app-vars
```
<p align="center">
  <img src="./pictures/launch-terragrunt-service-apply-application-output-01.png" /><br>
  output truncated... <br>
  <img src="./pictures/launch-terragrunt-service-apply-application-output-02.png" />
</p>

Deploy the pipeline for the Java application service
```
$ launch terragrunt --target-environment root --platform-resource pipeline --apply --generation
```
<p align="center">
  <img src="./pictures/launch-terragrunt-pipeline-apply-application-output-01.png" /><br>
  output truncated... <br>
  <img src="./pictures/launch-terragrunt-pipeline-apply-application-output-02.png" />
</p>

Deploy the webhooks for the Java application  service
```
$ launch terragrunt --target-environment root --platform-resource webhook --apply --generation
```
<p align="center">
  <img src="./pictures/launch-terragrunt-webhook-apply-application-output-01.png" /><br>
  output truncated... <br>
  <img src="./pictures/launch-terragrunt-webhook-apply-application-output-02.png" />
</p>


#### 4.1.6 Connect the webhooks
Within this section, we need to connect the webhooks for the newly created service and the Java application. Both of these repositories will utilize the same webhooks.

Like the other section, you will need the function urls found in the output of the webhooks deployment or in the AWS console. 

```
lambda_function_urls = {
  "pr_closed" = "https://p2jk22u7zdx7pzsymyilsgutkq0mydcm.lambda-url.us-east-2.on.aws/"
  "pr_edited" = "https://z2eblvqlfag47jczuxp4ftchja0htekd.lambda-url.us-east-2.on.aws/"
  "pr_opened" = "https://nxnzebxlyzjqezihicogxgdp3m0mpeqy.lambda-url.us-east-2.on.aws/"
  "pr_sync" = "https://lmlhuj3xjog27jr7lb7diokhc40utzbu.lambda-url.us-east-2.on.aws/"
}
```

Using `launch-cli`, you will need to run this for each of the 4 lambda's functional url's.

<div style="padding: 15px; border: 1px solid transparent; border-color: transparent; margin-bottom: 20px; border-radius: 4px; color: #a94442; background-color: #f2dede; border-color: #ebccd1;">
You can not copy and paste this command directly. You need to update `MY_SECRET` with the value of the git secret created in the Secrets Manager section and the FUNCTION_URL for the lambda function url. 
</div>

```
$ launch github hooks create --repository-name launch-demo-ecs-application --events '["pull_request"]'  --secret MY_SECRET --url FUNCTION_URL
$ launch github hooks create --repository-name launch-demo-ecs-application --events '["pull_request"]'  --secret MY_SECRET --url FUNCTION_URL
$ launch github hooks create --repository-name launch-demo-ecs-application --events '["pull_request"]'  --secret MY_SECRET --url FUNCTION_URL
$ launch github hooks create --repository-name launch-demo-ecs-application --events '["pull_request"]'  --secret MY_SECRET --url FUNCTION_URL
```

<p align="center">
  <img src="./pictures/launch-github-hooks-create-application.png" />
</p>

You will also need to connect the webhooks to the repository where your Java application lives. In this case, [launch-api-hex-java-template](https://github.com/launchbynttdata/launch-api-hex-java-template). You will use the same function urls.

<p align="center">
  <img src="./pictures/launch-github-hooks-create-java.png" />
</p>

The webhooks will initially fail as the lambda does not allow ping requests.
<p align="center">
  <img src="./pictures/github-settings-webhook-complete-platform.png" />
</p>

## 5. **View the Java Application**

<div style="padding: 15px; border: 1px solid transparent; border-color: transparent; margin-bottom: 20px; border-radius: 4px; color: #8a6d3b;; background-color: #fcf8e3; border-color: #faebcc;">
This guide is not complete. You will need to manually update the following while updating on the additional development of the outstanding terraform modules.

- Update Secrets in root account with ecs task execution role
- Update KMS in root account with ecs task execution role
- Update ECR in root account with ecs task execution role
- create 8080 listener on `vpn-poc-nlb1` to `vpn-poc-nlb-albtg-privatelink2` target group
- attach ECS LB to the `vpn-poc-nlb-albtg-privatelink2` TG. 
</div>

In order to view the Java application, we need a way to access the private VPC that we deployed it into.

Perform these guides to deploy an AWS Client VPN utilizing the launch platform to view this application in a private VPC:

- [Deploy Client VPN](#TODO)
- [Configure VPN Client](#TODO)

Once you are able to connect to the private VPC that your application is running in:
 - You should see your application running by navigating to [http://vpn-poc-nlb1-84d114247ebc21eb.elb.us-east-2.amazonaws.com:8080/swagger-ui/index.html](http://vpn-poc-nlb1-84d114247ebc21eb.elb.us-east-2.amazonaws.com:8080/swagger-ui/index.html). 

<p align="center">
  <img src="./pictures/ecs-app-webview.png" /><br>
</p>


## 6. **Maintenance**