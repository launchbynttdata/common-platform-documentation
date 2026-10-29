# Keep procedures in the repository that owns them

**Strength:** Team default

## The problem

A command copied into this knowledge base becomes wrong when the component changes and this page does not. A repository with no statement of what it provides forces the next engineer to reconstruct the supported path from the code. Either failure sends people to a private note or to a person who remembers.

## The position

This knowledge base states the team default and the reason for it. The owning repository states how to use that default and how to verify it. A repository README answers three questions in the repository, not here: what the module or component provides, the supported way to use it, and the command or check that shows the use succeeded.

A standard page may name the repository and the contract. It does not paste the install steps, the variable list, or the test transcript. Those stay next to the code so a change updates them in the same review. [How to read these docs](../how-to-read-these-docs.md) explains why the knowledge base is split this way.

## What the team expects

- State what the repository provides, the supported usage, and how to verify that usage in the repository README.
- Put commands, variable lists, and test transcripts in the owning repository.
- Change this knowledge base when the team default changes. Change the repository README when the usage or the verification changes.
- Do not add a second copy of a procedure in this knowledge base in order to save a reader a link.

## Where implementation details live

Each repository holds its own README, examples, and tests. This page does not set a documentation tool.

[Standards](README.md)
