# New ideas

Pages in this directory are proposals. A proposal is neither a commitment nor a supported standard. Existing here does not authorize a team default, a procedure, or a claim that the platform provides the idea.

## What belongs here

A proposal that can be reviewed against evidence. It names the problem, the current hypothesis, why the idea may be worth pursuing, the known trade-offs, the evidence still required, an owner, a last-reviewed date, and the criteria for promoting or abandoning it.

## What does not belong here

- An adopted [principle](../principles/README.md), [practice](../practices/README.md), or [standard](../standards/README.md).
- A [platform map](../platform/README.md) entry for a component the team already operates.
- A title with no problem statement and no hypothesis.
- Component implementation detail. That belongs in the owning component repository.
- Historical procedures. Those belong in the [archive](../archive/README.md).

## Questions an idea page answers

Idea pages do not answer the active-guidance contract. Those four questions (problem, position, expectation, and where the mechanics live) apply only after promotion, on the principle, practice, standard, or map page that replaces the proposal.

Until then, the proposal answers the sections in [idea-template.md](idea-template.md):

- Problem or opportunity
- Current hypothesis
- Why this may be worth pursuing
- Trade-offs and open questions
- Evidence or experiments needed
- Promotion or abandonment criteria

## Lifecycle

1. Copy [idea-template.md](idea-template.md) to a new Markdown file in this directory. Leave the template as the blank form.
2. Set **Status** to `Exploring`, name an owner as a team or a role, and set **Last reviewed** to the date the page was last judged still accurate.
3. Fill every section. Do not add a file that only reserves a title.
4. While status is `Exploring`, the page is a hypothesis under test. It requires nothing of engineers building on the platform.
5. **Promoted.** The promotion criteria on the page are met. Rewrite the durable content into the matching active section. Set **Status** to `Promoted` and point to that active page. The idea page is no longer guidance.
6. **Abandoned.** The abandonment criteria are met, or the evidence shows the idea is not worth pursuing. Set **Status** to `Abandoned` and record why. An abandoned page is not a side door into the standards.

No proposal pages exist yet. The template is the only file in this directory besides this index.

[Knowledge base home](../README.md)
