# Confirm a claim with a check that would fail

**Strength:** Team default

## The problem

A statement that a change is safe, complete, or compatible is easy to make and expensive to believe when it is wrong. A green check of unrelated tests, a plan that was not applied, and a compatibility table that was never run all leave the claim untested. The next person inherits the claim and builds on it.

## The position

A claim about a change is confirmed only by a check that fails when the claim is false, run against that change. The check has to exercise the behavior the claim names. A test suite that does not contain that behavior can pass and still say nothing about the claim. A plan shows what a tool intends to do. As [Maintain infrastructure as software](../practices/infrastructure-as-software.md) explains, a plan is evidence, not certainty. It confirms the claim only after the applied result is compared with what the plan promised.

For a shared module, the functional test is that check, and [Test the behavior a module claims](terraform/testing.md) says what the test has to assert. For a version floor, the check is a run at that floor, as [Show that the declared version floor works](terraform/version-compatibility.md) requires. A reviewer's approval does not replace either check. The approval is the judgment that the claim, and the check, are the right ones.

## What the team expects

- State the specific behavior a change or release relies on, and verify it with a check that fails when that behavior is absent.
- Do not treat a passing test suite, a plan, or a compatibility table as evidence for behavior that the suite, the plan, or the table did not exercise.
- Keep the check in the repository that owns the change, so the next change runs it again.

## Where implementation details live

The owning repository holds the tests and the pipeline that runs them. [Trust is earned through reliability and evidence](../principles/trust-and-evidence.md) is the principle this standard applies.

[Standards](README.md)
