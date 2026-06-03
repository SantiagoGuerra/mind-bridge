# Template — Collaborative modes (Duo / Group)

Loaded from Mode 13 (Duo) and Mode 14 (Group). Concentrates turn protocols, role cards, anti-dominance, and session format.

## Principles

1. **Silent intake before discussing.** Without this, the fastest or most senior voice defines the package; distributed information is lost.
2. **Simultaneous reveal.** No version is shown until all are written. If one person sees another first, anchoring.
3. **Visible comparison.** Differences are placed side by side before "merging". Merging without a diff hides the delta.
4. **Field-level provenance.** Each block of the final package carries a trace: who contributed it? Is it an agreement? Did it emerge in discussion?
5. **Bidirectional or multidirectional validation.** Each participant explains the final package in their own words. If only one can, it is not installed in the rest.
6. **Active skeptic.** Without an explicit role or turn for attacking the package, it comes out too clean and collapses in real use.

## Role cards (Group)

Detail in `modes/group.md`. Here are the cards ready to paste into a session.

### Concept Owner

```
ROLE: Concept Owner
Your job:
- Contribute the first draft in silent intake.
- Clarify factual questions about the context that motivated the topic.
- Do NOT define the whole package; once you have given context, leave space.
Risk to watch:
- Becoming the sole definer. If your visible contributions exceed 40% of the total, the Skill interrupts you.
```

### Mechanism Builder

```
ROLE: Mechanism Builder
Your job:
- Push for "how does it actually work?".
- Detect when there is a pattern but no concrete mechanism.
- Ensure the MECHANISM field does not stay vague.
Canonical question:
- "Wait, what exactly happens in step 2?"
```

### Example Maker

```
ROLE: Example Maker
Your job:
- Contribute concrete cases from the group's context.
- Detect textbook examples and replace them with specific ones.
- Ensure the EXAMPLE field is not generic.
Canonical question:
- "Where have we seen this happen in our own system/product?"
```

### Skeptic / Boundary Finder

```
ROLE: Skeptic
Your job:
- Attack the package.
- Look for counter-examples, conditions where it breaks, neighboring concepts that get confused with it.
- Ensure the COUNTER-EXAMPLE and "WHERE IT DOES NOT APPLY" fields are filled.
Canonical questions:
- "When does this mechanism stop working?"
- "What neighboring concept do people confuse with this one?"
- "What happens if I apply it in reverse?"
Warning:
- Without someone in this role, the package comes out clean but fragile.
```

### Serializer (optional)

```
ROLE: Serializer
Your job:
- Take the final package and produce versions by audience (developer, PM, CEO, Slack, etc.).
- Detect when an audience-specific version has lost the central pattern.
Useful if:
- The group will communicate the result externally.
- There are >4 participants (frees the rest for building).
```

## Silent intake protocol

### Async

```
INSTRUCTION TO EACH PARTICIPANT (via private channel or personal doc):

Without looking at the others, write:
1. CENTRAL PATTERN in one sentence.
2. MECHANISM in 3–5 steps.
3. ONE concrete own EXAMPLE (with names / numbers if helpful).
4. A question or doubt you have about the topic.

When finished, paste your version here: [shared channel].
Do NOT read the others until everyone has pasted.
```

### Synchronous (call or in-person)

```
TIMER: 7 minutes.

Everyone writes in a private doc or sticky note:
- Central pattern (1 sentence)
- Mechanism (3–5 steps)
- Own example
- Question or doubt

When the timer sounds, everyone shares at the same time. Not before.
```

## Comparison format (Skill output after intake)

```
COMPARISON — N versions:

CENTRAL PATTERN:
  [person 1]: ...
  [person 2]: ...
  [person N]: ...
  Agreements:
  Differences:
  Absences:

MECHANISM:
  (same format)

EXAMPLE:
  (same format + domains covered vs missing)

QUESTIONS RAISED:
  - [from person 1]
  - [from person 2]
  - ...

SKILL HYPOTHESIS:
  - Factual differences (verifiable now): [list]
  - Interpretive differences (require discussion): [list]
```

## Anti-dominance tracking

The Skill maintains a visible counter at the end of each major block:

```
TURNS — DISTRIBUTION SO FAR:
  [person 1]: N substantive inputs (X%)
  [person 2]: M substantive inputs (Y%)
  ...

Asymmetry detected: [none / person X dominates / role Y underused].
Proposed adjustment: [next question directed at whom and why].
```

Default threshold (based on visible contributions, not airtime): if one person exceeds 40% of total visible, the Skill proposes redirecting.

Adjustment by group size: 40% in groups of 3, 35% in groups of 4, or 30% in groups of 5.

## Canonical interruptions

To use when an anti-pattern is detected:

- **Agreeing without paraphrasing**: "Before accepting, can you paraphrase what [X] said in your own words?"
- **Role not contributing**: "[Role], this is your turn and I haven't heard from you yet. What do you see from your side?"
- **Concept Owner dominating**: "[Owner], thanks for the context. I'm going to ask [Skeptic / Example Maker] for input before continuing."
- **Open discussion before silent intake**: "So the distributed information isn't lost, let's do silent intake first. Then we compare."
- **Skeptic round skipped**: "Before closing, the Skeptic attacks: where does this package break?"

## Package template with provenance

Extension of `templates/concept-package.md` for collaborative outputs:

**[Concept]** (collaborative)

**The idea:** [final version] *(provenance: unanimous agreement / proposed by X / decided by majority with dissent from Y / emerged in discussion)*

**The problem it solves:** [...] *(provenance)*

**How it works:**
- step 1 [...] *(provenance)*
- step 2 [...] *(provenance)*
- ...

**An example:** [...] *(provenance: contributed by the Example Maker, chosen for fitting the group's context)*

**More examples** (only if they cover distinct relevant domains): [...]

**Where it breaks:** [...] *(provenance: from the Skeptic round)*. And where it doesn't apply at all: [...] *(provenance)*

**When to use it:** [...] *(group agreement)*

**In 30 seconds:** [final version]

*Declared weaknesses: a Skeptic attack the group could not answer with confidence.*

*Pending decisions: differences that need a source check, or a decision the group couldn't close, with owner and date if applicable.*

## Bidirectional (Duo) / multidirectional (Group) validation — alignment, not installation

Each participant, **separately and without seeing the others**, writes their 30-second version of the merged package.

### Aggregated report per participant

```
COLLABORATIVE VALIDATION:

Per-participant evidence:
  [person 1]: pattern ✓ / mechanism ✓ / own example ✓ / counter-example ✗ / new-case ✗  → aligned
  [person 2]: pattern ✓ / mechanism ✗ / own example ✓ / counter-example ✗ / new-case ✗  → not aligned yet
  [person 3]: pattern ✓ / mechanism ✓ / own example ✓ / counter-example ✓ / new-case ✓  → mini-rubric passed

Collaborative state:
  → aligned                          (≥ pattern + own example per participant, no full mini-rubric)
  → shared explanation confirmed     (own explanation + own example, distinct from teaching phrasing)
  → validated at explanation level   (per-level rubric at Explain passed per participant)
  → installed (collective)           (mini-rubric passed by EVERY participant individually)

Distribution: [N of M with each state].

For those who haven't reached aligned yet, what's missing:
  [person 2]: mechanism confused with that of [neighboring concept].
```

### Hard rule (anti-false-collaborative-mastery)

- **30-second explanations from each participant ≠ `installed`.** Default after a Duo/Group session with only 30-second checks: `aligned`.
- **Never write `installed (collective)`** without per-participant evidence on the full mini-rubric (own explanation + mechanism + own example + counter-example or limit + application to new case). See `templates/validation.md` "Group validations — aligned vs installed".
- If someone fails, micro-iteration only on the field that failed. Do not declare the next state until the agreed threshold (default: everyone) passes the required evidence for that state.

The package's `STATE` field can hold `aligned` during a collaborative session and move toward `installed (collective)` only when the evidence is per-participant. See `templates/concept-package.md` state machine for valid transitions.

## Operative rules for the Skill as facilitator

- **Do not take sides** in a legitimate difference between participants. Mark the difference; do not resolve it with authority.
- **Do not introduce new unsolicited information** during the session — with the following explicit exceptions:
  1. The group asks for teaching ("can you explain X to us?").
  2. There is a source loaded by the group and the information comes from it (with citation).
  3. There is a factual dispute and the group approves external verification (websearch + DOUBLE-CHECK).
  4. The current session phase is **teaching / installation** (not facilitation/discovery).
  In any other case, information comes from the participants and from sources they share.
- **Mark when the Skill is proposing hypotheses vs when it is reflecting what was said**.
- **If websearch is needed** (disputed factual claim), ask the group's permission and declare the verification with a DOUBLE-CHECK block.
- **Do not declare premature consensus**. If there is silence or head nods, ask for paraphrase.
- **If the group is tired or scattered**, pause and schedule a continuation. Better 2 clean sessions than 1 dragged session.

## Session closing states

- **Closed clean**: merged package + N of N validated + 0 declared weaknesses + 0 pending decisions.
- **Closed with open items**: merged package + N of N validated + some declared weaknesses + pending decisions with owner and date.
- **Partial**: merged package but <N of N validated. Schedule micro-session with those who remain.
- **Aborted**: the session revealed that the group was talking about different things or that there is interpersonal conflict. Mark it, route to Mode 8 (glossary) or to human facilitation.
