# Practices

A practice explains how the principles change engineering work: delivery, infrastructure, operations, and the judgment calls that cut across them.

Security and the use of AI-assisted engineering cut across delivery and operations. Addressing either on its own page, when such a page exists, does not remove the need to address it in the relevant practice.

## What belongs here

A page that shows how a principle is applied on platform work. It states the expectation, the trade-off when the situation does not fit, and which component repository owns the mechanics.

## What does not belong here

- The durable reason itself. That is a [principle](../principles/README.md).
- A current tool contract or compatibility rule. That is a [standard](../standards/README.md).
- Component runbooks, install guides, and command transcripts.
- A hypothesis the team has not adopted. That belongs in [new ideas](../new-ideas/README.md).
- A page that only reserves a future title.

## How a practice page is organized

Each practice page uses four headings:

1. **The problem** describes the situation the practice addresses.
2. **The position** states how the team applies the related principle, and the reasoning behind that application.
3. **What the team expects** lists the decisions an engineer is expected to make.
4. **Where implementation details live** points to the owning repository or standard, rather than copying commands.

Each page states its strength at the top. [How to read these docs](../how-to-read-these-docs.md) explains the labels. Security and AI-assisted engineering also appear inside the delivery and infrastructure pages, because a separate page does not remove the need to apply them there.

## Pages

Delivery and the application boundary:

- [Work at the application and platform boundary](application-platform-boundary.md)
- [Deliver software through an evidence chain](trustworthy-software-delivery.md)
- [Maintain infrastructure as software](infrastructure-as-software.md)

Operation and professional judgment:

- [Observe the system in order to operate it](observability-and-operability.md)
- [Share responsibility for security](security-as-shared-responsibility.md)
- [Use AI without giving up accountability](ai-assisted-engineering.md)
- [Help when ownership is unclear](technical-backstop.md)
- [Establish a minimum platform path at the start](sprint-zero-platform-readiness.md)

Two delivery notes stay at their existing addresses and point here:

- [Immutable application deployment](../platform/continuous-deployment/immutable-application-deployment/README.md)
- [Evolutionary database changes](../platform/continuous-deployment/evolutionary-database-deployment/README.md)

[Knowledge base home](../README.md)
