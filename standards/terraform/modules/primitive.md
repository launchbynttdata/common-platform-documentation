# Build a primitive around one resource type

**Strength:** Team default

## The problem

A module that creates several resources also creates assumptions about how those resources fit together. A collection or a reference architecture cannot reuse the one resource it needs without taking the other resources and those assumptions with it. Callers then copy the module or work around it, and the platform no longer has one definition of that resource.

## The position

A primitive represents one resource type. That is the unit a collection and a reference architecture compose. A primitive may include data sources when the resource cannot be declared without information that already exists. It does not take on naming, network layout, or product decisions that belong to the module that calls it.

A primitive may wrap a third-party module only when all four of these are true:

- The third-party module is one logical unit.
- It is actively maintained.
- It can be composed into a collection or a reference architecture without hiding choices those modules must make.
- It has tests the team can run.

If any of the four is false, write the primitive against the provider resource.

Provider configuration, secure defaults, examples, and versions follow [the module contract](README.md).

## What the team expects

- Expose one resource type. Do not add a second resource type because one caller would find it convenient.
- Add a data source only when the resource declaration needs it.
- Leave naming and environment decisions to the caller.
- Wrap a third-party module only when all four conditions above are true.
- Follow the module contract for providers, defaults, examples, tests, and versions.

## Where implementation details live

The primitive repository holds its variables, outputs, and examples. [Test the behavior a module claims](../testing.md) is the testing standard. [Show that the declared version floor works](../version-compatibility.md) is the version standard. The address `standards/iac-development/terraform/module/primitive/` remains as a compatibility page because existing links use it.

[Module contract](README.md)
