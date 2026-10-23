# Pin the tools a repository requires

**Strength:** Team default

## The problem

Two engineers on the same repository, with different tool versions, do not debug the same failure. When one laptop runs a newer tool than the module's declared floor, a failure at the floor stays hidden until the next person hits it. A setup guide that lists install commands goes stale the next time the tool is released.

## The position

A repository pins the tools it requires in `.tool-versions`. The pin is the version a developer, a test, and a pipeline can run. Where the repository also declares a version in another file, the pin matches that declaration. A Go module's pin matches `go.mod`. A Terraform module's Terraform pin is inside the range `required_version` allows. The pin is the version for everyday work. The run at the declared floor that [Show that the declared version floor works](../terraform/version-compatibility.md) requires is a separate pipeline check, and it does not change the pin.

The standard does not require a particular program to read `.tool-versions`. It requires that the file be present and that the versions in it be the ones the repository is supported on. Install steps stay in the repository only when a person cannot start from the pin alone, as [Self-contained repository delivery](../../principles/self-contained-repository-deployment-principle.md) describes.

## What the team expects

- Commit `.tool-versions` for every tool the repository needs a fixed version of.
- Keep the pin consistent with `go.mod`, `required_version`, and any other version the repository declares.
- Change the pin in the same change that requires the new version.
- Do not document a personal install sequence as the way to obtain a tool that the pin already names.

## Where implementation details live

The repository's `.tool-versions` file is the pin. This page does not select a version manager.

[Standards](../README.md)
