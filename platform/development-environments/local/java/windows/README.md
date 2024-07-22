# Introduction
This(Add URL here for the java sample app project) is a template java project built on the principles of
- Hexagonal architecture
    - clean separation between the core business logic & external interfaces.
- Command Query Responsibility Segregation and
    - separates read & write operations, allowing for better scalability & optimization.
- Utilizes OpenAPI for API generation
    - used for API documentation & generation, providing a standardized way to describe & define RESTful APIs.

This document contains instructions for Java developers and platform engineers to run the application locally on their Windows based machines.

# Installation instructions to set up the developer machine:

# Pre-requisits:
1. User has Windows machine with xxx OS.
2. User has admnistrative rights to install softwares and change permissions as required on their machine.

# Installation Guide

## WSL
- Add URL from where package with specific version can be downloaded
- Point to installation instructions on the website/list those in this README
- Add instructions to export the ENVIRONMENT variables along with their path if necessary
- Add instructions on how to verify the installtion.
- Add troubleshooting steps for common problems faced during installation
Note: If all the softwares here onwards need to be deployed in WSL, specify the instructions accordingly.

## Java JDK
- Add URL from where package with specific version can be downloaded
- Point to installation instructions on the website/list those in this README
- Add instructions to export the ENVIRONMENT variables along with their path if necessary
- Add instructions on how to verify the installtion.
- Add troubleshooting steps for common problems faced during installation

## IntelliJ IDEA
- Add URL from where package with specific version can be downloaded
- Point to installation instructions on the website/list those in this README
- Add instructions to export the ENVIRONMENT variables along with their path if necessary
- Add instructions on how to verify the installtion.
- Add troubleshooting steps for common problems faced during installation

## Gradle
- Add URL from where package with specific version can be downloaded
- Point to installation instructions on the website/list those in this README
- Add instructions to export the ENVIRONMENT variables along with their path if necessary
- Add instructions on how to verify the installtion.
- Add troubleshooting steps for common problems faced during installation

## Docker
- Add URL from where package with specific version can be downloaded
- Point to installation instructions on the website/list those in this README
- Add instructions to export the ENVIRONMENT variables along with their path if necessary
- Add instructions on how to verify the installtion.
- Add troubleshooting steps for common problems faced during installation

## Source code
- Add steps here to clone the repository from a github repository url.

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

