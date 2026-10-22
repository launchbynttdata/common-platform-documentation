# Share responsibility for security

**Strength:** Team default

## The problem

Security fails when each discipline assumes another group will catch the issue later. A platform team can build convenient capabilities that are safe only after every caller adds its own protections. An application team can treat identity, data, and recovery as platform concerns. A pipeline can be treated as proof that a system is secure because a scan ran. None of those habits puts the decision where the risk is created.

## The position

Security is part of design, implementation, delivery, and operation for every discipline. It is not a phase that starts after the design is finished, and it is not a result a pipeline can certify on its own.

Platform engineers own the security consequences of the platform capabilities they build: identity and access for those capabilities, network boundaries, secret handling, encryption, auditability, and recovery. They raise those questions while the design is still open, and they make the secure path the easiest one. [Maintain infrastructure as software](infrastructure-as-software.md) includes that expectation in the infrastructure lifecycle.

Application engineers own the security consequences of application behavior and data handling. Other specialists own the decisions in their scope. Platform engineers help the delivery team see trust boundaries and choose controls. They do not take ownership of application code by doing so.

Automated checks are valuable because they apply the same rule every time and catch known classes of mistake. A passing scan is evidence about those checks. It does not prove the system is secure, and it does not move accountability to the platform team or to the tool. People remain accountable for the judgment the checks cannot make. [Speed is safe when controls keep pace](../principles/safe-speed-and-accountability.md) describes that split.

When evidence may indicate a security incident, ordinary troubleshooting stops. The team follows the engagement's incident-response path, involves the people assigned to it, and preserves evidence.

## What the team expects

- Ask, while the design is open, who can reach the system, what data it handles, what a failure would expose, and how it would be recovered.
- Implement the controls the platform owns, and make the secure setting the default.
- Put security checks on the delivery path early enough that a finding can change the work.
- State what a passing check covers, and what it does not.
- Hand a suspected security incident to the engagement's response path instead of continuing ad hoc investigation.

## Where implementation details live

Control configuration, scanners, and policy rules live in the repositories that own them. Engagement incident procedures live with that engagement. [Build delivery, security, and observability in from the start](../principles/built-in-from-the-beginning.md) is the principle this practice applies.

[Practices](README.md)
