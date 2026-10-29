# Compose primitives into a collection

**Strength:** Team default

## The problem

Callers who need the same group of resources will each assemble that group differently if the platform does not publish the group. They will also declare the cloud resources again, with a second set of defaults, instead of calling the primitive that already has the supported configuration.

## The position

A collection composes primitives, library modules, and other collections into one callable behavior. It is a convenience boundary, not an environment. It does not declare bare cloud resources. It calls the modules that own those resources. It may call any other module type, including a library module such as `resource_name`, so long as it stays inside that boundary. It defers decisions that depend on the environment to the caller.

A collection used to be called a wrapper. The name changed. The rule did not: the collection groups modules, and the primitives still own the resources.

Provider configuration, secure defaults, examples, and versions follow [the module contract](README.md).

## What the team expects

- Call primitives and library modules for every resource the collection manages. Do not declare those resources again in the collection.
- Defer environment-specific decisions to the caller that owns the environment.
- Do not design the collection as a whole environment. A deployment root, a reference architecture, or another collection may call it. The collection is applied on its own only in its example and its tests.
- Follow the module contract for providers, defaults, examples, tests, and versions.

## Where implementation details live

The collection repository holds its variables, outputs, and examples. [Test the behavior a module claims](../testing.md) is the testing standard. The address `standards/iac-development/terraform/module/collection/` remains as a compatibility page because existing links use it.

[Module contract](README.md)
