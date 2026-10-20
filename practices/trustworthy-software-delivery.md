# Deliver software through an evidence chain

**Strength:** Team default

## The problem

A team can have a pipeline that runs and still not know what was deployed, whether it was reviewed, or how to return to the previous version. Activity in the pipeline is not the same as a delivery the team can trust. Deployment and delivery are also different. Deployment puts a version into an environment. Delivery makes a capability available to the people who need it. A deployment that succeeds can still fail to deliver the intended capability.

## The position

Trustworthy delivery is a chain that a reviewer can follow from planned work to a running change.

1. The work is identified, so a change can be connected to the outcome it serves.
2. The source change is reviewed.
3. Automated checks produce evidence: tests, static analysis, and security scans appropriate to the risk. These checks are a safety net. A green check shows that the named tests passed. It does not prove the change is correct or complete.
4. The build produces an immutable artifact. The artifact is built once, given an identity, and promoted into later environments. It is not rebuilt for each environment, and it does not contain environment-specific values.
5. A controlled deployment places that same artifact into an environment. Replacing a running version is preferred to editing it in place, so the previous artifact remains available if the new one must be withdrawn.
6. The team can see whether the deployment improved or degraded behavior, and can recover.

The first version of this chain should be the smallest complete path: enough to build, check, identify, deploy, observe, and recover one thin change. Small scope is not permission to skip review, identity, or recovery. [Build delivery, security, and observability in from the start](../principles/built-in-from-the-beginning.md) states that reason.

Security evidence belongs in the chain early enough to change the work, not only as a final accept-or-reject. Changes produced with AI assistance travel the same chain as any other change. [Use AI without giving up accountability](ai-assisted-engineering.md) describes that practice.

A database usually cannot be replaced as a whole artifact the way an application package can. Schema changes need a compatible, versioned migration path so the application and the database can move without destroying data. [Evolutionary database changes](../platform/continuous-deployment/evolutionary-database-deployment/README.md) describes that path. [Immutable application deployment](../platform/continuous-deployment/immutable-application-deployment/README.md) describes replacing an application version rather than editing it in place.

## What the team expects

- Connect a change to the planned work it serves, the review, the checks that ran, the artifact identity, and the deployment that used it.
- Build an artifact once and promote that artifact. Do not rebuild it per environment.
- Keep environment-specific values and secrets out of the artifact. Supply them at deployment.
- Treat a green pipeline as evidence about the checks that ran, and say which risks those checks do not cover.
- Make failure visible and keep a way back to the previous artifact.
- Prefer replacing a running application version with a new one. Do not edit the running copy in place.

## Where implementation details live

Pipeline definitions, promotion rules, and environment configuration live in the repositories that own them. The [platform map](../platform/README.md) names those repositories as the map is written. [Speed is safe when controls keep pace](../principles/safe-speed-and-accountability.md) is the principle behind the checks and the human decisions in this chain.

[Practices](README.md)
