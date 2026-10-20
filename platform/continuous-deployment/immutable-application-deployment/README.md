# Immutable application deployment

**Strength:** Team default

This page stays at its existing address because other documents link to it. The delivery practice is [Deliver software through an evidence chain](../../../practices/trustworthy-software-delivery.md).

## The problem

Editing a running application in place makes the running version differ from the artifact that was built and reviewed. A partial update can fail halfway, and the team then has no single previous version to return to.

## The position

Deploy a new version of the same immutable artifact into a new execution context, and move users to it when it is healthy. Keep the previous version available until the new one is accepted, so recovery is a routing change rather than an attempt to undo an in-place edit.

The artifact is built once and does not contain environment-specific values. Configuration is supplied at deployment and can be tied to the artifact version it belongs with.

This is the team default for application packages. A database usually cannot be replaced as a whole in the same way. Schema changes follow [Evolutionary database changes](../evolutionary-database-deployment/README.md).

How users are moved, for example all at once or a small share first, depends on the risk and the tooling. That choice is context-dependent. The durable requirement is that the previous version remains available until the new one is accepted.

## What the team expects

- Replace a running application version. Do not edit the running copy in place.
- Promote the artifact that was built and checked. Do not rebuild it for the new environment.
- Keep configuration and secrets out of the artifact.
- Check the health of the new version itself. Do not make that check call through every dependency. Watch end-to-end availability separately, as [Observe the system in order to operate it](../../../practices/observability-and-operability.md) describes.
- Leave the previous version in place until the new version is accepted.

## Where implementation details live

Deployment mechanics live in the repository that owns the application pipeline. This page does not require a particular packaging tool.

[Practices](../../../practices/README.md)
