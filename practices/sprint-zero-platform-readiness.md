# Establish a minimum platform path at the start

**Strength:** Team default

## The problem

Application teams need a way to build, deploy, and see a change before they can demonstrate meaningful progress. If that path is postponed until a large design is finished, the first real change discovers missing access, missing environments, and missing checks when the cost of waiting is already high. If the first path is only a demonstration that will be thrown away, the team pays again to build the real one.

## The position

Sprint 0 is the opening period of an engagement, before substantial business functionality is in place. During Sprint 0 the platform team builds the delivery path the application team will use for the rest of the engagement. That path is the first increment of the system the team will keep. A demonstration built to be discarded does not complete Sprint 0.

Sprint 0 is complete when every item below is true. An item that is not yet true is open work. Name the gap, the person responsible for closing it, and what the application team cannot do until it is closed.

- **Access.** The people who must change the system can reach the accounts, repositories, and pipelines they need within days. An open-ended wait is a risk to name, not a normal state to absorb.
- **Environments.** The first environment is created from reviewed infrastructure source, so it can be explained and repeated.
- **Build once.** A change produces an identified artifact that is promoted, not rebuilt, for the next environment. [Deliver software through an evidence chain](trustworthy-software-delivery.md) describes that chain.
- **A thin slice.** A small deployable application or change exercises the path before much business logic depends on it.
- **One completed change.** At least one change goes from source through review, checks, artifact, and deployment, so the path is known to work.
- **Operation and recovery.** The team can see whether that change is running and can return to the previous version.
- **Instructions in the repository.** A new engineer can find how to build, test, and deploy from the repository, as [Self-contained repository delivery](../principles/self-contained-repository-deployment-principle.md) requires.
- **Open work.** For any item above that is not yet true, record the gap, the person closing it, and what the application team cannot do until it is closed.

Security and observability are part of this minimum, in the thin form described in [Build delivery, security, and observability in from the start](../principles/built-in-from-the-beginning.md). They are not deferred until a later phase.

## What the team expects

- At the start of an engagement, write down which of these minimums are met and which are not.
- Name an owner and the delivery impact for each unmet item.
- Use the first thin slice to learn where the path actually breaks, while the cost of changing it is still low.
- Keep the first path as the start of the real delivery system. Do not schedule a second, unrelated path for the "real" work.
- Add the next environment by extending the same path, rather than inventing a new process for it.

## Where implementation details live

Account access, pipeline products, and environment layout differ by engagement and live in that engagement's repositories. This page does not set those mechanics. [Platform work serves delivery outcomes](../principles/outcomes-over-activity.md) is the reason the first path exists.

[Practices](README.md)
