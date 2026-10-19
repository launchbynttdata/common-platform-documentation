# Repository topology

**Strength:** Context-dependent choice. The team default is labeled below.

This page stays at its existing address because other documents link to it. The governing principle is the [single-purpose repository](../principles/single-purpose-repository-principle.md) principle.

## The problem

Every team decides how to divide its code among repositories. That decision affects how changes are reviewed, how versions are released, how dependencies are managed, and how much coordination a change requires. No single arrangement is best for every situation.

## The position

The choice of repository arrangement depends on the trade-offs that matter most for the work at hand.

**Multiple repositories** give each component its own history, version, permissions, and release timing. Consumers can adopt a new version when they are ready, and a failure in one component's pipeline does not block the others. The cost is coordination. A change that spans several components requires several reviews and releases, and the contracts between repositories must be kept current.

**One repository with several components** makes changes that span components easier to review and release together, and it gives one view of the whole system. The cost is that unrelated components share history, tooling, and often release timing. The repository then needs tooling that builds, tests, and releases only the components that changed, so that unrelated work does not slow every release.

**Team default.** The team commonly uses multiple repositories. For example, its shared Terraform modules, workflows, and services each have their own consumers and release cycles. Versioned contracts between those repositories let each consumer adopt a change when it is ready.

**Context-dependent choice.** A client's existing conventions, tooling, or organizational structure can make one repository, or a mix of both arrangements, the better choice for an engagement. In that case, the team keeps the underlying principle: each component has a lifecycle that can be understood on its own, and dependencies between components are explicit.

## What the team expects

- Choose a repository arrangement deliberately at the start of an engagement, and record the reasons for the choice.
- When working within a client's existing arrangement, apply the single-purpose repository principle inside it rather than reorganizing the client's repositories without agreement.
- Revisit the arrangement when coordination costs or shared release timing repeatedly slow delivery.

## Where implementation details live

Repository naming and versioning belong in [standards](../standards/README.md).
