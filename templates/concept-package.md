# Template — Concept package

Loaded from Mode 2 (package), Mode 1 step 7, Mode 4 (reference), Mode 10 (ingest output).

## Short version

```
CONCEPT:
CENTRAL PATTERN:
MECHANISM:
USE:
```

3 fields. For Slack, quick recall, mental sticky note.

## Long version

```
CONCEPT:

CENTRAL PATTERN:

PROBLEM:

MECHANISM:

EXAMPLE:

COUNTER-EXAMPLE:

RELATIONS:

USE:

30-SECOND PITCH:
```

Critical fields: CONCEPT, CENTRAL PATTERN, PROBLEM, MECHANISM, EXAMPLE, USE.
If a critical field is missing, flag it and propose how to complete it. Do not reject bluntly.

## Optional fields

Add only if they contribute:

```
TARGET LEVEL:           recognize | explain | apply | implement | teach
TAUGHT LEVEL:           recognize | explain | apply | implement | teach
VALIDATED LEVEL:        pending | recognize | explain | apply | implement | teach
CONFIDENCE:             low | medium | high
SOURCE:                 [paper / conversation / own intuition / etc.]
ANCHOR WORDS:           [terms that open the search]
NEXT BRANCH:            [what to deepen later if needed]
SIMPLIFICATIONS:        [useful simplifications + nuances left as a compressed branch]
STATE:                  raw | packaged | ready-for-validation | partially-installed | installed | validated | aligned | applicable | teachable | stale
```

**ASCII canonical for machine-readable fields**. Display can be translated to Spanish in the human-facing output (Reconocer / Explicar / etc.) but the package's stored values are ASCII. See `templates/library-entry.md` for canonical schema.

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

**Hard rule**: the Skill never writes `installed`, `validated`, `applicable` or `teachable` without evidence of validation or real use in the current or recent session. If there is no evidence, the state is `ready-for-validation` or lower.

## Quality rules

- **EXAMPLE**: specific, with names and numbers if helpful. Not generic. If it uses real companies/products as illustration and the user did not load the source, label with `ejemplo ilustrativo` (see `PHILOSOPHY.md` "External reference labeling").
- **30-SECOND PITCH**: must contain pattern + mechanism + example. If it is only a definition, rewrite.
- **COUNTER-EXAMPLE**: a case where the concept does NOT apply or where using it would be a mistake. If none is identified, flag as pending.
- **RELATIONS**: related concepts (similar but distinct), prerequisites, situations where it activates. Any author, book, or framework cited here without a loaded source carries the label `possible anchor` or `possible literary anchor — verify before publication`.
- **CENTRAL PATTERN**: a single sentence. If it requires two, it is not condensed yet.
- **SOURCE**: if it is "own intuition", mark it literally as such. Do not invent attribution to known authors to add weight.

## To save in the library

See `templates/library-entry.md` — add YAML frontmatter at the top.
