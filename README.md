# Platform engineering knowledge base

This repository is the public knowledge base for the Launch by NTT DATA Platform Engineering team. It records why the team builds the platform as it does, which choices are current team defaults, and where implementation detail lives.

Platform engineers are the primary audience. The repository is public, so an engineer outside the team should be able to follow the argument without internal account access or unstated context.

Commands, configuration, and verification belong with the component that owns them. This knowledge base states the durable reason, the team default, and which owning repository holds the mechanics. It does not replace that component's documentation.

[How to read these docs](how-to-read-these-docs.md) explains the document types, the structure each page follows, the strength labels, and how to propose a change. Notable changes are recorded in the [changelog](CHANGELOG.md).

## Content types

**Principle.** A durable claim about why the team works this way. It should still hold after the current tools change.

**Practice.** How those principles change delivery and operations: what an engineer is expected to do, and what stays in a component repository.

**Standard.** How the team would implement a capability when it is free to choose. It is a requirement for work the team owns and a direction to work toward, at the client's pace, when an engagement imposes different requirements.

**Platform map.** A capability-level picture of the current platform: what each major component is for, how the components relate, and where the owning documentation lives. It does not copy component procedures.

**New idea.** A proposal under exploration. Publishing it here is not a commitment, and it is not a supported standard.

## Active guidance

- [Principles](principles/README.md)
- [Practices](practices/README.md)
- [Standards](standards/README.md)
- [Platform map](platform/README.md)

## Proposals

- [New ideas](new-ideas/README.md)

## Historical material

- [Archive](archive/README.md)

The archive is not current guidance. Do not use it as a procedure, a team default, or a source for commands. It remains so older decisions can be read in context. Active navigation stops at that entry point.

## License

Unless explicitly stated otherwise, the content of this repository is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License (CC BY-NC-ND 4.0).

[Full license](LICENSE)
