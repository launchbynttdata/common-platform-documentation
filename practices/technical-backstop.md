# Help when ownership is unclear

**Strength:** Team default

## The problem

Failures do not always arrive with a clear owner. A report that "the platform is broken" may come from application code, configuration, a pipeline, identity, a network path, or an outside service. If platform engineers defend the platform before looking at the evidence, the delivery team loses time. If they take over every failure, they become spare capacity for other disciplines and the people who own the fix stop learning it.

## The position

A platform engineer acts as a technical backstop when a failure crosses a boundary or the owner is not yet known. The backstop stays with the problem long enough to make the evidence usable, help the owning team move, and confirm the outcome. The backstop does not permanently take ownership, does not bypass review or deployment rules to make a symptom disappear, and does not become unassigned labor for another team's backlog.

The work is evidence-led. Establish what is known, write down the investigation, and test the next explanation against that evidence. Start from the symptom the reporter can see. Do not start by assigning blame or by clearing the platform.

When the evidence points to another team, hand that team the logs, the configuration, and the steps that reproduce the problem, and stay available through the resolution. When the evidence may indicate a security incident, stop ordinary troubleshooting and follow the engagement's response path, as [Share responsibility for security](security-as-shared-responsibility.md) describes.

An engineer who is stuck asks for help rather than continuing alone. **Team default:** the engineer allows about an hour of being stuck, then asks. That hour is a limit on the engineer's own unaided effort. It is not a promise that help will arrive within an hour, and it is not a support response time. The exact moment to ask varies with the problem. The norm is that the engineer reaches out when that hour has not produced a way forward. **Asking for help is expected and never punished.** Time on the engagement is not spent on a stall the engineer has kept private. The wider platform engineering practice can advise. It cannot join the engagement or own the delivery. The engineer on the engagement remains responsible for applying that advice.

A learning review can follow a failure, a near miss, or a repeated frustration. [Observe the system in order to operate it](observability-and-operability.md) describes what that review is for.

## What the team expects

- Engage when a failure is reported, including a report that may turn out not to be a platform defect.
- Record what is known and what was tried.
- Hand the owning team a reproducible account and the evidence the platform side holds.
- Decline work that would permanently transfer another team's ownership to the platform team, and help that team unblock instead.
- After about an hour of being stuck, ask for help and say what was already tried. This is the engineer's cue to reach out. It does not commit the people they ask to respond within an hour.
- Correct an earlier conclusion when the evidence changes.

## Where implementation details live

Engagement escalation paths and incident procedures live with the engagement. [Trust is earned through reliability and evidence](../principles/trust-and-evidence.md) is the principle this practice serves.

[Practices](README.md)
