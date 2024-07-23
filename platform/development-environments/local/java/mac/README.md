# Introduction
This(https://github.com/launchbynttdata/launch-api-hex-java-template) is a template java project built on the principles of
- Hexagonal architecture
    - clean separation between the core business logic & external interfaces.
- Command Query Responsibility Segregation and
    - separates read & write operations, allowing for better scalability & optimization.
- Utilizes OpenAPI for API generation
    - used for API documentation & generation, providing a standardized way to describe & define RESTful APIs.

This document contains instructions for Java developers and platform engineers to run the application locally on their mac based machines.

# Installation instructions to set up the developer machine:

# Pre-requisits:
1. User has mac machine with IOS.
2. User has rights to install softwares and change permissions as required on their machine.

# Installation Guide

## Java JDK

- Open Intellij IDE
- Click on Menu -> Project Structure -> SDKs -> Click folder icon next to JDK home path -> Download JDK
- Select Amazon Corretto 17 . Click Download
- Launch up Terminal. Type in the command "java –version" . If it does not work, go to the trouble shooting section.
- Run the command in terminal to set JAVA_HOME "export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home"
- Add the jdk/bin path to system path variable PATH=$JAVA_HOME/bin:$PATH

## TroubleShooting JDK Installation
- Check if there are any pre-existing Java installs. Uninstall them and reinstall again
- Temporarily turn off firewalls and antivirus software.
- If you get file corrupt message, download the installation file again.
- Ensure you are making use of the right java download.


## IntelliJ IDEA
- Download Intellij Community Edition from https://www.jetbrains.com/idea/download/?section=mac
- Run the installer, specify path for installation
- Open the IDE, select the JDK path in the project structure as mentioned in the Java JDK section.
- Open the cloned project in IDE. Menu -> Open -> Select the project folder . Click Open


## Gradle
- Intellij IDE has in built Gradle support
- Settings ->Build, Execution, Deployment -> Build Tools -> Gradle
- select the installed JDK version under Gradle JVM

## Docker
- Download Mac Docker Desktop using https://www.docker.com/products/docker-desktop/
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
Platform engineerings who would like to run the application locally(without having to make the code changes), can set up `docker` on their machines to build/deploy applications.

## Make commands
- List the `make commands` here to build the image and start and test the application locally.

