# Show that the declared version floor works

**Strength:** Team default

## The problem

A module can declare a Terraform or provider version it has never been run with. The declaration then tells callers they can use a version where the module fails. A compatibility table, meaning a list of which Terraform language features each version supports, does not catch that. Features interact, and a constraint can allow versions the table never listed.

## The position

The version constraint in the module is a claim that the module works at that floor. The claim is confirmed by running the module's checks with that version. A pipeline that runs a newer pinned version shows that the newer version works. It does not show that the floor works. A version constraint is a claim, so it follows [Confirm a claim with a check that would fail](../confirming-a-claim.md).

The floor is the oldest version the module is willing to support, not the oldest version the author hopes is compatible. If the module uses a language or provider feature, the floor is at least the version that introduced that feature, and the checks have been run there. Raising the floor is a contract change and follows [Version published modules semantically](../common-development/versioning/README.md).

## What the team expects

- Set `required_version` and the provider version constraints to versions the module's checks have run.
- Run the functional test at the declared floor before publishing a module that claims that floor.
- Do not treat a successful run on a newer pinned version as proof of the floor.
- Do not maintain a compatibility table as a substitute for that run.
- Raise the floor in a release when the module starts requiring a newer version, and record it as the contract change it is.

## Where implementation details live

The module repository holds the version constraints. The check that runs them is the pipeline configured for that repository. This page does not pin a Terraform version for every module. [Hold shared Terraform modules to one contract](modules/README.md) requires the floor to be declared.

[Standards](../README.md)
