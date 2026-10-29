# Promote a new idea into active guidance

**Strength:** Team default

## The problem

A page under new ideas can be mistaken for a standard because it is in the knowledge base and it sounds decided. An idea can also sit for months after the evidence is already in hand, so teams keep treating a working path as unofficial. Either outcome means an engineer cannot tell what the team supports.

## The position

An idea has no authority until the team publishes active guidance that stands on its own. Promotion is the decision that the idea's own criteria are met. That decision is one change: the pull request publishes the principle, practice, or standard, and it marks the idea page **Promoted** with a link to that page. Splitting those two updates leaves a period when the knowledge base says two different things. Using the idea on one engagement does not promote it. Linking to the idea from a design does not promote it. Leaving the idea in place long enough that people depend on it does not promote it.

The idea page names its owner and the evidence required to adopt or abandon it before anyone treats the proposal as ready for that decision. The last review is the latest commit that changed the idea page. Git history shows that commit. The knowledge base does not set a date by which the next review must happen. The same review used for any other change to this knowledge base decides the pull request. Promotion is not a separate board.

Abandonment is the same kind of decision. The reviewed change records why the idea is **Abandoned** and does not add an active page. The abandoned page records why the team stopped, and it does not add a requirement for engineers to follow.

After promotion, the active page is the guidance. The idea page remains as the record of the decision, and an engineer does not have to read it to find a requirement. Every requirement moves onto the active page in that same change, written with the four headings and the strength label that [How to read these docs](how-to-read-these-docs.md) requires of active pages.

## What the team expects

- Name the owner and the evidence required to adopt or abandon an idea before treating the page as ready for a promotion decision. The last review is the latest commit on the idea page.
- Promote an idea only when the reviewed evidence meets its criteria. Publish the active page and mark the idea **Promoted** in the same change, so the knowledge base never shows one without the other.
- Make the promoted page self-contained. An engineer must be able to follow it without reading the idea page.
- Keep the idea page as the record of the decision, and point it at the active page.
- Abandon an idea by recording the reason in a reviewed change, without adding an active page. An idea remains a proposal until a reviewed change adopts it or records that the team has abandoned it.
- Review the idea page when its evidence has changed. Record that review as a commit. Do not set a calendar deadline for the next review.

## Where implementation details live

The idea page holds its own criteria and evidence. [New ideas](new-ideas/README.md) is the index of proposals and holds the [idea template](new-ideas/idea-template.md). A promoted idea is received by [principles](principles/README.md), [practices](practices/README.md), or [standards](standards/README.md).

[Knowledge base home](README.md)
