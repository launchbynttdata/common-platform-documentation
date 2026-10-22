# Hold shared Terraform modules to one contract

**Strength:** Team default

## The problem

A module that is easy for its author and surprising for its caller becomes a private fork. The next team copies it, turns protections off because they were optional, or configures the provider inside the module and then cannot use the module in another account. The platform then has several versions of the same resource, and none of them is the one other teams can take as given.

## The position

A shared module publishes one contract. The contract says what the module provides, what the caller must supply, and what it will not do. One repository holds that contract, because the [single-purpose repository](../../../principles/single-purpose-repository-principle.md) principle gives each repository one independently understandable lifecycle. The repository name follows [Name infrastructure repositories by tool, provider, type, and resource](../../common-development/git/repository/naming-schemes/iac-repository-names.md).

The caller supplies the provider configuration. A reusable module declares the providers, version floors, and configuration aliases it requires. It does not contain a `provider` block of its own, including a block that only sets tags or an identity. A configured provider inside the module prevents a caller from passing the provider they already use.

A caller of a shared module receives the protections the module's resources require, without having to turn them on. For a data store, that includes encryption and network access limited to the callers who need it. For an identity, that includes only the permissions the workload needs. When those protections are optional, the configuration that omits them is the one most consumers will run. A library module is the exception. It creates no infrastructure, so it has no stored data and no network path, and those three protections are not part of its contract. [Use a library module to transform inputs into shared outputs](library.md) states that limit.

When an example needs a supporting resource outside the module under test, it uses an existing Launch primitive where a compatible one exists. The example then shows how modules compose. A raw resource beside the module teaches the path the module was written to replace. The module under test is still called directly. This rule is about the resources around it.

A published module is semantically versioned. Consumers pin a version and stay on it, without having to change that pin, when a newer version is published. [Version published modules semantically](../../common-development/versioning/README.md) is the version standard.

## What the team expects

- Put one module contract in one repository, name the team that owns its lifecycle, and name the repository with the infrastructure naming scheme.
- Declare required providers, version floors, and configuration aliases. Do not put a `provider` block in a reusable module.
- Enable encryption, limited network access, and least-privilege identity by default wherever the resource has those concerns. A caller gets them without setting an input.
- Record who accepted an exception, and why, when one of those protections is weakened.
- Use an existing compatible Launch primitive for a supporting resource in an example. Do not declare that supporting resource directly from the provider.
- Tag a release consumers can pin. Do not require them to move when a newer release is published.
- Test the behavior the contract claims, and run those tests at the declared version floor. [Test the behavior a module claims](../testing.md) and [Show that the declared version floor works](../version-compatibility.md) state those requirements.

## Where implementation details live

The module type pages state the extra rules for a [primitive](primitive.md), a [collection](collection.md), a [reference architecture](reference-architecture.md), and a [library](library.md). Each module repository holds its variables, outputs, examples, and tests. New module repositories are created from the [module generator](https://github.com/launchbynttdata/launch-terraform-modules).

[Standards](../../README.md)
