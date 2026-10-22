# Version published modules semantically

**Strength:** Team default

## The problem

A caller who takes a module by a moving branch, or by a tag that does not say whether the contract changed, cannot tell whether today's release will break the configuration that worked yesterday. A team that bumps the major version for a documentation fix trains callers to ignore major versions. A team that hides a breaking change in a patch trains callers not to upgrade.

## The position

A published module is versioned semantically. The major version changes when the contract breaks: an input is removed or renamed, an output changes meaning, a default changes so existing callers get a different result, or the version floor rises in a way that drops a version callers were allowed to use. The minor version changes when the module adds behavior existing callers can ignore. The patch version changes for a fix or a documentation change that keeps the contract callers rely on.

A new module stays below 1.0 until the contract is stable enough that the team is willing to treat a break as a major version. The first supported release is not 1.0 by default. Below 1.0, a breaking change bumps the minor version, and every other change bumps the patch version. A caller who pins a version below 1.0 should expect a minor version to break the contract.

Callers pin a version. Publishing a newer version does not require them to change that pin. The archived tagging note is historical and is not this standard. It remains at [archive/pre-refresh/standards/common-development/git/tagging/README.md](../../../archive/pre-refresh/standards/common-development/git/tagging/README.md).

## What the team expects

- Tag published module releases as major, minor, and patch versions.
- Bump the major version when the contract breaks, including a version floor that removes a previously allowed version.
- Keep a new module below 1.0 until its contract is stable. Below 1.0, bump the minor version for a breaking change.
- Let callers remain on the version they pinned when a newer release is published.
- Do not use an unpinned branch as the version other repositories consume.

## Where implementation details live

Each module repository holds its version tags and release workflow. The release automation is the workflow that repository already uses.

[Standards](../../README.md)
