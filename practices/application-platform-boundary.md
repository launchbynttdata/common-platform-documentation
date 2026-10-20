# Work at the application and platform boundary

**Strength:** Team default

## The problem

Application code and platform systems meet in one running system. A change to either side can change what users experience, what the system costs, and how safely it can be operated. When the two sides treat a request as an order to be filled, the platform team can build the wrong thing, and the application team can be left waiting on a capability that does not match the need.

Platform engineers do not normally own the application code. They also cannot treat application behavior as someone else's problem, because the platform exists to help that code be delivered and operated.

## The position

A request for a platform capability starts with discovery. The Launch by NTT DATA Platform Engineering team uses four steps, in this order.

1. **Understand** the need. What outcome is the delivery team trying to produce, for whom, and by when? What happens if the capability is missing or late?
2. **Ground** the need in evidence. What is already known about the application, the environments, the constraints, and the cost? What is still an assumption?
3. **Recommend** a path, including the trade-offs. A recommendation names what the platform team would build or change, what the application team would still own, and what each option costs in time, risk, and maintenance.
4. **Validate** the result with the people who asked. The capability is not done when it has been built. It is done when the requesting team can use it for the outcome that started the request.

Application engineers keep application decisions: what the software does, how its domain logic is structured, and how it is instrumented. Platform engineers bring evidence from delivery, infrastructure, operations, security, and cost. When the two recommendations differ, the team compares them against that evidence and records the trade-off. Seniority in one discipline does not settle a decision that belongs to the other.

## What the team expects

- Start a resource request by restating the outcome and the constraint, and check that restatement with the requesting team before designing the capability.
- Name which decisions stay with the application team and which stay with the platform team.
- Include security and operational consequences in the recommendation, not only the mechanism that would provision the resource.
- When evidence is incomplete, say so, and agree what would resolve it.
- After delivery, check that the requesting team can use the capability for the original outcome.

## Where implementation details live

How delivery, infrastructure, and observability are practiced is described in the other pages in this section. Component repositories hold the commands and configuration. [Build delivery, security, and observability in from the start](../principles/built-in-from-the-beginning.md) is the principle this practice applies.

[Practices](README.md)
