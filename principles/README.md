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

## Questions an active principle page answers

1. What problem does this address?
2. Why does the team take this position?
3. What does the team expect engineers to do?
4. Where do current implementation details live?

The answer to the last question is a pointer to the owning component, not a copy of its runbook.

## Pages

These are the substantive principle documents that exist today. They predate this index and have not been rewritten to the questions above. A link means the document is in the repository. It does not mean the wording is the current editorial form.

- [Single-purpose repository](single-purpose-repository-principle.md)
- [Self-contained repository deployment](self-contained-repository-deployment-principle.md)

No other principle pages exist.

[Knowledge base home](../README.md)
