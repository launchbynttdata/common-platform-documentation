# Build delivery, security, and observability in from the start

**Strength:** Principle

## The problem

A system can be made to run before it can be changed safely, protected deliberately, or understood in operation. Delivery automation, security controls, and operational visibility are then added after people are already depending on it. Each of those additions is harder at that point. The delivery path has to be wrapped around behavior that was never designed to be released repeatedly. Security controls have to be fitted onto decisions that were made without them. Operators have to infer what the system is doing from incomplete signals.

The same gap appears when infrastructure and application code are treated as separate kinds of work. Infrastructure that is created once, and then changed by hand, cannot be reviewed, tested, or restored the way software can. Application code that emits no useful operational signal cannot be diagnosed from the infrastructure around it. Each side can look complete while the running system still cannot be changed or explained with confidence.

## The position

The Launch by NTT DATA Platform Engineering team works with the rest of the delivery team to establish delivery, security, and observability in the first version that other people will rely on. Each of the three can be thin at the start. A thin delivery path, security decisions made for the actual risk, and enough telemetry to answer the first operational questions are part of that version. A promise to add them later is not.

Infrastructure is delivered like software. A change to infrastructure is reviewed, tested, versioned, and applied through a controlled path, because a faulty infrastructure change can affect security, availability, cost, and every application that depends on it. Creating the resource is the beginning of that path, not the end of it. Later upgrades, replacement, and retirement belong to the same path.

Software is operated with the same attention to runtime behavior that the team gives to infrastructure. Application code is part of the running system, so it needs a delivery path and enough telemetry for the delivery team to see what it is doing. Metrics and logs from the infrastructure can show that a host, a network, or a data service is unhealthy. They cannot, by themselves, explain a decision the application made.

Application engineers normally own the application code and its instrumentation. Platform engineers advocate for the operational signals the whole system needs, provide or enable the shared mechanisms that collect and correlate those signals, and work with application engineers to make gaps visible. This is shared responsibility without transferring application ownership to the platform team.

Security runs through those same decisions from the first design conversation. Platform engineers raise the questions that affect the platform and the delivery path, help the delivery team identify trust boundaries and suitable controls, and implement the controls owned by the platform. Application engineers and other specialists retain responsibility for the security decisions and controls in their own areas. Automated checks supply repeatable evidence of known classes of mistake. They do not replace the judgment of the people designing the system, and they do not move responsibility for that judgment onto a pipeline. [Speed is safe when controls keep pace](safe-speed-and-accountability.md) describes how those checks and that judgment fit together.

## What the team expects

- Include a delivery path, the security decisions the risk calls for, and a way to observe behavior in the first version that other people will use.
- Review, test, version, and release infrastructure changes with the same discipline applied to application changes.
- Advocate for application instrumentation that explains application behavior, and enable application engineers to connect those signals to the infrastructure the application runs on.
- Raise security questions while the design is still open, implement the controls owned by the platform, and help the delivery team record decisions where the people who will change the system can find them.
- Treat a missing delivery path, an unexamined trust boundary, or an inability to tell what the system is doing as a gap in the current version, rather than as work reserved for a later phase.

## Where implementation details live

How the team applies this to delivery, infrastructure, observability, and security belongs in [practices](../practices/README.md). The current tools, checks, and telemetry configuration belong in the repositories that own them.

[Principles](README.md)
