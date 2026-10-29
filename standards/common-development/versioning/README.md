# Version published modules semantically

**Strength:** Team default

## The problem

A caller who takes a module by a moving branch, or by a tag that does not say whether the contract changed, cannot tell whether today's release will break the configuration that worked yesterday. A team that bumps the major version for a documentation fix trains callers to ignore major versions. A team that hides a breaking change in a patch trains callers not to upgrade.

## The position

A published module is versioned semantically. The major version changes when the contract breaks: an input is removed or renamed, an output changes meaning, a default changes so existing callers get a different result, or a version floor changes so callers who were allowed to use the old version no longer can. The minor version changes when the module adds behavior existing callers can ignore. The patch version changes for a fix or a documentation change that keeps the contract callers rely on.

A version-floor change is a breaking change in the general case because the floor is part of the contract. Callers were allowed to select any version the previous floor admitted. When the floor rises past that version, a caller still on it cannot take the module without changing that selection, and a configuration that was valid can fail. The same contract test used for any other change still applies. A floor change that only removes a version where the module already failed corrects a false claim. Callers on that version were already broken. That correction can be a patch.

A breaking change bumps the major version whether or not the module has reached 1.0. Many modules are still below 1.0 because the release workflow has no separate path that publishes a first stable release as 1.0. The workflow maps a breaking change to a major version, including from a 0.x release. It does not publish that break as a minor version.

The changelog for a breaking release points to documentation that tells consumers how to take the change successfully. The module repository holds that documentation. A changelog entry that only says the contract broke, and does not point to that direction, does not meet this standard.

Callers pin a version. Publishing a newer version does not require them to change that pin. The archived tagging note is historical and is not this standard. It remains at [archive/pre-refresh/standards/common-development/git/tagging/README.md](../../../archive/pre-refresh/standards/common-development/git/tagging/README.md).

## What the team expects

- Tag published module releases as major, minor, and patch versions.
- Bump the major version when the contract breaks, including a module that is still below 1.0.
- In the changelog for a breaking release, link to documentation that tells consumers how to take the change.
- Treat a version-floor change as a breaking change when callers lose a version they were allowed to use. A floor change that only removes a version where the module already failed can be a patch.
- Let callers remain on the version they pinned when a newer release is published.
- Do not use an unpinned branch as the version other repositories consume.

## Where implementation details live

Each module repository holds its version tags, its changelog, the upgrade documentation that changelog points to, and the release workflow that publishes the major, minor, and patch versions. That workflow maps a breaking change to a major version.

[Standards](../../README.md)
