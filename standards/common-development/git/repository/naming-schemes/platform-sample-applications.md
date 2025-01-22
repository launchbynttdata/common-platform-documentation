# Platform Sample Applications

Names for our IaC Git repositories are standardized to provide a predictable format for easy lookup and retrieval. Repository names are case-insensitive and should always be normalized to lowercase and folded to ASCII characters.

Sample Applications maintained by the Platform Team should follow the following general format:

> language-platform-sample-description

## Separators

We use hyphens (`-`) to separate fields in a repository's name. Only underscores (`_`) are used within a field to separate words, and any compound value for a [language](#language) or [description](#description) should be expressed in `snake_case`, that is, lowercase words separated by underscores.

## Language

**Language** indicates the programming language or runtime for which the sample application is written.

For the major Javascript Frameworks (React, Vue, Angular, NextJS), we will use the framework name in this field directly.

Some valid options might be:

- `dotnet` for .NET applications written in a CLR language (C#, F#)
- `java` for Java applications
- `javascript` or `typescript` for a web application that doesn't use a major JS/TS Framework
- `react`, `angular`, `vue`, or `nextjs` for a web application using one of those frameworks
- `python` for Python modules
∂
## Platform

For all sample applications maintained by the Platform Team, this value is a constant `platform` if the application code is agnostic to the runtime environment. If there are cloud-specific qualities to the application (perhaps it was designed to work with a specific AWS resource like Kinesis), the value should reflect the cloud provider and match the [providers from the general IAC naming standards](./iac-repository-names.md#provider).

## Sample

For all sample applications maintained by the Platform Team, the field for type is a constant value `sample`.

## Description

The **description** field should describe the sample application in broad terms. Separators in the name are limited to underscore (`_`) characters.

For most sample applications, this should be something extremely simple, like `rest_api`, `queue_consumer`, or `static_frontend`.

# Examples in Practice

Below are some example names and explanations of what they should contain.

- `dotnet-platform-sample-rest_api`

Represents a C# REST API with no cloud-specific requirements. This example API might provide a single route and return a static response like "Hello World".

- `java-platform-sample-queue_consumer`

A Java application designed to pick up example messages from a message queue.

- `angular-platform-sample-static_frontend`

An Angular JS application to serve as an example static frontend (i.e. only static files are produced, no Node server is involved in servicing requests)

- `python-platform-sample-wsgi_rest_api`

A Python application using a WSGI framework (e.g. Django) to provide a REST API. The asynchronous equivalent might be `asgi_rest_api` for a FastAPI or Litestar application.
