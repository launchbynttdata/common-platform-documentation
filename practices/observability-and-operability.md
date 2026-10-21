# Observe the system in order to operate it

**Strength:** Team default

## The problem

A team that cannot see how a system behaves becomes cautious in the wrong places. It delays changes because it cannot tell whether they worked, or it ships changes and discovers the effect from user reports. Collecting more logs, metrics, and dashboards does not fix that if the team still cannot answer a specific question.

## The position

Observability starts from the questions operators need to answer and the failures they need to notice.

- How is the system behaving now?
- What changed?
- Where is the failure?
- Did a deployment improve or degrade behavior?
- What will show whether a proposed change did what was intended?

The team collects the logs, metrics, and, when a request crosses several components, traces that those questions require. A dashboard is useful when it helps answer one of them. A large number of dashboards is not a goal.

Infrastructure signals and application signals answer different questions. Infrastructure telemetry can show that compute, network, or data services are unhealthy. It cannot explain a decision made inside the application. Application engineers normally own that instrumentation. Platform engineers advocate for the signals the whole system needs, provide or enable the shared collection path, and help connect application signals to the infrastructure they run on. [Build delivery, security, and observability in from the start](../principles/built-in-from-the-beginning.md) states that split of responsibility.

Security-relevant events belong in this evidence. Telemetry should make unexpected access and failure investigable without placing secrets or sensitive client data into the logs. Who can read logs, metrics, and traces is itself an access decision.

A local health check should report the health of that component. A check that calls through to every dependency turns one failure into many alarms and hides the source. End-to-end availability is watched from outside the component, not by every component probing every other one.

After a failure, a near miss, or a repeated delivery problem, the team can hold a learning review. The review asks what would have made the problem visible sooner and what default, check, or document should change. It is not a search for someone to blame. Blame gives people a reason to conceal an incident, and a concealed incident removes the evidence the next review needs.

## What the team expects

- Name the operational questions before adding a telemetry source or a dashboard.
- Provide a path that collects infrastructure and application signals and lets an operator correlate them.
- Keep secrets and sensitive client data out of telemetry.
- Use local health checks for a component's own health. Watch end-to-end availability separately.
- Compare behavior before and after a deployment when the change can affect a shared environment.
- Record a learning review when an investigation exposed a gap the team should close.

## Where implementation details live

Collectors, dashboards, and alert routing belong to the repositories and environments that operate them. The [platform map](../platform/README.md) will name those owners. [Trust is earned through reliability and evidence](../principles/trust-and-evidence.md) is the principle this practice serves.

[Practices](README.md)
