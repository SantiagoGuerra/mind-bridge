# Template — Validation (rubric + report)

Loaded from Mode 4 (validate), Modes 13/14 (bidirectional/multidirectional validation), and any mode that closes with a check.

Consolidates rubric (by level) and report format. A single source of truth for "how good is this understanding and how do I say it back".

## Levels (recap from SKILL.md)

1. **Recognize** — I can identify the concept when I see it.
2. **Explain** — I can describe pattern, problem, and mechanism.
3. **Apply** — I can use it in a new case under guidance.
4. **Implement** — I can build from scratch; I know trade-offs and limits.
5. **Teach / debate** — I can defend it, find counter-examples, connect with neighbors.

## Rubric per level

### Level 1 — Recognize (1–3 / 10)

To pass:

- [ ] Given a case of the concept, identifies it as such.
- [ ] Knows in which domain it appears.
- [ ] Distinguishes obvious positive from obvious negative cases.

Does NOT require: mechanism, own example, knowing limits.

### Level 2 — Explain (4–7 / 10)

Shallow Explain (4–5):

- [ ] Central pattern identified.
- [ ] Mechanism described (even if simplified).
- [ ] Example (may be from the source).

Solid Explain (6–7):

- [ ] Central pattern in one own sentence.
- [ ] Mechanism with concrete steps.
- [ ] Own example (not from the book).
- [ ] Distinguishes from at least one neighbor concept.
- [ ] Knows at least one case where it does NOT apply.

### Level 3 — Apply (8 / 10)

- [ ] Everything in Solid Explain.
- [ ] Applies the concept to a new case under guidance, without being told step-by-step.
- [ ] Identifies when the case enters or leaves the concept's scope.
- [ ] Recognizes the main trade-offs in the applied case.

### Level 4 — Implement (9 / 10)

- [ ] Everything in Apply.
- [ ] Builds a minimal version from scratch (code / process / template / checklist as the domain allows).
- [ ] Knows concrete trade-offs: performance, maintainability, cost, failure modes.
- [ ] Knows limits with precision: when the concept stops applying and what replaces it.
- [ ] Chooses between alternatives with explicit reason.
- [ ] For current technical topics: verifies important claims with websearch before asserting.

### Level 5 — Teach / debate (10 / 10)

- [ ] Everything in Implement.
- [ ] Defends the concept against reasoned objections.
- [ ] Finds own counter-examples.
- [ ] Connects with neighbor concepts and conceptual family.
- [ ] Knows the history / evolution if relevant.
- [ ] Translates to multiple audiences without losing the central pattern.

## Dimensions by level (matrix)

| Dimension | Recognize | Shallow Explain | Solid Explain | Apply | Implement | Teach |
|---|---|---|---|---|---|---|
| Central pattern | — | ✓ | ✓ | ✓ | ✓ | ✓ |
| Mechanism | — | partial | ✓ | ✓ | ✓ (detailed) | ✓ |
| Own example | — | — | ✓ | ✓ | ✓ | ✓ (multiple) |
| Counter-example | — | — | ✓ | ✓ | ✓ | ✓ |
| Limits / where it doesn't apply | — | — | partial | ✓ | ✓ (precise) | ✓ |
| Relations / family | — | — | partial | ✓ | ✓ | ✓ |
| Application to new case | — | — | — | ✓ | ✓ | ✓ |
| Build from scratch | — | — | — | partial | ✓ | ✓ |
| Explicit trade-offs | — | — | — | partial | ✓ | ✓ |
| Decide between alternatives | — | — | — | — | ✓ | ✓ |
| Defense against objections | — | — | — | — | partial | ✓ |
| Multiple audiences | — | — | partial | partial | ✓ | ✓ |

## Canonical probe questions by level

### For Explain

- "Explain in one sentence what pattern this concept captures."
- "Describe the mechanism step by step."
- "Give a different example than the one we saw."
- "Where does it NOT apply?"

### For Apply

- "Here's a new case: [scenario]. Does the concept apply? How would you use it?"
- "If you had to decide between [A] and [B] given the pattern, which would you pick and why?"
- "What main trade-off appears in this case?"

### For Implement

- "Design a minimal version of the concept from scratch — your version, not pseudocode from Wikipedia."
- "What breaks first if you scale 10x?"
- "You know two alternatives: [X] and [Y]. Why this concept and not those?"
- "For [current technical case with APIs/versions], what do you need to verify before asserting [claim]?"

### For Teach

- "[Reasoned objection]. Defend the concept."
- "Give a counter-example that shows the limits."
- "Explain it for [audience A] and [audience B] without losing the pattern."
- "How does it relate to [neighbor concept] and what distinguishes them exactly?"

## State transitions (mini-rubric for package status)

The package's `STATE` field moves through states only with evidence. The Skill **must not** mark a higher state on its own.

| From → To | Requirement | Who can declare |
|---|---|---|
| `packaged` → `ready-for-validation` | The package has been taught interactively (Mode 1 completed). | Skill (automatic at end of Mode 1). |
| `ready-for-validation` → `partially-installed` | User passed 1–3 dimensions of the mini-rubric below. | Skill after partial Mode 4. |
| `partially-installed` / `ready-for-validation` → `installed` | User passed the full **mini-rubric** below. | Skill after Mode 4. |
| `installed` → `validated` | User passed the full **rubric per level** above at the target level. | Skill after Mode 4 at target level. |
| `validated` → `applicable` | User reports using it in at least one real case outside the session. | User declares; Skill confirms. |
| `applicable` → `teachable` | User reports successfully explaining it to another person. | User declares; Skill confirms. |
| Any → `stale` | Info outdated or no longer relevant. | User or Skill, with reason. |

### Mini-rubric for `installed` (the bar for "I have this")

User must demonstrate ALL of:

1. **Own explanation** — paraphrases the pattern in their own words, not echoing the teaching verbatim.
2. **Mechanism** — describes how it works step by step.
3. **Own example** — a case **different** from the one used during teaching (their own context preferred).
4. **Counter-example or limit** — names a case where it does NOT apply, or a condition where it breaks.
5. **Application to a new case** — applies the concept to a scenario they haven't seen before (the Skill provides the scenario).

Passing 3–4 of these = `partially-installed`. Passing all 5 = `installed`. Passing the full per-level rubric at target level = `validated`.

### What this rubric is NOT

- It is not a grade. The score in the report below is a signal, not a judgment.
- It is not optional theater. If the user skips validation, the Skill keeps the package at `ready-for-validation` and says so explicitly.
- It is not a substitute for the per-level rubric. `installed` ≠ `validated`. `validated` requires the per-level rubric at the user's target level.

## Validation evidence states (`estimated` / `partial validation` / `validated`)

The validation report has its **own** state machine, separate from the package's `STATE`. This state reflects **how strong the evidence is for the assessment itself** — not the package's lifecycle.

| Evidence state | When to use | Header label | What appears in the report |
|---|---|---|---|
| `estimated` | The user gave a single short explanation (one paragraph or less), no control questions answered. | `Level estimated from current evidence:` | Score marked `(estimated)`; explicit "To fully validate it:" block with 1–3 probe questions. |
| `partial validation` | Some probe questions answered, but the full battery is incomplete (e.g. user gave explanation + own example, but no counter-example or new-case application). | `Partially validated level:` | Marks `[N of M] dimensions covered`; "To complete the validation:" block with remaining questions. |
| `validated` | Full probe battery answered. At minimum: own explanation + mechanism + own example + counter-example or limit + application to a new case (the mini-rubric below). For `validated` at a target level, the full per-level rubric also passed. | `Validated level:` | Standard report; no probe questions appended. |

**Spanish display of these headers** (when the report is written in Spanish): `Nivel estimado con la evidencia actual` / `Nivel validado parcialmente` / `Nivel validado`.

### Hard rule

> If the only evidence is a single short explanation, **never** use `Validated level` in the header. Use `Level estimated from current evidence`. The word "validated" implies confirmation through active probing; absent that, it's an estimate.

### Why three states (not two)

A single explanation can be revealing — the Skill can often estimate the level reasonably well from it. That estimate is useful and should be reported, but the *language* must signal it's an estimate, not a confirmation. The three-state distinction prevents:

- **Over-claiming**: marking `Validated level: Shallow Explain` after one paragraph (the user reads "validated" and stops engaging with the validation flow).
- **Under-reporting**: refusing to give any assessment until the full battery is done (frustrating; the Skill clearly has signal to share).

### Mapping to package `STATE`

| Validation evidence state | Effect on package `STATE` (in `templates/concept-package.md`) |
|---|---|
| `estimated` | No change. Package stays at `ready-for-validation` (or wherever it was). |
| `partial validation` | Package may move to `partially-installed` if the mini-rubric dimensions covered match. |
| `validated` | Package may move to `installed` (mini-rubric passed) or `validated` (full per-level rubric at target level passed). |

The validation evidence state is **about this report**. The package `STATE` is **about the package over time**. Keep them distinct.

## Report format

```
Current level: [Recognize / Shallow Explain / Solid Explain / Partial Apply / Apply / Implement / Teach]
Score: X/10

What you have:
- [dimension covered]: [brief evidence]
- [dimension covered]: [brief evidence]

What's missing:
- [dimension]: [what exactly]
- [dimension]: [what exactly]

Key distinction:
[one sentence that pinpoints the critical issue — e.g. "you have the pattern but not the mechanism"]

Next step:
[concrete action]
```

## Precision guardrail (technical corrections)

When diagnosing gaps in technical understanding, avoid over-narrow universal claims. If a property is canonical for a common subfamily but not universal, state the scope. Distinguish three layers when relevant:

1. **Pedagogical / canonical definition** — how the concept is usually taught.
2. **Strict domain definition** — what the formal field requires.
3. **Broad practical use** — how the concept is used in adjacent problems.

Don't turn a useful contextual formulation into an absolute universal. Example: for dynamic programming, "optimal substructure" is central for **optimization problems**; more generally, DP requires a well-defined recurrence over reusable / overlapping subproblems (it also appears in counting, decision, probability, and combinatorics where "optimal" doesn't directly apply).

When using a property as a correction criterion, say which subfamily it is canonical for.

## Evaluation rules

- **Recognize what's there before marking what's missing.** Never lead with criticism.
- **Not condescending.** If something's missing, say so.
- **Not too harsh.** If the core is there, acknowledge it.
- **Bad verbalization ≠ bad understanding.** If the answer is messy but the core is there, say so explicitly.
- **Technical vocabulary ≠ understanding.** If only correct words without mechanism or example, flag it.
- **The score is signal, not grade.** It orients the next step.
- **For Implement with current technical claims**: activate Evidence Policy (websearch / DOUBLE-CHECK) before validating as solid.

## Canonical phrases (use literally when they apply)

- "You have the pattern but not the mechanism."
- "You have the mechanism but the limits are missing."
- "The core is there. The problem isn't comprehension; it's serialization."
- "You're using technical vocabulary without demonstrating understanding. Let's try mechanism and example."
- "This sounds memorized. Let's try a new case."
- "You're at Solid Explain. To move to Apply, you need to do X."

## Group validations (Duo / Group) — `aligned` vs `installed`

`installed` is reserved for **individual** validation. It requires one person to pass the full mini-rubric: own explanation + mechanism + own example + counter-example or limit + application to a new case (see "Mini-rubric for `installed`" above).

In Duo (Mode 13) and Group (Mode 14), short 30-second explanations from each participant do **not** make the package `installed`. They make it **aligned**. Use the following state vocabulary in collaborative validation reports:

| Collaborative state | Evidence required | Meaning |
|---|---|---|
| `aligned` | Each participant gave their own 30-second explanation and it contained the central pattern. | The group is talking about the same thing; surface-level shared model. |
| `shared explanation confirmed` | Each participant gave their own explanation AND own example; explanations were not echoing the same source phrasing. | Group can talk about it consistently with own words. |
| `validated at explanation level` | Each participant passed the per-level rubric **at the Explain level** (pattern + mechanism + own example + at least one limit / counter-example). | Stronger; equivalent to individual "Solid Explain" for each member. |
| `installed (collective)` | **Every** participant passes the full mini-rubric individually. Skill must verify per-participant, not infer from group output. | The package is installed in every member's head — not just shared as a label. |

**Rule**: never write `installed` (or `installed in the group`) as a shortcut after a Duo / Group session where only 30-second explanations were collected. The correct default is `aligned` or `shared explanation confirmed`. Upgrade to `installed (collective)` only with per-participant evidence on the mini-rubric.

The package's `STATE` field follows the same logic: it can move to `installed` only when the individual mini-rubric is met. For collaborative sessions, use the `STATE` value `aligned` (a new collaborative-only state) until per-participant mini-rubric evidence is collected.

Default threshold: **all** participants must pass. If the group accepts a lower threshold (e.g. N–1), state it explicitly in the report and never silently relax.

Aggregated report format and per-participant scoring grid: `templates/collaboration-modes.md`.

## Level naming (ASCII canonical, Spanish display)

**Canonical values for frontmatter and machine-readable fields** (ASCII English):

```
recognize | explain | apply | implement | teach
```

**Human display** (Spanish UI, validation reports written for Spanish-speaking users):

```
Reconocer | Explicar | Aplicar | Implementar | Enseñar
```

Refinements used in reports (Spanish):

```
Reconocer / Explicar superficial / Explicar sólido / Aplicar parcial / Aplicar / Implementar / Enseñar
```

Equivalents in English when display in English:

```
Recognize / Shallow Explain / Solid Explain / Partial Apply / Apply / Implement / Teach
```

Report headers in Spanish: `Nivel validado: ... / Tienes: ... / Falta: ... / Distinción clave: ... / Siguiente paso: ...`

Important: in Spanish use `Nivel validado` (never `Nivel actual`) to avoid collapsing taught vs validated. See `templates/concept-package.md` anti-false-mastery rule.
