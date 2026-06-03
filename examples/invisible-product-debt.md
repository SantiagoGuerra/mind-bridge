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

> **Invisible product debt** *(provisional name, no consolidated standard term found)*
>
> **The idea:** decisions that seem free today but quietly erode how fast you can change the product, with no measurable symptoms in the short term.
>
> **The problem it solves:** unlike technical debt (which shows up as bugs, slowness, deploy friction), this kind leaves no clear symptoms. It builds up through optional features, settings that "you can always ignore", secondary paths that look cheap. Each single decision is defensible. The sum erodes your ability to evolve the product.
>
> **How it works:** every optional feature or secondary setting multiplies the cases that product, support, and QA have to keep in mind. Even if almost no one uses it, every future change has to preserve its behavior. It becomes an invisible constraint on tomorrow's decisions.
>
> **An example:** a team adds a "show X in compact view" toggle because one customer asked. No one else uses it. Three quarters later they try to redesign the view, and every proposal now has to account for the toggle. What looked free weighs on the roadmap indefinitely.
>
> **Where it breaks:** it doesn't apply to decisions that do have measurable symptoms (slowness, bugs, infra cost). That is technical or operational debt, not invisible. It also doesn't apply to features most users actually use. Those are core, not secondary settings.
>
> **Related:** technical debt (has symptoms, this one doesn't), feature creep (a common cause), accidental complexity (Brooks, *possible literary anchor, verify before publication*), default paths (choosing the normal path reduces this debt), optionality cost from finance (a near cousin, not identical).
>
> **When to use it:** in roadmap conversations, when someone weighs adding an option or setting "that barely costs anything". It forces the real question: what invisible weight do we carry after this?
>
> **In 30 seconds:** "Invisible product debt is what builds up when you add features or options that seem free today. Each one quietly restricts what you can change tomorrow. It produces no bugs or slowness, it just erodes how fast the product can evolve."
>
> *Taught at the explain level, not yet validated (ready-for-validation). Confidence medium: the pattern holds up under sparring, but the term is provisional, and Mode 4 plus a contrast with the literature are still pending.*

Behind the card, the stored entry keeps: `TARGET LEVEL: explain · TAUGHT LEVEL: explain · VALIDATED LEVEL: pending · CONFIDENCE: medium · STATE: ready-for-validation`. Source: own intuition plus analogies from product literature. Anchor words: feature creep, configuration burden, optionality cost, path multiplicity. Next branch: how to measure or detect it in a roadmap review.

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
