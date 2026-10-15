# Trust is earned through reliability and evidence

**Strength:** Principle

## The problem

Delivery teams depend on the platform team for systems they cannot fully inspect themselves, and for answers they cannot always verify on their own. When those systems or answers prove unreliable, teams protect themselves. They add their own checks, build their own version of a shared capability, or wait for confirmation before acting. Each of those responses is reasonable from the delivery team's point of view, and each one slows delivery.

## The position

An important measure of a platform team is how much the rest of the delivery team is willing to rely on it. A delivery team that trusts the platform uses shared capabilities directly, without building its own checks and workarounds, and spends that time on its own work instead. The team earns that trust in four ways.

- **Reliability.** The team does what it says it will do, and the capabilities it provides behave as described.
- **Evidence.** Claims about a system are supported by something others can check, such as a test result, a log, a plan, a version, or a reproducible observation. When the evidence is incomplete, the team says so and works to improve.
- **Approachability.** People can bring a problem to the platform team early, including a problem that may turn out to be in the platform, and they can expect a constructive response.
- **Follow-through.** The team stays engaged until an issue is resolved or clearly handed to the people who own it, and it records what it learned.

These qualities support one another. Evidence lets others confirm the team's reliability for themselves. When people are comfortable raising a concern early, problems are found while they are still small and easier to correct. When the team follows a problem through to its resolution and records the lesson, the same problem is less likely to happen again.

## What the team expects

- State the basis for a claim. Distinguish what has been confirmed from what is inferred or expected, and update the statement when new evidence changes it.
- Make commitments the team can keep. When capacity or risk makes a request unrealistic, explain the trade-off and agree on an achievable commitment.
- When someone reports a problem, begin by establishing what is known, and investigate the evidence together with the reporting team. Stay involved even if the cause turns out to be outside the platform.
- When the cause belongs to another team, help that team reach a resolution with the information the platform team holds, such as logs, configuration, and steps to reproduce the problem.
- **Treat being wrong as an ordinary part of investigation.** Correct an earlier conclusion promptly and plainly when the evidence requires it.



## Where implementation details live

What counts as sufficient evidence for a given kind of claim belongs in [standards](../standards/README.md). How the team investigates failures and learns from them belongs in [practices](../practices/README.md).

[Principles](README.md)