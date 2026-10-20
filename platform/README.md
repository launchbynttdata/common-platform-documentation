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

1. What problem does this address?
2. Why does the team take this position?
3. What does the team expect engineers to do?
4. Where do current implementation details live?

For a map page, the third answer is which capability to use and which component owns it. The fourth answer is that component's repository, not a procedure copied into this knowledge base.

## Pages

The capability map itself is not written yet. The links below are the substantive documents in this directory that are not historical procedures. They predate the map. A link locates the document. It does not mean the page already meets the questions above.

- [Terraform module registry](launch-public-service/terraform-module-registry/README.md). This page explains how to construct a registry source. It is not yet a capability description.
- [Immutable application deployment](continuous-deployment/immutable-application-deployment/README.md)
- [Evolutionary database changes](continuous-deployment/evolutionary-database-deployment/README.md)

These two pages are delivery notes. The practices they belong to are indexed under [practices](../practices/README.md). They are not map entries for platform components. The Kubernetes continuous-deployment note that used to be listed here is archived.

Historical procedures that used to sit under `platform/` are listed in the [archive disposition](../archive/content-disposition.md). They are not linked from this map. Empty title reservations were removed rather than kept as procedures. Read the [archive warning](../archive/README.md) before using anything stored there.

[Knowledge base home](../README.md)
