# Self-contained repository delivery

**Strength:** Principle

## The problem

When the path to build, test, release, deploy, and observe a component is spread across undocumented scripts, personal knowledge, and settings held outside the repository, only a few people can change that component safely. New engineers find it difficult to contribute, recovery depends on who is available, and differences between environments are hard to explain.

## The position

A repository should make its delivery path discoverable. A reader should be able to find how the component is built, how it is tested and scanned, how a version is released, how it is deployed, and how its behavior is observed. Most of that path should be defined in the repository as code and configuration that are reviewed and versioned with the component.

Discoverable does not mean that the repository contains everything. Some information should never be stored with the code, and some capabilities are better maintained once and shared by many repositories. In those cases, the repository points to what it needs instead of holding it.

- **Configuration and secrets stay outside the source.** The repository does not contain secrets or environment-specific values. It describes the configuration it needs and where that configuration is supplied. This follows the configuration guidance in [The Twelve-Factor App](https://12factor.net/config).
- **Shared services are explicit dependencies.** A component can depend on a capability that exists before it and serves several consumers, such as a Kubernetes cluster, a network, a cache, or a queue. The repository names that dependency and the contract it relies on, and it does not recreate the service.
- **Shared delivery tooling is referenced, not copied.** A repository can use common workflows, templates, or modules maintained elsewhere. It pins the version it uses, so a reader can tell exactly which definition applies.

## What the team expects

- The repository documentation explains how to build, test, release, and deploy the component, or links directly to the definitions that do so.
- Automated checks, such as linting, scanning, and tests, are defined so that they run the same way for every change.
- The telemetry the component produces, and where to find it, are described.
- Required configuration is documented by name and purpose, and its values are supplied by the environment.
- Dependencies on shared services and shared tooling are named and versioned.

## Where implementation details live

Each component repository owns its delivery definitions. Shared workflows and templates are owned by the repositories that publish them. The [platform map](../platform/README.md) is where the team identifies those repositories.

[Principles](README.md)
