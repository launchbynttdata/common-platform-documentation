# Windows local environment
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
  5.2. [Common](#52-common)  
  5.3. [Cloud Provider](#53-cloud-provider)  
  5.4. [Java](#54-java)
6. [References](#6-references)

## 1. **Introduction**

## 2. Prerequisites:
1. User has Windows 11 machine with 64 bit OS.
2. User has administrative rights to install softwares and change permissions as required on their machine.

# Installation Guide

## WSL
- Install WSL on your Windows system, open PowerShell as an Administrator (Follow steps from https://learn.microsoft.com/en-us/windows/wsl/install)
- Use command `wsl --install`
- Reboot your computer when prompted
- After rebooting, open the newly installed Linux distribution from the Start menu.
- Use `wsl -l -v` command to check the version installed
- You’ll be prompted to create a new user account and password
- open File Explorer and type `\\wsl$` in the address bar to access the Linux file system

Note: If all the software here onwards need to be deployed in WSL, specify the instructions accordingly.

## IntelliJ IDEA
- Download Intellij Community Edition from https://www.jetbrains.com/idea/download/?section=windows
- Run the installer, specify path for installation
- Open the IDE, select the JDK path in the project structure as mentioned in the Java JDK section, follow the steps.
- Open the cloned project in IDE. Menu -> Open -> Select the project folder -> Click Open

## Docker
- Download Windows Docker Desktop using https://www.docker.com/products/docker-desktop/
- Run the installer
- Open the Docker Desktop application. All the containers running will be shown in the dashboard.
