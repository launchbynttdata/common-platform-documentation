# How to read these docs

This page explains how the Launch by NTT DATA Platform Engineering team organizes this knowledge base, what the labels on each page mean, and how to propose a change. Read it once before relying on the guidance in the other sections.

## Why this knowledge base exists

The team records its reasoning here so that engineers can understand why the platform is built the way it is, not only what to do. Guidance that explains its reasons can be applied sensibly in situations the authors did not anticipate. It can also be questioned and improved when those reasons no longer hold.

This knowledge base holds reasons, team expectations, and team defaults. It does not hold step-by-step procedures, commands, or component configuration. Those details change often, and they stay accurate only when they are maintained next to the component they describe. Each page therefore ends by pointing to the place where current implementation details live.

## Document types

The knowledge base has five kinds of active content. Each has its own section.

- **Principles** explain why the team works as it does. A principle should remain true even after the current tools are replaced.
- **Practices** describe how the principles shape everyday delivery and operations work.
- **Standards** state how the team would implement a capability when it is free to choose. They are requirements for the modules the Launch by NTT DATA Platform Engineering team owns in the `launchbynttdata` organization. Client work may drive changes to those modules. The standards do not govern code the client owns. On that work they are a direction platform engineers extend as far as the engagement can support.
- **The platform map** describes what each major part of the Launch platform is for, how the parts relate, and which repository owns each one.
- **New ideas** record proposals the team is exploring. A new idea is not yet a supported standard, and publishing it is not a commitment to adopt it.

The [archive](archive/README.md) holds historical material. Archived pages begin with a banner stating that they are not current guidance. They remain available so earlier decisions can be read in context, and they should not be used as instructions.

## How pages are organized

Principle, practice, and standard pages use the same four headings, so a reader always knows where to find each part of the argument.

1. **The problem** describes the situation the page addresses and why it matters.
2. **The position** states what the team believes or has decided, and explains the reasoning that leads to it.
3. **What the team expects** lists what engineers are expected to do as a result.
4. **Where implementation details live** points to the repository or section that holds the current mechanics.

Pages that describe a context-dependent choice, such as [repository topology](strategies/poly-git-repo-strategy.md), use the same headings. Their position section sets out the trade-offs and names the team default.

[Promote a new idea into active guidance](promoting-an-idea.md) is a team default about how this knowledge base changes. It sits beside this page rather than in a content section, and it uses the same four headings.

New idea pages follow the [idea template](new-ideas/idea-template.md), which records the problem, the current hypothesis, the open questions, and the criteria for adopting or abandoning the idea. Platform map pages describe what a capability is for, how it relates to other capabilities, and where its documentation lives. Section index pages describe what belongs in the section and what does not.

## Strength labels

Each principle, practice, and standard page states its strength near the top. The strength tells the reader how firmly the team holds the statement and how much room there is to depart from it. The term is shared with the team's other engineering guidance, so the same label means the same thing wherever it appears.

- **Principle.** A durable reason that the team expects to keep when tools and circumstances change. Departing from a principle means the team's reasoning has changed. If a principle no longer seems right, raise it for discussion rather than working around it.
- **Team default.** The team's current preferred approach. The Launch by NTT DATA Platform Engineering team owns the modules in the `launchbynttdata` organization, and a team default is a requirement for those modules. Client work can change a module the team owns, and that change still meets the default or records why it does not. An engagement owns the client code that calls those modules. How that ownership is structured varies by engagement. This knowledge base does not govern code the client owns. On that work, platform engineers extend the default as far as the engagement can support. [Standards](standards/README.md) describes that extension: meet the client where the client is, keep the constraint and the trade-off visible, and take the next useful step.
- **Context-dependent choice.** A decision that depends on the needs of a particular engagement or client. The page explains the trade-offs and, where one exists, the team default. Make the choice deliberately and record the reasons.

A page labeled as a principle can contain a statement with a different strength. In that case, the statement is labeled where it appears. For example, the [single-purpose repository](principles/single-purpose-repository-principle.md) principle includes a team default about using multiple repositories.

## How pages are written

Pages are formal and easy to follow. They should leave a reader with a clear understanding of the team's position, and they should represent the Launch by NTT DATA Platform Engineering team constructively.

A page leads the reader to its conclusion. It states the context the conclusion depends on, then the reasoning, then what the team expects. It does not skip a step that a reader would have to supply, and it does not compress an argument into a short phrase that makes sense only to someone who already shares it.

Pages use complete sentences. They state the team's position and the reasons for it. A sentence has to say something a reader can apply or check. A phrase that only sounds decisive, or a sentence that restates an intention the rest of the page already assumes, does not do that work. Pages avoid slogans, exaggeration, antagonistic comparisons, and terms that do not have a plain meaning on the page. A comparison appears only when the team already shares it, and the page explains it in ordinary language. Two of those shared phrases are going fast like IndyCar rather than fast like Wile E. Coyote, and "slow is smooth, smooth is fast."

A word or phrase is used for one meaning. When the same words can name more than one thing, the page makes clear which meaning is intended, and later pages keep that meaning. This field uses jargon that cannot be avoided. Jargon used in this knowledge base is defined in language a reader can check, and then used the same way on every page. A term that appears on more than one page is defined in [Terms used in a specific sense](#terms-used-in-a-specific-sense). A term that matters on only one page is defined on that page. A page defines a term when a reader could otherwise take it to mean something else. It does not define an ordinary word, and it does not repeat a definition the reader of that page can already find. For example, "Launch by NTT DATA Platform Engineering team" names this team, and "platform engineering" names the discipline.

The length of a page follows the argument. A page is not padded with restatement, and it is not cut so short that the reader has to guess the missing step.

Practices, standards, and the platform map use this standard as well. Principles, practices, and standards use the four headings above. The platform map and new ideas use the structures described in this page.

## Terms used in a specific sense

- **Delivery team.** The people who build and operate software for a client, including application developers, quality engineers, and platform engineers.
- **Engagement.** A client project that the team supports.
- **Capability.** Something the platform provides that others use, such as a deployment pipeline, a Terraform module, or a logging service.
- **Consumer.** A team, repository, or system that uses a capability.
- **Contract.** The published behavior of a capability that consumers can rely on, such as its inputs, outputs, and supported versions.
- **Artifact.** A versioned output of a build, such as a container image or a released module, that is deployed or consumed without being rebuilt.

## How this knowledge base changes

Anyone can propose a change by opening an issue. The issue templates ask for the information the team needs to evaluate the request, such as the page affected, the problem with the current text, and the evidence for a correction.

Changes are made through pull requests. Each pull request runs an automated documentation check that verifies links and blocks private information, such as personal file paths, account identifiers, and email addresses. An idea becomes a principle, a practice, or a standard only through the process in [Promote a new idea into active guidance](promoting-an-idea.md).

Notable changes are recorded in the [changelog](CHANGELOG.md).

[Knowledge base home](README.md)
