# Show that the declared version floor works

**Strength:** Team default

## The problem

A module declares two version floors. One is the oldest version of the Terraform tool the module supports. The other is the oldest version of a provider the module supports. A floor that has never been tried tells callers they can use a version where the module fails. Confirming one floor does not confirm the other. A compatibility table, meaning a list of which Terraform language features each version supports, does not catch a false floor. Features interact, and a constraint can allow versions the table never listed.

## The position

A version constraint is a claim that the module works at that floor. The floor is the oldest version the module is willing to support. The claim is confirmed by a check that runs at that floor and fails when the module needs a newer version, as [Confirm a claim with a check that would fail](../confirming-a-claim.md) requires. A pipeline that runs a newer pinned version shows that the newer version works. It does not show that the floor works.

The Terraform floor is `required_version`. The team's current CI check confirms that floor. It runs the module at the oldest Terraform version the constraint admits, so a language feature newer than that floor fails the check. The check's own file describes the steps it uses today.

A provider floor is separate. No automated check today compares the module with the oldest provider version it declares. The engineer implementing the module verifies that floor at implementation time. A passing Terraform CI check does not verify a provider floor.

Raising either floor follows [Version published modules semantically](../common-development/versioning/README.md). In the general case a higher floor is a breaking change, because callers lose a version they were allowed to use. A floor that only removes a version where the module already failed is the exception that page describes.

## What the team expects

- Declare `required_version` as the oldest Terraform version the module supports, and confirm it with the CI version-floor check.
- Declare each provider version constraint as the oldest provider version the module supports. The engineer implementing the module verifies that floor at implementation time.
- Do not treat the Terraform CI check, or a successful run on a newer pinned version, as proof of a provider floor.
- Do not maintain a compatibility table as a substitute for the Terraform CI check or for the engineer's verification of a provider floor.
- When the module starts requiring a newer Terraform version or a newer provider version, raise that floor and version the change as the versioning standard describes.

## Where implementation details live

The module repository holds the version constraints. The CI check for the Terraform floor is [`check-terraform-version-floor.sh`](https://github.com/launchbynttdata/launch-terraform-skeleton/blob/main/template/.github/scripts/check-terraform-version-floor.sh) in the public repository `launch-terraform-skeleton`. That file is the current description of how the Terraform floor is checked. This page does not restate those steps, because they change as the check changes. There is no shared automated check for a provider floor. This page does not pin a Terraform version for every module. [Hold shared Terraform modules to one contract](modules/README.md) requires both floors to be declared.

[Standards](../README.md)
