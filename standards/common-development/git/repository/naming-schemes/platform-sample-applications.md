# Name platform sample applications by language, platform, and purpose

**Strength:** Team default

## The problem

Sample applications are how the platform team shows a supported path and how it exercises a component. A sample whose name does not say what it is, or that hides a cloud-specific choice, gets reused for the wrong runtime or the wrong cloud.

## The position

A sample application maintained by the platform team uses four fields: language, platform, the literal type `sample`, and a short description.

```text
language-platform-sample-description
```

Names are lowercase ASCII. Hyphens separate the fields. Underscores separate words inside a field. The type field is always `sample`, so a sample cannot be confused with a module.

The platform field is `platform` when the application is not written for one cloud. When the application depends on a specific cloud resource, the platform field uses the same provider names as [infrastructure repository names](iac-repository-names.md).

## What the team expects

**Language.** Name the language or the framework that determines how the sample is built. Use `dotnet`, `java`, `python`, `javascript`, or `typescript` when that is the accurate runtime. For a major JavaScript framework, use the framework name: `react`, `angular`, `vue`, or `nextjs`.

**Platform.** Use `platform` when the sample is not tied to one cloud. Otherwise use the provider name from the infrastructure naming standard.

**Description.** Describe the sample in broad terms, with underscores between words. `rest_api`, `queue_consumer`, and `static_frontend` are the expected grain. Do not encode a client or an environment in the name.

**Examples.**

- `dotnet-platform-sample-rest_api` is a .NET REST API with no cloud-specific requirement.
- `java-platform-sample-queue_consumer` is a Java application that reads example messages from a queue.
- `angular-platform-sample-static_frontend` is an Angular sample that produces static files.
- `python-platform-sample-wsgi_rest_api` is a Python WSGI REST API. An asynchronous sample uses a description such as `asgi_rest_api`.

## Where implementation details live

The sample repository holds its build and its README. This page does not set the application framework beyond the name.

[Repository names](../naming-schemes.md)
