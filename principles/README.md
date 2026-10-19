# Principles

A principle is a durable claim about why this team engineers the platform as it does. It should survive a change of tool, vendor, or repository layout.

## What belongs here

A page that states a reason the team is willing to keep when the implementation changes. It names the problem, the position, what engineers are expected to do because of it, and where the mechanics live.

## What does not belong here

- A team default that is true only for the current tool. That is a [standard](../standards/README.md).
- A method for applying a principle to delivery or operations. That is a [practice](../practices/README.md).
- Install steps, command sequences, and component configuration. Those belong in the repository that owns the component.
- A proposal the team has not adopted. That belongs in [new ideas](../new-ideas/README.md).
- A page that only reserves a future title.

## How a principle page is organized

Each principle page uses four headings:

1. **The problem** describes the situation the principle addresses.
2. **The position** states the principle and the reasoning behind it.
3. **What the team expects** lists what engineers are expected to do because of it.
4. **Where implementation details live** points to the owning section or component, rather than copying its procedures.

Each page states its strength at the top. A statement inside a page that is a team default or a context-dependent choice, rather than a principle, is labeled where it appears. [How to read these docs](../how-to-read-these-docs.md) explains the labels.

## Pages

How the team approaches platform work:

- [Platform work serves delivery outcomes](outcomes-over-activity.md)
- [Trust is earned through reliability and evidence](trust-and-evidence.md)
- [Leave people and systems more capable](stewardship-and-enablement.md)
- [Build delivery, security, and observability in from the start](built-in-from-the-beginning.md)
- [Speed is safe when controls keep pace](safe-speed-and-accountability.md)
- [Rigor increases as others depend on a capability](rigor-follows-dependency.md)

How repositories are shaped:

- [Single-purpose repository](single-purpose-repository-principle.md)
- [Self-contained repository delivery](self-contained-repository-deployment-principle.md)

[Repository topology](../strategies/poly-git-repo-strategy.md) describes the trade-offs between multiple repositories and a single repository. It is a context-dependent choice, not a principle.

[Knowledge base home](../README.md)
