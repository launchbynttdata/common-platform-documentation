# Automatic Semver Tagging with launch-cli

## Discussion

The Launch Platform Team utilizes automated git tagging for managing code versioning. This approach ensures adherence to versioning standards and generates consistent version outputs. To facilitate this process, the team has developed a custom tool called [launch-cli](https://github.com/nexient-llc/launch-cli). The tool is capable of detecting, predicting, and tagging Semver version IDs.

See [semver.org](https://semver.org) for a complete discussion of Semantic Versioning.

## Version Prediction Logic

> **Assertion**: Branch names must follow the `prefix`/`name` format, where the delimiter between `prefix` and `name` is a forward-slash. If the branch name format is not followed, `launch-cli` will generate an error when attempting to predict a version.

The `launch-cli` uses the following logic to predict Semver version IDs:

If the branch prefix contains a `!` or if the first letter of the branch prefix is capitalized:

* Major number is incremented
* Minor number is set to zero
* Patch number is set to zero

If the branch prefix contains the string `feature`:

* Major number remains the same
* Minor number is incremented
* Patch number is set to zero

If the branch prefix contains any of the strings `fix`, `bug`, `patch`, or any other word:

* Major number remains the same.
* Minor number remains the same.
* Patch number is incremented.

## Launch-cli Examples

A repo without tags:

```bash
# bvaughan @ LT-PQJHKQT014 in ~/git_repos/launch/common-platform-documentation on git:feature/auto-version-tagging-docs o [8:44:37] C:2
$ launch github version predict --source-branch "feature/auto-version-taggig-docs"
2024-03-20 08:45:02 CDT	launch.local_repo.predict	WARNING	No tags exist on this repo, defaulting to 0.1.0
0.1.0
```

A repo with existing tags:

```bash
# bvaughan @ LT-PQJHKQT014 in ~/git_repos/launch/launch-cli on git:main o [8:47:49] C:130
$ launch github version predict --source-branch "feature/helm-dependency-resolver"
0.4.0
```
