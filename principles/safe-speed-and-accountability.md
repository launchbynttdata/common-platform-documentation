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

People remain accountable for consequential actions. A model, a script, or an automated workflow can prepare a change, run checks, or recommend a decision. The person who decides to apply the result remains responsible for it. **That responsibility does not depend on how the work was produced.**

A step that depends on judgment needs a person who can be held accountable for the decision. Reviewing whether a change does what was intended, interpreting test results, approving a merge, and deciding to release are all such steps. They sit on the path a change takes toward production, not only inside a deployment pipeline. An agent can prepare the material for those decisions. It cannot be the decider.

Some of those decisions depend on understanding what the alternatives mean at the time they are made. Examples are when to release a feature, whether to accept it in a user acceptance test, and whether a change does what was intended. The person given authority for such a decision is accountable for it because they are expected to understand that meaning. These decisions are part of the design. The change still reaches production through the same deterministic checks.

The team automates every remaining step that can be made deterministic. A step left to a person, when a repeatable check could do it, becomes a large source of delay and variation: it waits on who is available, and it is repeated differently from one change to the next. Automation removes that variation. It does not remove the judgment steps above.

AI assistance helps engineers reach a supportable implementation sooner. An AI model can give different answers to the same question. That variation is useful when an engineer is exploring options and reviewing the result. A delivery step has to behave the same way every time, so its result can be trusted and audited. The team uses AI to help write scripts, tests, and pipelines. It does not place an AI decision in a delivery step, whether or not a conventional mechanism already exists for that step. If the step can be made deterministic, the team automates it. If the step depends on judgment, a person remains the decider.

## What the team expects

- Keep changes small enough to review and test effectively, including changes produced with AI assistance.
- Automate every step that can be made deterministic. Add a check when the same class of error is likely to recur, so that reviewers do not have to find it by inspection each time.
- When a manual approval stands in for a control that could be automated, treat it as a deliberate and temporary decision. Record why it exists, who owns it, and what would allow it to be replaced. A decision that depends on understanding what the alternatives mean at the time, such as a release decision, stays with a person. It is part of the design.
- A person who has been granted authority in advance may take an administrative or irreversible action under that authority, and remains accountable for it. An agent or an automated workflow does not hold that authority. Deleting resources, changing access, or merging without a required check still requires a person's decision.
- Improve the step that limits delivery. Producing changes faster than review, testing, or deployment can absorb them only lengthens the queue in front of that step. See [Platform work serves delivery outcomes](outcomes-over-activity.md).

## Where implementation details live

How the team uses AI-assisted engineering and arranges delivery controls belongs in [practices](../practices/README.md). The repositories that own each check document its configuration.

[Principles](README.md)
