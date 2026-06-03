# Template — Concept package

Loaded from Mode 2 (package), Mode 1 step 7, Mode 4 (reference), Mode 10 (ingest output).

A concept package is shown to the user as a **readable card**, not a key-value form. It keeps the same parts every time, but it reads like a person explaining the idea: soft **bold** labels, plain sentences underneath. Translate the labels to the user's language (this file shows the English set).

## Default presentation (the card)

> **[Concept name]**
>
> **The idea:** [the deep, reusable pattern, in one sentence]
>
> **The problem it solves:** [what breaks when this idea doesn't exist]
>
> **How it works:** [the mechanism, step by step, in plain prose]
>
> **An example:** [a concrete case, with names and numbers if they help]
>
> **Where it breaks:** [a case where it does NOT apply, or where using it would be a mistake]
>
> **Related:** [neighboring ideas, prerequisites, what triggers it — include only if it adds something]
>
> **When to use it:** [when to reach for it]
>
> **In 30 seconds:** "[pattern + mechanism + example, ready to say out loud]"
>
> *[Status line: taught / validated level + state, in plain language.]*

Each label maps one-to-one to a canonical field (kept for the library and for machine logic):

`The idea` = CENTRAL PATTERN · `The problem it solves` = PROBLEM · `How it works` = MECHANISM · `An example` = EXAMPLE · `Where it breaks` = COUNTER-EXAMPLE · `Related` = RELATIONS · `When to use it` = USE · `In 30 seconds` = 30-SECOND PITCH.

Critical parts: the idea, the problem it solves, how it works, an example, and when to use it. If one is missing, flag it and propose how to complete it. Do not reject bluntly.

Keep the card readable: short paragraphs, no aligned columns, no all-caps field names in the user-facing output. The all-caps names above are internal labels for this doc and for storage, not for display.

## Short form (quick recall)

For a chat message, a quick reminder, or a mental sticky note, three lines is enough:

> **[Concept]:** [the idea, one sentence]. Works by [mechanism in a few words]. Reach for it when [trigger].

## The status line (levels and state)

The card ends with one plain-language line that carries the bookkeeping. It must stay honest (see the anti-false-mastery rule). In words, it encodes these stored values:

```
TARGET LEVEL:    recognize | explain | apply | implement | teach
TAUGHT LEVEL:    recognize | explain | apply | implement | teach
VALIDATED LEVEL: pending | recognize | explain | apply | implement | teach
CONFIDENCE:      low | medium | high
STATE:           raw | packaged | ready-for-validation | partially-installed | installed | validated | aligned | applicable | teachable | stale
```

The line in plain language, for example:

- "Taught at the explain level, not yet validated (ready-for-validation). Next: a quick check that it stuck."
- "Validated at the apply level. You explained it in your own words and used it on a new case."

Other optional fields, added only when they help (kept out of the card body, woven into prose or recorded when saving):

```
SOURCE:          [paper / conversation / own intuition / etc.]
ANCHOR WORDS:    [terms that open the search]
NEXT BRANCH:     [what to deepen later if needed]
SIMPLIFICATIONS: [useful simplifications + nuances left as a compressed branch]
```

**ASCII is canonical for machine-readable fields.** The card shows them in the user's language; the stored values stay ASCII. See `templates/library-entry.md` for the canonical schema.

## Anti-false-mastery rule (critical)

Never declare knowledge installed or validated without the user having passed an active validation.

- **TARGET LEVEL**: what the user asked to reach (from intake).
- **TAUGHT LEVEL**: the level at which it was taught (typically matches objective).
- **VALIDATED LEVEL**: what the user has *demonstrated*. Always starts at `pending` (display: `Pendiente`) after teaching; rises only after Mode 4.

**`CURRENT LEVEL` is deprecated** because it collapsed the three dimensions and produced false mastery. If the user or an old package uses it, translate to the three above before continuing.

### Allowed states (state machine)

| State | When to apply | Who can declare it |
|---|---|---|
| `raw` | Unstructured intuition. | Anyone. |
| `packaged` | Complete package with all critical fields. Not yet interactively taught. | Skill upon finishing Mode 2 without an active user context. |
| `ready-for-validation` | We just taught the package in Mode 1. The user hasn't answered validation yet. | **Default after Mode 1**. |
| `partially-installed` | The user passed some dimensions of the mini-rubric (see `templates/validation.md`) but not all. | Skill only after partial Mode 4. |
| `installed` | The user passed the full mini-rubric: own explanation + mechanism + own example + counter-example or limit + application to new case. | Skill only after Mode 4. |
| `aligned` | Collaborative session (Duo/Group): each participant can give their own explanation (pattern + own example). Does NOT equal `installed (collective)`. | Skill only after Mode 13/14 with own explanations confirmed. |
| `validated` | Passed the full Mode 4 rubric at the `TARGET LEVEL`. | Skill only after Mode 4 at target level. |
| `applicable` | Used in at least one real case outside the session. | User declares it; Skill confirms. |
| `teachable` | The user explained it to another person successfully. | User declares it; Skill confirms. |
| `stale` | Information outdated or no longer relevant. | Anyone. |

**Hard rule**: the Skill never writes `installed`, `validated`, `applicable` or `teachable` without evidence of validation or real use in the current or recent session. If there is no evidence, the state is `ready-for-validation` or lower. In the card, the status line must reflect this honestly.

## Quality rules

- **An example** (EXAMPLE): specific, with names and numbers if helpful. Not generic. If it uses real companies/products as illustration and the user did not load the source, label with `ejemplo ilustrativo` (see `PHILOSOPHY.md` "External reference labeling").
- **In 30 seconds** (30-SECOND PITCH): must contain pattern + mechanism + example. If it is only a definition, rewrite.
- **Where it breaks** (COUNTER-EXAMPLE): a case where the concept does NOT apply or where using it would be a mistake. If none is identified, flag as pending.
- **Related** (RELATIONS): related concepts (similar but distinct), prerequisites, situations where it activates. Any author, book, or framework cited here without a loaded source carries the label `possible anchor` or `possible literary anchor — verify before publication`.
- **The idea** (CENTRAL PATTERN): a single sentence. If it requires two, it is not condensed yet.
- **SOURCE**: if it is "own intuition", mark it literally as such. Do not invent attribution to known authors to add weight.

## To save in the library

See `templates/library-entry.md` — add YAML frontmatter at the top. The stored entry keeps the canonical field names; the card is only the presentation.
