# MacOS local developer environment
## **Table of Contents**
1. [Introduction](#1-introduction)
2. [Prerequisites](#2-prerequisites)
3. [Tool Installation](#3-tool-installation)  
  3.3. [Install IDE](#33-install-ide)  
  3.4. [Docker](#34-docker)
4. [Development Environment](#4-development-environment)  
  4.1. [Platform Container](#41-platform-container)  
  4.2. [Local Dev Container](#42-local-dev-container)  
  4.3. [Local system](#43-local-system)  
  4.4. [Builder tools](#44-builder-tools)  
5. [References](#5-references)

## 1. **Introduction**

This guide will walk you through setting up a local developer environment on a MacOS device. It provides instructions on how to install Homebrew, asdf version manager, IntelliJ IDEA, JavaSDK, and Gradle. In addition, it provides links on how to set up a development environment with using either the Launch platform container, a local developer container, or utilizing local build methods. 

## 2. Prerequisites:
1. MacOS 14.5+ M1.
2. User has rights to install softwares and change permissions as required on their machine.

## 3. Tool Installation

### 3.1 Install IDE

Please follow these guide to setup and install your IDE.:
- [IntelliJ IDEA](./../tools/intellij/README.md)
- [Visual Studio Code](./../tools/vscode/README.md)

### 3.2 Docker

Please use this guide to install Docker:
- [Docker](./../tools/docker/README.md)

## 4 Development Environment

A developer has a few different options to build and test their application. This section provides different options and only one of them needs to be chosen to develop, build, and test your application on your local machine.

### 4.1 Platform Container
TODO:

### 4.2 Local Dev Container
Launch platform includes support to utilize a common local developer container through your IDE. This Dev Container has all the tools and software loaded and configured to build and test utilizing the Launch platform. Please follow the following guides to utilize this method.

- [Setting up IntelliJ dev containers](./../../../development-environments/local/tools/intellij/dev-containers/README.md)
- [Setting up Visual Studio Code dev containers](./../../../development-environments/local/tools/vscode/dev-containers/README.md)

### 4.3 Local system
If you do not wish to utilize the launch containers. Please follow the guides in Section [4.4. Builder Tools](#44-builder-tools) to install all the tools you may need to build on your platform. 

### 4.4 Builder Tools

#### 4.4.1 Homebrew
We use homebrew to install the `asdf` utility. Please follow this guide to install it.
- [Homebrew](./../tools/homebrew/README.md)

#### 4.4.2 asdf
Please follow this guide to install asdf.
- [asdf](./../tools/asdf/README.md)

#### 4.4.3 Common:
- [launch-cli]()

#### 4.4.4 Cloud Provider:
- [AWS cli](./../tools/aws/cli/README.md)
- [AWS SSO](./../tools/aws/sso-login/README.md)

#### 4.4.5 Java:
Runtimes:
- [Java JDK 17](./../tools/java/17/README.md)

Build tools:
- [Gradle](./../tools/gradle/README.md)

## 5. **References**
- [Homebrew official](https://brew.sh/) install guide
- [asdf official](https://asdf-vm.com/guide/getting-started.html) install guide
- [IntelliJ official](https://www.jetbrains.com/help/idea/installation-guide.html#-u36bwj_90) install guide
- [Docker official](https://docs.docker.com/desktop/install/mac-install/) install guide