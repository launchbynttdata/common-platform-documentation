# MacOS local environment
## **Table of Contents**
1. [Introduction](#1-introduction)
2. [Prerequisites](#2-prerequisites)
3. [Tool Installation](#3-tool-installation)  
  3.1. [Install IDE](#31-install-ide)  
  3.2. [Docker](#32-docker)
4. [Development Environment](#4-development-environment)  
  4.1. [(Option 1) Platform Container](#41-option-1-platform-container)  
  4.2. [(Option 2) Local Dev Container](#42-option-2-local-dev-container)  
  4.3. [(Option 3) Local system](#43-option-3-local-system)  
  4.4. [Getting started with environment](#44-getting-started-with-environment)  
5. [Builder tools](#5-builder-tools)  
  5.1. [OS Specific](#51-os-specific)  
  5.2. [Common](#52-common)  
  5.3. [Cloud Provider](#53-cloud-provider)  
  5.4. [Java](#54-java)
6. [References](#6-references)

## 1. **Introduction**
This guide will walk you through setting up a local developer environment on a MacOS device. It provides instructions on how to install Homebrew, asdf version manager, Jetbrains IDEs, JavaSDK, and Gradle. In addition, it provides links on how to set up a development environment with using either the Launch platform container, a local developer container, or utilizing local build methods. 

## 2. Prerequisites:
1. MacOS 14.5+ with an ARM CPU
2. User has rights to install softwares and change permissions as required on their machine.

## 3. Tool Installation

### 3.1 Install IDE
Please follow these guide to setup and install your IDE.:
- [Jetbrains IDEs](./../tools/jetbrains/README.md)
- [Visual Studio Code](./../tools/vscode/README.md)

### 3.2 Docker
Please use this guide to install Docker:
- [Docker](./../tools/docker/README.md)

## 4 Development Environment
A developer has a few different options to build and test their application. This section provides different options and only one of them needs to be chosen to develop, build, and test your application on your local machine.

### 4.1 (Option 1) Platform Container
TODO:

### 4.2 (Option 2) Local Dev Container
Launch platform includes support to utilize a common local developer container through your IDE. This Dev Container has all the tools and software loaded and configured to build and test utilizing the Launch platform. Please follow the following guides to utilize this method.

- [Setting up IntelliJ dev containers](./../../../development-environments/local/tools/intellij/dev-containers/README.md)
- [Setting up Visual Studio Code dev containers](./../../../development-environments/local/tools/vscode/dev-containers/README.md)

### 4.3 (Option 3) Local system
If you do not wish to utilize the launch containers. Please follow the guides in Section [4.4. Builder Tools](#44-builder-tools) to install all the tools you may need to build on your platform. 

### 4.4 Getting started with environment
You can utilize our Capability Matrix to get started with your development environment to deploy our accelerators. 
- [Launch CAF Capability Matrix](./../../../common-automation-framework/README.md)

## 5. **Builder Tools**

### 5.1 OS Specific
#### 5.1.1 MacOS
We use homebrew to install the `asdf` utility. Please follow this guide to install it.
- [Homebrew](./../tools/homebrew/README.md)

#### 5.1.2 Windows
- WSL

### 5.2 Common
We use asdf to manage our runtime versions for the `common-automation-framework`.
- [asdf](./../tools/asdf/README.md)

Our automation is handled through the `launch-cli` utility.
- [launch-cli]()

### 5.3 Cloud Provider:
- [AWS cli](./../tools/aws/cli/README.md)
- [AWS SSO](./../tools/aws/sso-login/README.md)

### 5.4 Java:
Runtimes:
- [Java JDK 17](./../tools/java/17/README.md)

Build tools:
- [Gradle](./../tools/gradle/README.md)

## 6. **References**
- [Launch CAF Capability Matrix](./../../../common-automation-framework/README.md)
- [Official Homebrew](https://brew.sh/) install guide
- [Official asdf](https://asdf-vm.com/guide/getting-started.html) install guide
- [Official IntelliJ](https://www.jetbrains.com/help/idea/installation-guide.html#-u36bwj_90) install guide
- [Official Docker](https://docs.docker.com/desktop/install/mac-install/) install guide