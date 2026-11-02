# Platform map

This section maps the current platform at capability level. An entry says what a major component is for, how it relates to the components around it, and which repository holds the implementation documentation.

## What belongs here

A short description of a current platform capability and a pointer to the component that owns it. The map answers where to go. It does not copy that component's configuration, commands, or operating procedure.

## What does not belong here

- Step-by-step environment setup and tool installation.
- Service walkthroughs, screenshots, and example input files for a deployment procedure.
- Pipeline mechanics.
- A team default that is not itself a description of a component. That is a [standard](../standards/README.md).
- A delivery method that is not a map of components. That is a [practice](../practices/README.md).
- A page that only reserves a future title.

## Questions an active map page answers

1. What is this capability responsible for?
2. Where does that responsibility stop?
3. Which repository or page holds the current behavior?

The third answer is the owning repository, or the practice page when the capability has no repository of its own. It is not a procedure copied into this knowledge base.

## Pages

- [Shared automation for delivery and for pipelines](reusable-workflows.md)
- [The skeleton shares configuration across Terraform module repositories](terraform-skeleton.md)
- [The template is how a new Terraform module repository starts](terraform-module-template.md)
- [The team publishes Terraform modules that others can reuse](reusable-modules.md)
- [The registry is where Terraform downloads a public module](launch-public-service/terraform-module-registry/README.md)
- [A module repository contains a README and instructions for coding agents](repository-instructions.md)
- [Readiness is the delivery path at the start of an engagement](readiness.md)

Two delivery notes stay beside the map. They are not map entries. The practices they belong to are indexed under [practices](../practices/README.md).

- [Immutable application deployment](continuous-deployment/immutable-application-deployment/README.md)
- [Evolutionary database changes](continuous-deployment/evolutionary-database-deployment/README.md)

The Kubernetes continuous-deployment note that used to be listed here is archived.

Historical procedures that used to sit under `platform/` are listed in the [archive disposition](../archive/content-disposition.md). They are not linked from this map. Empty title reservations were removed rather than kept as procedures. Read the [archive warning](../archive/README.md) before using anything stored there.

[Knowledge base home](../README.md)
