# Show that the declared version floor works

**Strength:** Team default

## The problem

A module can declare a Terraform or provider version it has never been run with. The declaration then tells callers they can use a version where the module fails. A compatibility table, meaning a list of which Terraform language features each version supports, does not catch that. Features interact, and a constraint can allow versions the table never listed.

## The position

The version constraint in the module is a claim that the module works at that floor. The claim is confirmed by a check that runs at that floor and fails when the module needs a newer version. A pipeline that runs a newer pinned version shows that the newer version works. It does not show that the floor works. A version constraint is a claim, so it follows [Confirm a claim with a check that would fail](../confirming-a-claim.md).

The floor is the oldest version the module is willing to support. The version-floor check exists to load the module at that version, so a feature newer than the floor fails the check. What the check runs today is documented with the check. This page does not restate it, because that description changes as the check changes. Raising the floor follows [Version published modules semantically](../common-development/versioning/README.md). In the general case a higher floor is a breaking change, because callers lose a version they were allowed to use. A floor that only removes a version where the module already failed is the exception that page describes.

## What the team expects

- Declare `required_version` and the provider version constraints as claims that the module works at those floors.
- Confirm the declared floor with the version-floor check. The check's own documentation says which constraints it loads today.
- Do not treat a successful run on a newer pinned version as proof of the floor.
- Do not maintain a compatibility table as a substitute for the version-floor check.
- When the module starts requiring a newer version, raise the floor and version that change as the versioning standard describes.

## Where implementation details live

The module repository holds the version constraints. The check is [`check-terraform-version-floor.sh`](https://github.com/launchbynttdata/launch-terraform-skeleton/blob/main/template/.github/scripts/check-terraform-version-floor.sh) in the public repository `launch-terraform-skeleton`. That file is the current description of what the check runs. This page does not pin a Terraform version for every module. [Hold shared Terraform modules to one contract](modules/README.md) requires the floor to be declared.

[Standards](../README.md)
