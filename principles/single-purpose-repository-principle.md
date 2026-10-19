# Single-purpose repository

**Strength:** Principle. The team default for repository topology is labeled where it appears.

## The problem

A repository defines how a body of code is changed, reviewed, versioned, and released. When a repository holds unrelated components, a change to one can block, delay, or unexpectedly release another, and it becomes difficult to tell which version of each component is running. When a cohesive component is split across many very small repositories, one change requires coordinated updates in several places, and the relationships between those repositories become harder to follow than the code itself.

## The position

A repository should hold one lifecycle that can be understood on its own. A lifecycle here means the sequence by which the repository's contents are changed, tested, versioned, and released. A reader should be able to tell what the repository produces, how a change to it is tested and released, and what it depends on, without first studying other repositories in detail.

This is a test of cohesion, not of size. Cohesion means that the contents of a repository belong together because they change for the same reasons. Code that changes together, is tested together, and is released together belongs in the same repository. Code that has its own consumers, its own release timing, or its own owner is a candidate for a separate repository. A repository is not divided further only to make it smaller, because each additional repository adds a boundary that changes must cross.

When one repository depends on another, the dependency is an explicit contract, such as a versioned artifact, module, interface, or published output. Consumers rely on that contract rather than on the other repository's internal structure. This allows the owning repository to reorganize its internals freely, as long as the published contract continues to behave as described.

**Team default.** Most Launch work uses multiple repositories, each producing one versioned artifact or capability. That arrangement suits the team's current work, in which shared modules and services have independent consumers and release cycles. It is a default rather than a universal rule. [Repository topology](../strategies/poly-git-repo-strategy.md) describes the trade-offs.

## What the team expects

- Before creating a repository, state what it produces, who consumes it, and how it is released.
- Keep components that must change and be released together in the same repository.
- Make every dependency between repositories explicit and versioned. Do not rely on files or structures that another repository has not published as part of its contract.
- Produce artifacts that contain no environment-specific values. The same artifact can then be deployed to a development environment first and later, unchanged, to test and production environments, so what is tested is exactly what is released.
- Revisit a boundary when it repeatedly requires coordinated changes across repositories, or when unrelated work repeatedly delays a release.

## Where implementation details live

Repository naming, versioning, and Terraform module boundaries belong in [standards](../standards/README.md). Each repository documents its own build and release process.

[Principles](README.md)
