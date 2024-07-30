# Introduction
This [template](https://github.com/launchbynttdata/launch-api-hex-java-template) is a template java project built on the principles of
- Hexagonal architecture
    - clean separation between the core business logic & external interfaces.
- Command Query Responsibility Segregation and
    - separates read & write operations, allowing for better scalability & optimization.
- Utilizes OpenAPI for API generation
    - used for API documentation & generation, providing a standardized way to describe & define RESTful APIs.

This document contains instructions for Java developers and platform engineers to run the application locally on their Windows based machines.

# Installation instructions to set up the developer machine:

# Pre-requisits:
1. User has Windows 11 machine with 64 bit OS.
2. User has administrative rights to install softwares and change permissions as required on their machine.

# Installation Guide

## WSL
- Install WSL on your Windows system, open PowerShell as an Administrator (Follow steps from https://learn.microsoft.com/en-us/windows/wsl/install)
- Use command wsl --install
- Reboot your computer when prompted
- After rebooting, open the newly installed Linux distribution from the Start menu.
- Use wsl -l -v command to check the version installed
- You’ll be prompted to create a new user account and password
- open File Explorer and type \\wsl$ in the address bar to access the Linux file system

Note: If all the software here onwards need to be deployed in WSL, specify the instructions accordingly.

## Java JDK

- Open Intellij IDE
- Click on Menu -> Project Structure -> SDKs -> Click folder icon next to JDK home path -> Download JDK
- Select Amazon Corretto 17. Click Download
- Launch up Terminal. Type in the command "java –version". If it does not work, go to the troubleshooting section.
- Add to environment variables as JAVA_HOME  in system variables
- Add the jdk/bin path to system path variable

## TroubleShooting JDK Installation
- Check if there are any pre-existing Java installs. Uninstall them and reinstall again
- Temporarily turn off firewalls and antivirus software.
- If you get file corrupt message, download the installation file again.
- Ensure you are making use of the right java download.


## IntelliJ IDEA
- Download Intellij Community Edition from https://www.jetbrains.com/idea/download/?section=windows
- Run the installer, specify path for installation
- Open the IDE, select the JDK path in the project structure as mentioned in the Java JDK section. 
- Open the cloned project in IDE. Menu -> Open -> Select the project folder . Click Open


## Gradle
- Intellij IDE has in built Gradle support
- Settings ->Build, Execution, Deployment -> Build Tools -> Gradle
- select the installed JDK version under Gradle JVM

## Docker
- Download Windows Docker Desktop using https://www.docker.com/products/docker-desktop/
- Run the installer
- Open the Docker Desktop application. All the containers running will be shown in the dashboard.

## Source code
- Clone the repository from a github repository url.
- git clone https://github.com/launchbynttdata/launch-api-hex-java-template
- Open the cloned project in Intellij IDE

# Build and Test

## Build the application
1. Run the application in docker with postgres
    - `docker build . -t launch-api:s1`
    - `docker-compose up`: Create and start containers defined in a Docker Compose file.
    - `docker-compose down`: Stop and remove containers defined in a Docker Compose file.
    - use PgAdmin service to view the table & daa: http://localhost:5050/browser/
        - https://medium.com/@marvinjungre/get-postgresql-and-pgadmin-4-up-and-running-with-docker-4a8d81048aea
2. You can modify file: "[docker.env](docker.env)" to use in-memory H2 database instead of the Postgres DB
    1. If you are using H2 database you can connect to the H2 console: http://localhost:8087/h2-console (no password needed, just click "Connect").
3. Connect to the actuator with the credentials "test/test": http://localhost:8087/actuator
4. Open the API Docs: http://localhost:8087/swagger-ui.html

## Contract testing with Pact
- the contact files are created when the consumer pact tests are run & can be found under the build/pacts.
- run `docker-compose up` to start the pact broker.
- run `./gradlew pactPublish` to push the contract to the broker.

# For Platform Engineers
Platform engineers who would like to run the application locally(without having to make the code changes), can set up `docker` on their machines to build/deploy applications.

# Build using `make` commands

Launch Common Automation Framework(LCAF) offers standard set of commands to build/test/deploy applications written in different programming lanagugaes and architectures. It is acheived with help of `make` commands. The set of commands described below explain the process of building the docker image for the java application, starting the application locally, bringing it down and pushing the image to the remote repository.

## `make` commands:

### Pre-requisits for running the `make` commands
1. User should have access to Elastic Container Registry(ECR), in AWS cloud to push/pull the images.
2. Login to AWS environment using terminal where rest of the `make` commands will be executed. <<aws profile name>> is the name of the aws profile that user has created for `sso login`
```
aws sso login --profile <<aws profile name>>
```
3. Export the profile as environment variable
```
export AWS_PROFILE=<<aws profile name>>
```
## Make commands
1. make configure
   This command uses `git repo` tool to fetch dependent repositories which store the code for underlining commands to run `make` commands mentioned below. `make configure` pulls `lcaf-component-container` repository which stores the code for underlining `make` commands.

2. make docker/check-env-vars
   `CONTAINER_REGISTRY, CONTAINER_IMAGE_NAME, CONTAINER_IMAGE_VERSION` variables are stored in `Makefile.includes` file. The values of these variables can be changed so we customize the image name, version number and container registry name. The `make` commands ensures these values are present. This command does validation check.

3. make docker/build
   This command builds the image using `Dockerfile`

4. make docker_compose/start
   This command runs `docker-compose up` command to start the application locally.

5. make docker_compose/stop
   This command runs `docker-compose up` command to stop the application locally.

6. make docker/aws_ecr_login
   This commands obtains authentication token to login to CONTAINER_REGISTRY in AWS cloud so that docker image can be pushed to the registry.

7. make docker/push
   This command builds and pushes the image to the container registry.


