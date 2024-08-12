# Visual Studio Code Dev Containers
## **Table of Contents**
1. [Introduction](#1-introduction)
2. [Prerequisites](#2-Prerequisites)
3. [Step-by-step Guide](#3-step-by-step-guide)  
  3.1. [Install Extension](#31-install-extension)  
  3.2. [Configure a workspace](#32-configure-a-workspace)  
  3.3. [Create a new Dev Container](#33-create-a-new-dev-container)  
  3.4. [Configure Container](#34-configure-container)  
  3.5. [Build and Open the Container](#35-build-and-open-the-container)
4. [Reference](#4-reference)

## 1. Introduction
This guide will walk you through setting up a development container environment using Visual Studio Code (VS Code) Dev Containers. By using dev containers, you can ensure a consistent and reproducible development environment for your code.

## 2. Prerequisites
In order to use this guide successfully, there may be assumptions within your current environment. Please follow these other guides that are dependencies to successfully utilizes this one. 

Local development environment:  
- [MacOS local developer environment](./../../../mac/README.md)
- [Windows local developer environment](./../../../windows/README.md)
- [VS Code is installed](./../README.md)

## 3. Step-by-step Guide

### 3.1. Install Extension
Please follow this guide on how to install an extension in VS Code:
- [https://code.visualstudio.com/docs/editor/extension-marketplace](https://code.visualstudio.com/docs/editor/extension-marketplace)

Please install the `Dev Containers` extension from the extension marketplace:
- [https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

<p align="center">
  <img src="./pictures/dev-containers-install.png" /> 
</p>

### 3.2. Configure a workspace
Somewhere within your base operating system, please create or identify a folder in which you wish to be the root of your dev container's home directory. Within this example, we have created a new folder called `workplace` within the home directory of the user. When you run a dev container, you have the ability to attach it to your current workspace. This path is going to be needed in some of the scripts we are going to be updating.

```
/Users/MyUser/workplace
```

### 3.3. Create a new Dev Container
In your vscode search bar, search for `Dev Containers: New Container` and click on it.
<p align="center">
  <img src="./pictures/dev-containers-new-container.png" /> 
</p>

A mini-wizard will pop up. Search for `Ubuntu` and click on it.

<p align="center">
  <img src="./pictures/dev-containers-new-container-ubuntu.png" /> 
</p>

Click `Create Dev Container`

<p align="center">
  <img src="./pictures/dev-containers-new-container-ubuntu-create.png" /> 
</p>

This will create and build a new Ubuntu dev container. 

<p align="center">
  <img src="./pictures/dev-containers-new-container-ubuntu-fresh.png" /> 
</p>

### 3.4. Configure Container
We are now going to update the `.devcontainer.json` with our template from this guide. You can find the file at:

- [devcontainer.json](./files/.devcontainer.json)

There is also another file within this guide called `.devcontainer.postCreate.sh`. This script is a first time boot script that runs after your container is built. This script performs most of our containers configuration. 
- [.devcontainer.postCreate.sh](./files/.devcontainer.postCreate.sh)

Within `.devcontainer.json`, update the relative path in the `postCreateCommand` to the path to where you saved `.devcontainer.postCreate.sh`. 
`./.devcontainer.postCreate.sh`
It is a good idea to save it in the workspace dir. In this guide, we will place it in a `.vscode` folder within the workspace directory.

<p align="center">
  <img src="./pictures/dev-containers-new-container-ubuntu-copy-settings.png" /> 
</p>

Within the `.devcontainer.postCreate.sh`, update the vars at the top of the file with your config.

<p align="center">
  <img src="./pictures/dev-containers-new-container-ubuntu-script-settings.png" /> 
</p>

### 3.5. Build and open the container
Rebuild the container `>Dev Container: Rebuild Container`

<p align="center">
  <img src="./pictures/dev-containers-new-container-ubuntu-rebuild.png" /> 
</p>

<p align="center">
  <img src="./pictures/dev-containers-new-container-ubuntu-rebuild-finished.png" /> 
</p>

<p align="center">
  <img src="./pictures/dev-containers-new-container-ubuntu-shell.png" /> 
</p>

## 4. References
- [Create a Dev Container](https://code.visualstudio.com/docs/devcontainers/create-dev-container)
- [Developing inside a Container](https://code.visualstudio.com/docs/devcontainers/containers)
