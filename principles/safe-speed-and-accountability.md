# Speed is safe when controls keep pace

**Strength:** Principle

## The problem

Engineers can produce changes faster than before, and AI-assisted tools increase that rate further. Faster production is valuable only when the team can still understand, verify, and steer what is being changed.

When review, testing, or deployment does not keep pace with the rate of new changes, changes accumulate and are released together in larger batches. A large batch is harder to review carefully. When it fails, it is harder to tell which part caused the failure. Defects then reach later stages, such as shared test environments or production, where they affect more people and cost more to find and correct.

## The position

The team pursues speed through control. Clear intent, small changes, early feedback, reviewable artifacts, and the ability to stop or roll back a change are what make faster delivery safe.

The team often describes this as going fast like IndyCar rather than fast like Wile E. Coyote. A racing team can drive at high speed because the car, the driver, and the crew have the instruments, brakes, and practiced procedures to steer and stop when they need to. Acceleration without those controls only reaches a failure sooner.

A related phrase the team uses is "slow is smooth, smooth is fast." Work done deliberately, in small and well-understood steps, tends to proceed without interruptions for rework, rollbacks, or investigation. Over the course of an engagement, that steady progress delivers more than work that moves quickly at first and then stops repeatedly to recover from avoidable mistakes.

Deterministic controls handle routine verification. A deterministic control gives the same result every time it is given the same input. Automated tests, static analysis, security scanning, policy checks, and repeatable deployment mechanisms work this way. They apply the same rule to every change, whether a person or a tool produced it. Because those controls catch the routine problems, reviewers can spend their attention on judgment, design, and risk.

People remain accountable for consequential actions. A model, a script, or an automated workflow can prepare or recommend a change, but responsibility for the result stays with the engineer who chose to apply it. That accountability does not depend on how the work was produced.

AI assistance helps engineers reach a supportable implementation sooner. The intended result is still deterministic, repeatable, and auditable automation. An AI model can give different answers to the same question. That variation is useful when an engineer is exploring options and reviewing the result. It is a poor fit for a step in an automated delivery path, which must behave the same way every time so its result can be trusted and audited. The team therefore uses AI to help write scripts, tests, and pipelines, and it does not place an AI decision in the automated delivery path when a conventional mechanism can perform the same work predictably.

## What the team expects

- Keep changes small enough to review and test effectively, including changes produced with AI assistance.
- Add a deterministic check when the same class of error is likely to recur, so that reviewers do not have to find it by inspection each time.
- When a manual approval stands in for a control that could be automated, treat it as a deliberate and temporary decision. Record why it exists, who owns it, and what would allow it to be replaced. Approvals that exist because a person must accept accountability, such as an agreed release decision, are part of the design and remain in place.
- Obtain explicit approval before an action that is administrative, irreversible, or affects other people, such as deleting resources, changing access, or merging without a required check.
- Improve the step that limits delivery. Producing changes faster than review, testing, or deployment can absorb them only lengthens the queue in front of that step. See [Platform work serves delivery outcomes](outcomes-over-activity.md).

## Where implementation details live

How the team uses AI-assisted engineering and arranges delivery controls belongs in [practices](../practices/README.md). The repositories that own each check document its configuration.

[Principles](README.md)
