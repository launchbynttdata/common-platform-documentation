# Shared-service: Identity and Access Management (IAM)
### **Table of Contents**
1. [Introduction](#1-introduction)
2. [Prerequisites](#2-Prerequisites)
3. [Getting Started](#3)  
  3.1. [Configure the inputs](#31-configure-the-inputs)  
  3.2. [Create the repository](#32-create-the-repository)  
  3.3. [Open and merge your first PR](#33-open-and-merge-your-first-pr)
4. [Manually deploy service](#4-deploy-service)  
  4.1. [Deploy Resources](#41-deploy-resources)  
  4.2. [Connect webhooks](#42-connect-webhooks)  
5. [Teardown Service](#5-teardown-service)
6. [Appendix](#6-appendix)

## 1. **Introduction**

TODO:

```sh
arn:aws:iam::020127659860:role/demo_iam-useast2-sandbox-000-role-000
```

<p align="center">
  <img src="./pictures/iam-complete.png" />
</p>

## 2. **Prerequisites:**

In order to use this guide successfully, there may be assumptions within your current environment. Please follow these other guides that are dependencies to successfully utilizes this one. 

Local development environment:
  - [MacOS local developer environment](./../../../../../development-environments/local/mac/README.md)
  - [Windows local developer environment](./../../../../../development-environments/local/java/windows/README.md)

## 3. **Getting Started**

### 3.1. Configure the inputs


### 3.2. Create the repository
We are now going to create the IAM properties repository.

- Replace the path in the `--in-file` argument to the absolute path of the `.launch_config` file saved in the previous section. 
- We are going to use the `--name` of `launch-demo-iam` in this demo, but you can name it what ever you want.

```sh
$ launch service create --name launch-demo-iam --in-file /workspaces/workplace/common-platform-documentation/platform/common-automation-framework/shared-services/aws/iam/inputs/.launch_config
```

<p align="center">
  <img src="./pictures/launch-service-create-platform-output.png" /> 
</p>

## 4. **Deploy service**

### Pre-flight
1. Please ensure you have generated a Github token and it is ready to use in your environment.
    - [Github Token](./../../../../development-environments/local/tools/token/README.md)

2. Please ensure you have set your AWS credentials.
    - If using SSO: [AWS SSO](./../../../../../development-environments/local/tools/aws/sso-login/README.md)
    - Standard config: [AWS cli](./../../../../../development-environments/local/tools/aws/cli/README.md)

### 4.1. Deploy Infrastructure


### 4.2. Connect Webhooks
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
$ launch github hooks create --repository-name launch-demo-iam --events '["pull_request"]'  --secret MY_SECRET --url FUNCTION_URL_1
$ launch github hooks create --repository-name launch-demo-iam --events '["pull_request"]'  --secret MY_SECRET --url FUNCTION_URL_2
$ launch github hooks create --repository-name launch-demo-iam --events '["pull_request"]'  --secret MY_SECRET --url FUNCTION_URL_3
$ launch github hooks create --repository-name launch-demo-iam --events '["pull_request"]'  --secret MY_SECRET --url FUNCTION_URL_4
```

<p align="center">
  <img src="./pictures/launch-github-hooks-create-platform.png" />
</p>

The webhooks will initially fail as the lambda does not allow ping requests.

<p align="center">
  <img src="./pictures/github-settings-webhook-complete-platform.png" />
</p>

### 4.3. Deploy Service

#### 4.3.2 Manually deploy service
Deploy the IAM service. This is the actual IAM role. 

```sh
$ cd launch-demo-iam # Ensure you are in your created repository's directory
$ launch terragrunt --target-environment sandbox --platform-resource service --apply --generation
```

<p align="center">
  <img src="./pictures/launch-terragrunt-service-apply-platform-output-01.png" /><br>
  output truncated... <br>
  <img src="./pictures/launch-terragrunt-service-apply-platform-output-02.png" />
</p>

#### 4.3.1 Open and merge your first pull request (PR)

## 5. **Teardown Service**

## 6. **Appendix**
- [Platform Application Naming Schema](./../../../../../standards/common-development/git/repository/naming-schemes/platform-sample-applications.md)