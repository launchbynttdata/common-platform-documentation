# Use a library module to transform inputs into shared outputs

**Strength:** Team default

## The problem

Modules that each invent names, identifiers, or other derived values drift apart. A tag or a permission that depends on the name then fails in one module and works in another. Copying the transformation into every module also means a correction has to be repeated in every repository.

## The position

A library module accepts inputs, transforms them, and publishes outputs. It does not create or manage infrastructure. Other modules call it so the transformation has one implementation.

`resource_name` is the library module the team uses for names. It takes naming inputs and returns the name variants callers apply to resources and tags. A primitive does not call it. A primitive's examples and tests call it when they need a name. Any other module type may call it, so long as that module stays inside its own mandate. A library module still does not create or manage infrastructure. The module is [tf-launch-module_library-resource_name](https://github.com/launchbynttdata/tf-launch-module_library-resource_name).

A library module has no stored data and no network path. Encryption, limited network access, and least-privilege identity are not part of its contract. A change that needs those protections is a primitive or a collection, not a library. The rest of [the module contract](README.md) still applies: one repository, a declared provider floor when the module has one, a version consumers can pin, and tests of the behavior it claims.

## What the team expects

- Do not create or manage infrastructure from a library module.
- Put a shared transformation in a library module instead of copying it into each caller.
- Use `resource_name` for the platform naming outputs. A primitive accepts those names as inputs. Its examples and tests may call `resource_name`.
- Test representative inputs and the outputs they must produce. A library test fails when the transformation is wrong. It does not provision cloud resources to prove that.
- Version and own the module as the module contract requires.

## Where implementation details live

Each library repository holds its inputs, outputs, and tests. [Test the behavior a module claims](../testing.md) covers a module that creates no infrastructure. The address `standards/iac-development/terraform/module/library/` remains as a compatibility page because existing links use it.

[Module contract](README.md)
