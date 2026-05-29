# Canonical Example — Invisible product debt

Gold-standard example of the Skill. Product/business concept with no consolidated standard term. Serves as reference for Mode 1 with a non-strictly-technical topic and for Mode 8 when a provisional name must be proposed.

## How we got here (flow summary)

This concept **has no consolidated standard term** in product literature. It started as an intuition and was decompressed into a provisional package.

1. **Orient**: target level = Explain. To use in conversations with CTO/CEO.
2. **Decompress**: what kind of debt? Not technical. How does it manifest? As velocity that erodes without an obvious cause.
3. **Central pattern**: decisions that seem free today but invisibly erode velocity.
4. **Minimal example**: adding an optional feature that seems "costs nothing" because "you can always ignore it".
5. **Analogy with limit**: like accumulating things in a backpack — each item weighs little, no single day stands out. Breaks because technical debt usually has symptoms (bugs, slowness) and this one doesn't.
6. **Limits**: applies to product/UX, not to infra (infra hurts fast).
7. **Package**: see below.
8. **Connect**: technical debt, feature creep, accidental complexity, default paths.
9. **Serialize**: 30s for CEO, 30s for PM, 10s for Slack.
10. **Validate**: give 3 cases and say which are invisible debt and which are not.
11. **Expand**: if we move to Apply, open "how to detect invisible debt in a review".

## Long package

```
CONCEPT: Invisible product debt (provisional name — no consolidated standard term found)

CENTRAL PATTERN:
Decisions that seem free today but invisibly erode product velocity, with no measurable symptoms in the short term.

PROBLEM:
Unlike technical debt (which produces bugs, slowness, deploy friction), invisible product debt generates no clear symptoms. It accumulates through optional features, configurations that "can always be ignored", secondary paths that seem cheap. Each individual decision is defensible. The sum erodes the ability to evolve the product.

MECHANISM:
Each optional feature or secondary configuration multiplies the state space that product, support, and QA must consider. Even if most users don't use it, all future changes must preserve the behavior in the presence of that feature. It is an invisible constraint on future decisions.

EXAMPLE:
A team adds a "show X in compact view" toggle because a customer asked for it. No one else uses it. Three quarters later, the team tries to redesign the view — and discovers that any design proposal must account for the toggle case. What seemed free weighs indefinitely on the roadmap.

COUNTER-EXAMPLE:
Does not apply to decisions that do have measurable symptoms (slowness, bugs, infra cost). That is technical or operational debt, not invisible. Also does not apply to features the bulk of users actually use — those are "core", not "secondary configuration".

RELATIONS:
- Technical debt: has symptoms; this one doesn't.
- Feature creep: one of the most common causes.
- Accidental complexity (Brooks): conceptual family.
- Default paths: deciding the "normal path" reduces this type of debt.
- Optionality cost (finance): analogous family, not identical.

USE:
In roadmap conversations when discussing whether to add an option or configuration "that barely costs anything". Useful for forcing the question: "what invisible weight are we going to carry after this?"

30-SECOND PITCH:
Invisible product debt is what accumulates when you add features or options that seem free today. Each one invisibly restricts what you can change tomorrow. It produces no bugs or slowness, only erodes the velocity of product evolution.

TARGET LEVEL: explain
TAUGHT LEVEL: explain
VALIDATED LEVEL: pending
CONFIDENCE: medium (the pattern holds up under sparring, the term is provisional)
SOURCE: own intuition + analogies from product literature
ANCHOR WORDS: feature creep, configuration burden, optionality cost, path multiplicity
NEXT BRANCH: how to measure or detect it in a roadmap review.
STATE: ready-for-validation (package taught; Mode 4 + contrast with literature still pending)
```

## Critical distinction

Technical debt has symptoms (bugs, slowness, operational friction). The invisible kind doesn't — its damage is only on future decisions. If you confuse the two, you try to measure it with metrics that don't apply.

## Anchor words (Mode 8)

- **"Feature creep"** — close, not exact (feature creep is the process; invisible debt is the residue).
- **"Optionality cost"** — close, comes from finance (the cost of keeping options open).
- **"Configuration burden"** — close, used by some PMs for accumulated configurations.
- **"Path multiplicity"** — provisional, not standard.

## Serializations

**For CEO (30s)**:
"There is a type of product debt that produces no bugs or slowness, only erodes our ability to change the product in the future. It happens when we add 'free' options or features. Each one limits us invisibly, forever."

**For PM (10s)**:
"Every optional feature we accept today is an invisible constraint on tomorrow's roadmap."

**For Slack (30s)**:
"⚠️ Before adding that toggle: every extra option restricts what we can change later. What seems free today weighs indefinitely. It produces no bugs, only erodes velocity."

**For a roadmap review (anchor phrase)**:
"What invisible weight are we going to carry after this?"

## Templates

- `templates/concept-package.md` (long version)
- `templates/validation.md` (mini-rubric)
