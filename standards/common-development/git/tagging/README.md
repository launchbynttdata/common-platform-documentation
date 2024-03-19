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
