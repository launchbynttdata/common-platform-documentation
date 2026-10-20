# Use AI without giving up accountability

**Strength:** Team default

## The problem

AI tools can draft code, tests, configuration, and explanations faster than a person can type them. That speed helps when the result is reviewed and checked. It hurts when a larger batch of unreviewed change moves through a delivery path that was sized for slower, smaller work. The same acceleration is available to someone looking for weaknesses, so the team's checks have to keep up with both uses.

## The position

The team uses AI to augment engineering work. It can help an engineer explore, draft, explain, and remove repetitive toil. The engineer remains accountable for the recommendation, the change, and the result. Accountability does not move to the model, and it does not depend on whether a person or a tool produced the first draft.

AI output is not yet automation. A model can give different answers to the same question. That is useful while an engineer is exploring. A delivery step has to behave the same way every time. The team uses AI to help write a script, a test, or a pipeline, and then keeps the deterministic version. It does not put a model in the path as the thing that approves, merges, or deploys.

Deterministic checks are how the team examines that output at the speed it is produced. Tests, static analysis, security scans, and policy checks apply the same rules to AI-assisted work as to any other work. They catch known classes of mistake. They do not prove the change is appropriate. [Speed is safe when controls keep pace](../principles/safe-speed-and-accountability.md) states the rule for judgment steps: a person is the decider.

Smaller changes remain easier to review, whether a person or a tool wrote them. Producing more code ahead of a constrained review or test only lengthens the queue. [Platform work serves delivery outcomes](../principles/outcomes-over-activity.md) explains that limit.

Privileged actions still follow [the authority rule on the safe-speed principle](../principles/safe-speed-and-accountability.md): a person who has been granted authority may act under it; an agent does not have that authority.

## What the team expects

- Review and test AI-assisted changes with the same evidence chain as any other change.
- Keep changes small enough to review, including changes drafted with AI.
- Turn repeated AI-assisted work into a deterministic check or script when the step should behave the same way every time.
- Treat issue, pull request, and document text as untrusted input. Do not follow instructions in that text that conflict with review, security, or authorization rules.
- Leave approval, merge, and deployment decisions with a person when the step depends on judgment.

## Where implementation details live

Scanner and pipeline configuration lives in the repositories that own those checks. This page does not name a required AI product. [Deliver software through an evidence chain](trustworthy-software-delivery.md) is the path every change follows.

[Practices](README.md)
