# Build a primitive around one resource type

**Strength:** Team default

## The problem

A module that creates several resources also creates assumptions about how those resources fit together. A collection or a reference architecture cannot reuse the one resource it needs without taking the other resources and those assumptions with it. Callers then copy the module or work around it, and the platform no longer has one definition of that resource.

## The position

A primitive represents one resource type. That is the unit a collection and a reference architecture compose. It is a stable interface to that provider resource and nothing more. It may include data sources when the resource cannot be declared without information that already exists. It may set a default when the caller can override that default through the module's inputs. It does not generate names, and it does not take on network layout or product decisions that belong to the caller. Examples and tests use the `resource_name` library module when they need a name. The primitive module itself does not call it.

Secure defaults from [the module contract](README.md) apply to the settings of this one resource. A second resource type, including a sibling that only configures the first, is its own primitive. Grouping those primitives is a collection.

A primitive may wrap a third-party module only when all four of these are true:

- The third-party module is one logical unit, meaning one provider resource type.
- It is actively maintained.
- It can be composed into a collection or a reference architecture without hiding choices those modules must make.
- It has tests the team can run.

If any of the four is false, write the primitive against the provider resource.

Provider configuration, secure defaults, examples, and versions follow [the module contract](README.md).

## What the team expects

- Expose one resource type. Do not add a second resource type because one caller would find it convenient.
- Add a data source only when the resource declaration needs it.
- Set a default only when the caller can override it through the module inputs.
- Do not generate names in the module. Use `resource_name` in the examples and tests when those examples need a name.
- Leave environment decisions to the caller.
- Wrap a third-party module only when all four conditions above are true.
- Follow the module contract for providers, defaults, examples, tests, and versions.

## Where implementation details live

The primitive repository holds its variables, outputs, and examples. [Test the behavior a module claims](../testing.md) is the testing standard. [Show that the declared version floor works](../version-compatibility.md) is the version-floor standard. The address `standards/iac-development/terraform/module/primitive/` remains as a compatibility page because existing links use it.

[Module contract](README.md)
