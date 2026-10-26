# Show that the declared version floor works

**Strength:** Team default

## The problem

A module can declare a Terraform version, or a provider version, that it has never been run with. The declaration then tells callers they can use a version where the module fails. These are two claims. A check that confirms one of them does not confirm the other. A compatibility table, meaning a list of which Terraform language features each version supports, does not catch a false floor. Features interact, and a constraint can allow versions the table never listed.

## The position

A version constraint is a claim that the module works at that floor. The floor is the oldest version the module is willing to support. The claim is confirmed by a check that runs at that floor and fails when the module needs a newer version, as [Confirm a claim with a check that would fail](../confirming-a-claim.md) requires. A pipeline that runs a newer pinned version shows that the newer version works. It does not show that the floor works.

The Terraform language floor is `required_version`. The version-floor check confirms that floor. It loads the module at the oldest Terraform version the constraint admits, so a language feature newer than that floor fails the check.

A provider version constraint is a separate claim. Declaring the constraint does not show that the module works with that provider version. A passing version-floor check does not show it either. The provider floor is confirmed by a check that fails when the module needs a newer provider than the constraint allows.

Raising either floor follows [Version published modules semantically](../common-development/versioning/README.md). In the general case a higher floor is a breaking change, because callers lose a version they were allowed to use. A floor that only removes a version where the module already failed is the exception that page describes.

## What the team expects

- Declare `required_version` as a claim that the module works at that Terraform version, and confirm it with the version-floor check.
- Declare each provider version constraint as its own claim. Do not treat a passing version-floor check as confirmation of that claim.
- Do not treat a successful run on a newer pinned version as proof of either floor.
- Do not maintain a compatibility table as a substitute for a check that runs at the floor.
- When the module starts requiring a newer Terraform version or a newer provider version, raise that floor and version the change as the versioning standard describes.

## Where implementation details live

The module repository holds the version constraints and the check that confirms each provider floor. The Terraform version-floor check is [`check-terraform-version-floor.sh`](https://github.com/launchbynttdata/launch-terraform-skeleton/blob/main/template/.github/scripts/check-terraform-version-floor.sh) in the public repository `launch-terraform-skeleton`. That file is the current description of how the Terraform language floor is loaded. This page does not restate those steps, because they change as the check changes. This page does not pin a Terraform version for every module. [Hold shared Terraform modules to one contract](modules/README.md) requires both floors to be declared.

[Standards](../README.md)
