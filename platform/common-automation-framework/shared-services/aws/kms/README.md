# Shared-service: Key Management Service (KMS)
### **Table of Contents**
1. [Introduction](#1-introduction)
2. [Prerequisites](#2-Prerequisites)
3. [Getting Started](#3)  
  3.1. [Configure the inputs](#31-configure-the-inputs)  
  3.2. [Create the repository](#32-create-the-repository)  
4. [Deploy service](#4-deploy-service)  
  4.1. [Deploy Resources](#41-deploy-resources)  
  4.2. [Connect webhooks](#42-connect-webhooks)  
5. [Appendix](#5-appendix)

## 1. **Introduction**

TODO:  
Current ARN: `arn:aws:kms:us-east-2:538234414982:key/ba37724b-ea39-45a5-a938-713fb9f88112`  
Key alias: `demo/example/kms`

## 2. **Prerequisites:**

In order to use this guide successfully, there may be assumptions within your current environment. Please follow these other guides that are dependencies to successfully utilizes this one. 

Local development environment:
  - [MacOS local developer environment](./../../../../../development-environments/local/mac/README.md)
  - [Windows local developer environment](./../../../../../development-environments/local/java/windows/README.md)
  
Cloud Services:
- None

## 3. **Getting Started**

### 3.1. Configure the inputs


### 3.2. Create the repository


## 4. **Deploy service**

### Pre-flight
Ensure your environmental variable `GIT_TOKEN` is set and you are logged into aws cli.

```sh
$ export GIT_TOKEN="YOUR_TOKEN"
$ aws sso login --profile "YOUR_AWS_PROFILE"
```

### 4.1. Deploy Resources

### 4.2. Connect webhooks


## 5. Appendix 
- [Platform Application Naming Schema](./../../../../../standards/common-development/git/repository/naming-schemes/platform-sample-applications.md)