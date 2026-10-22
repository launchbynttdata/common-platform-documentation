# Maintain infrastructure as software

**Strength:** Team default

## The problem

Infrastructure that is created once and then changed by hand drifts. The next engineer cannot tell what was intended, what is running, or how to restore it. A diagram or a one-time script records a moment. It does not give the infrastructure a lifecycle. Because infrastructure failures affect security, availability, cost, and every application that depends on it, that gap is shared by the whole delivery team.

## The position

The team maintains infrastructure as software. A change passes through six stages. Skipping one leaves a hole that a later stage cannot honestly fill.

1. **Contract.** State what the capability provides, what a caller must supply, and what it promises not to do. Include the security behavior a caller can rely on.
2. **Change.** Propose the change in reviewable source. A change produced with AI assistance is reviewed in the same way as any other change.
3. **Prove.** Gather evidence before the change is accepted. A plan shows what the tool intends to do. It is evidence, not certainty: it can be wrong, incomplete, or overtaken by a change outside the source. Useful proof also includes static checks, the result after the change is applied in a safe environment, and the behavior a consumer can observe.
4. **Apply.** Apply a reviewed, versioned change through a controlled path. Do not treat a console edit as the record of what the system should be.
5. **Operate.** After the change is applied, confirm that the running system matches the reviewed change and that the people who depend on it can use the result. A successful apply command only starts that confirmation. The rest is a comparison between the intended change and what operators and consumers can observe.
6. **Evolve.** Upgrade, replace, and retire the capability on purpose. A resource that can be created but not changed safely is unfinished.

Whoever consumes the platform receives the protections that capability requires, without having to turn them on. For a data store, that includes encryption and network access limited to the callers who need it. For an identity, that includes only the permissions the workload needs. When those protections are optional, the configuration that omits them is the one most consumers will run, and every team that uses the capability inherits that weaker configuration. A shared module is one way the platform delivers the protected configuration. That module is ready for other teams when the protected configuration is the one they get by following its documented usage. Shared modules also publish a versioned contract and name an owner for the six stages above. [Rigor increases as others depend on a capability](../principles/rigor-follows-dependency.md) is the principle behind that expectation.

## What the team expects

- Describe infrastructure in reviewed source, and review the change before it is applied.
- Read the tool's proposed change as a statement of intent. Confirm the result after the change is applied when it can affect a shared or production environment.
- Give a consumer of the platform encryption, limited network access, and least-privilege identity where those apply, without requiring them to opt in. When one of those protections must be weakened, record who accepted that exception and why.
- When a shared module delivers a platform capability, version that module, name its owner, and give consumers a way to stay on a previous version, preferably without them having to take any action.
- Include upgrade, replacement, and retirement in the design of a capability that other teams will rely on.

## Where implementation details live

Terraform module types, testing, and version floors are standards and will be published in [standards](../standards/README.md). Each module repository holds its own contract, examples, and tests. [Build delivery, security, and observability in from the start](../principles/built-in-from-the-beginning.md) states why infrastructure is delivered like software.

[Practices](README.md)
