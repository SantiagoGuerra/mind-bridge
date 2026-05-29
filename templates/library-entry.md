# Template — Library entry

Loaded from Mode 9. For `.md` files in `~/Documents/mind-bridge-library/` (or the location the user has confirmed).

## Frontmatter

```yaml
---
title: [Concept name]
domain: [distributed-systems / product / business / ai-ml / architecture / psychology / etc.]
status: raw | packaged | ready-for-validation | partially-installed | installed | validated | aligned | applicable | teachable | stale
target_level: recognize | explain | apply | implement | teach
validated_level: pending | recognize | explain | apply | implement | teach
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags: [tag1, tag2, tag3]
related:
  - another-concept.md
  - third-concept.md
confidence: low | medium | high
source: [optional — paper / conversation / etc.]
---
```

**ASCII values are canonical for frontmatter** (machine-readable, no accents, hyphenated where there are spaces). Human display in body / reports may use Spanish: `Reconocer / Explicar / Aplicar / Implementar / Enseñar`, `Pendiente`, `baja/media/alta`. Mapping is direct and stable. This avoids YAML-parser issues across tools and aligns with skill conventions.

**This frontmatter schema is canonical.** No other file (including `modes/library.md`) should define a different schema. If you find a discrepancy, the rule is: this file wins; update the other.

## Body

Below the frontmatter, use the long version from `templates/concept-package.md`.

## File naming convention

- kebab-case.
- `fencing-tokens.md`, not `FencingTokens.md` nor `fencing_tokens.md`.
- If there are homonyms, add context: `fencing-tokens-distributed.md`.
- Do not use dates in the name (they go in the frontmatter).

## Maturity states (canonical state machine)

See `templates/concept-package.md` for individual transition rules and `templates/validation.md` "Group validations" for collaborative rules.

**Individual states**:

- **raw**: unstructured intuition.
- **packaged**: complete package with all critical fields, without interactive teaching yet.
- **ready-for-validation**: interactively taught, waiting for the user to answer validation questions.
- **partially-installed**: the user passed 1–3 dimensions of the mini-rubric.
- **installed**: the user passed the **full** individual mini-rubric (own explanation + mechanism + own example + counter-example or limit + application to new case).
- **validated**: passed the full Mode 4 rubric at the `target_level`.
- **applicable**: used in at least one real case outside the session.
- **teachable**: explained to another person successfully.
- **stale**: information outdated or no longer relevant.

**Collaborative state** (Duo / Group sessions):

- **aligned**: each participant explained the package in their own words (pattern + mechanism + own example). Default after a normal Duo/Group session with 30-second checks. **Is not `installed`**. To move to `installed (collective)`, each participant must pass the full mini-rubric individually.

**Anti-false-mastery rule**: the Skill never writes `installed`, `validated`, `applicable` or `teachable` without evidence of validation or real use. Default after individual teaching: `ready-for-validation`. Default after collaborative session: `aligned`. Detail in `templates/concept-package.md` and `templates/validation.md`.

## Minimal example

```markdown
---
title: Fencing tokens
domain: distributed-systems
status: validated
target_level: explain
validated_level: explain
created: 2026-05-11
updated: 2026-05-11
tags: [concurrency, locks, stale-writes]
related:
  - distributed-locks.md
  - idempotency.md
confidence: high
source: Designing Data-Intensive Applications, cap. 8
---

CONCEPT: Fencing tokens

CENTRAL PATTERN:
A stale actor can act late and cause damage.

PROBLEM:
...
```

## Before writing

Always confirm with the user the full path and show the proposed content before creating the file. If the parent directory does not exist, ask for additional confirmation before creating it.
