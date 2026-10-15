# Rigor increases as others depend on a capability

**Strength:** Principle

## The problem

Applying the same level of process to every piece of work causes two difficulties. If every experiment must meet the contracts, tests, and reviews expected of a production system, the team learns slowly and people become reluctant to try ideas. If a capability that many teams depend on is held only to the lighter standard suited to an experiment, all of those teams are exposed to failures they did not agree to risk and cannot easily diagnose.

## The position

The rigor a capability requires depends on who relies on it and what a failure would affect. An experiment used only by its author can be lightweight. If it fails, only its author is affected, and the author already understands the risk. A capability that other teams, other repositories, or production systems depend on needs stronger contracts, tests, ownership, and recovery. A failure in a shared capability reaches every team that uses it, and those teams may not know enough about it to diagnose the problem themselves.

Matching rigor to dependency lets the team learn quickly while protecting the systems that others trust. It also gives engineers a practical way to decide how much process a change needs: identify who depends on it, and consider what they would experience if it failed.

## What the team expects

- Label experimental work as experimental, and keep it out of paths that others depend on until it meets the expectations of a shared capability.
- Before a capability becomes a shared or production dependency, give it:
  - a documented contract that describes its inputs, outputs, behavior, and supported versions;
  - automated tests that exercise the behavior consumers rely on;
  - a named owner who maintains it and responds to problems; and
  - a recovery path, such as a rollback, a previous version, or a documented restore procedure.
- Version shared capabilities so consumers can choose when to adopt a change, and announce changes that require consumers to act.
- Increase rigor as adoption grows. A capability that began as an experiment and now has several consumers should be brought up to the expectations of a shared capability.

## Where implementation details live

Versioning, testing, and module contracts belong in [standards](../standards/README.md). Direction that is still experimental is recorded in [new ideas](../new-ideas/README.md).

[Principles](README.md)
