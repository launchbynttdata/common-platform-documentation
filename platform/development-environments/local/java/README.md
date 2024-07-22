# Introduction

This is a template java project built on the principles of
- Hexagonal architecture
    - clean separation between the core business logic & external interfaces.
- Command Query Responsibility Segregation and
    - separates read & write operations, allowing for better scalability & optimization.
- Utilizes OpenAPI for API generation
    - used for API documentation & generation, providing a standardized way to describe & define RESTful APIs.



# Getting Started
1. Learn to install and get started with Java, Intellij, Gradle, Spring, Spring Boot and docker in easy steps in Mac and Windows

# Installation Guide

1. Search for “install amazon corretto 17 ” on browser
2. https://docs.aws.amazon.com/corretto/latest/corretto-17-ug/macos-install.html
3. Download and install the jdk version
4. launch up Terminal. Type in the command “java –version” . If it does not work, go to the trouble shooting section.
5. Add to environment variables as JAVA_HOME and in system path variables
6. Search for Intellij community edition on browser
7. Choose the right Operation System , Download and Install Intellij
8. Download Gradle zip file
9. Unzip the distribution zip file in the directory of your choosing
10. Configure your PATH environment variable to include the bin directory of the unzipped distribution
11. Install Windows subsystem for linux . Follow https://learn.microsoft.com/en-us/windows/wsl/install
12. Download the docker installer from bowser
13. Install the docker executable. By default, Docker Desktop is installed
14. When prompted, ensure the Use WSL 2 instead of Hyper-V option on the Configuration page. Continue with the Installation
15. If your admin account is different to your user account, you must add the user to the docker-users group:
    - Run Computer Management as an administrator.
    - Navigate to Local Users and Groups > Groups > docker-users.
    - Right-click to add the user to the group.
    - Sign out and sign back in for the changes to take effect.

# Trouble Shooting

1. Check if there are any pre-existing Java installs. Uninstall them and reinstall again
2. Temporarily turn off firewalls and antivirus software.
3. If you get file corrupt message, download the installation file again.
4. Ensure you are making use of the right java download.

# Build and Test

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


# Contract testing with Pact

- the contact files are created when the consumer pact tests are run & can be found under the build/pacts.
- run `docker-compose up` to start the pact broker.
- run `./gradlew pactPublish` to push the contract to the broker.

