# git-credential-manager
## **Table of Contents**
1. [Introduction](#1-introduction)
2. [Prerequisites](#2-prerequisites)
3. [Install git-credential-manager ](#3-install-homebrew)  
    3.1. [MacOS local](#31-macos-local)  
    3.2. [Windows local](#31-windows-local) 
4. [Appendix](#4-appendix)

## 1. **Introduction**
This guide will walk you through installing git-credential-manager (GCM) on your local device. GCM is used to store your local git credentials to manage the authentication with your SCM.

## 2. **Prerequisites**
In order to use this guide successfully, there may be assumptions within your current environment. Please follow these other guides that are dependencies to successfully utilizes this one. 

Local development environment:  
- [MacOS local developer environment](./../../mac/README.md)
- [Windows local developer environment](./../../windows/README.md)

MacOS:
- [Homebrew](./../homebrew/README.md)

## 3. **Install git-credential-manager**

### 3.1. MacOS
1. Open Terminal.

2. Install git-credential-manager by running the following command:

    ```sh
    brew install --cask git-credential-manager
    ```

3. Once the installation is complete, configure your git credential helper:

    ```sh
    git config --global credential.credentialStore manager
    ```

4. (Optional) Some tools like `launch-cli` will need your `GITHUB_TOKEN` set.

    ```sh
    export GITHUB_TOKEN=<replace_me>
    ```

### 3.2. Windows

## 4. **Appendix**
- [MacOS local developer environment](./../../mac/README.md)
- [Homebrew](./../homebrew/README.md)
