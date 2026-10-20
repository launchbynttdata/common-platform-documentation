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
5. **Operate.** After the change is applied, confirm that the running system matches the reviewed change and that the people who depend on it can use the result. A successful apply command only starts that confirmation. The rest is a comparison between the intended change and what operators and consumers can observe. Limit who can modify the running system to the delivery path and the people accountable for it. If anyone with a broad cloud login can change production from the console, the reviewed source stops being a reliable description of what is running. Keep a tested way to restore the previous version, or otherwise recover service, when the applied change is wrong.
6. **Evolve.** Upgrade, replace, and retire the capability on purpose. A resource that can be created but not changed safely is unfinished.

A caller who takes a module's defaults receives the protections that capability requires. For a data store, that includes encryption and network access limited to the callers who need it. For an identity, that includes only the permissions the workload needs. The caller should not have to discover and turn those protections on as extra options. When the protections are optional, the configuration that omits them is the one most callers will run, and every team that uses the module inherits that weaker configuration. A module is ready for other teams when the protected configuration is the one they get by following the module's documented usage. Shared modules also publish a versioned contract and name an owner for the six stages above. [Rigor increases as others depend on a capability](../principles/rigor-follows-dependency.md) is the principle behind that expectation.

## What the team expects

- Describe infrastructure in reviewed source, and review the change before it is applied.
- Read a plan as a statement of intent. Confirm the result after apply when the change can affect a shared or production environment.
- Publish shared modules so that documented usage already includes encryption, limited network access, and least-privilege identity where those apply. When a caller must weaken one of those protections, record who accepted that exception and why.
- Version a shared module, name its owner, and give consumers a way to stay on a previous version.
- Include upgrade, replacement, and retirement in the design of a capability that other teams will rely on.

## Where implementation details live

Terraform module types, testing, and version floors are standards and will be published in [standards](../standards/README.md). Each module repository holds its own contract, examples, and tests. [Build delivery, security, and observability in from the start](../principles/built-in-from-the-beginning.md) states why infrastructure is delivered like software.

[Practices](README.md)
