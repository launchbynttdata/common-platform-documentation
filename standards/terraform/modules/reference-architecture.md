# Publish a reference architecture as one deployable environment

**Strength:** Team default

## The problem

A diagram of an environment does not give a team a system they can apply, explain, and repeat. If the architecture creates cloud resources on its own, those resources bypass the primitives that carry the supported defaults. The environment and the shared modules then disagree about what a correct resource is.

## The position

A reference architecture is one environment of a system. A caller applies a root that calls the architecture and passes the inputs, including the provider configuration. The architecture module is not applied as a root, and it does not contain a provider block. It is composed of collections, primitives, and library modules. It does not declare bare cloud resources. It may call any of those module types, including `resource_name` when it owns the names. It makes the decisions a collection defers, including how the pieces are wired, because it is the top of that stack.

The architecture is ready for an engagement when a caller can produce that environment from reviewed source, and when the resources inside it are the shared modules rather than a private copy. Provider configuration, secure defaults, examples, and versions follow [the module contract](README.md).

## What the team expects

- Build the architecture from collections, primitives, and library modules. Do not declare bare cloud resources in the architecture.
- Own the environment decisions those modules defer. Call `resource_name` when the architecture owns the names.
- Pass provider configuration in from the caller. Do not put a provider block in the architecture, and do not apply the architecture module as a root.
- Call the architecture as one environment, not as a sample that a team is expected to rewrite before use.
- Follow the module contract for providers, defaults, examples, tests, and versions.

## Where implementation details live

The reference-architecture repository holds its variables, outputs, and examples. [Test the behavior a module claims](../testing.md) is the testing standard. The address `standards/iac-development/terraform/module/reference-architecture/` remains as a compatibility page because existing links use it.

[Module contract](README.md)
