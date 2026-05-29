# Mode 1 — Learn new concept

Activation: "teach me X", "install this concept", "explain X to me at an advanced level", "I want to learn X" — ES: "enséñame X", "instala este concepto", "explícame X de forma avanzada", "quiero aprender X".

## Calibration

Apply the global calibration from SKILL.md before starting:

- **If X is simple and bounded** (e.g. "what is a hash map"): Fast modifier, use defaults, don't ask.
- **If X is broad or advanced** (e.g. "teach me Kubernetes", "distributed systems"): brief blocking intake or offer "use defaults" — maximum 5 initial questions.
- **If the user says "to apply it to my product"**: activate Product modifier before the flow. Ask for product context.
- **If the user says "to implement it"**: activate Implementation modifier. Ask for technical constraints + activate double-check if there are specific technical claims.
- Inherit from global calibration: goal, level, application context, success criterion, desired output.
- If calibration delivered "success criterion = being able to explain it in 30s", prioritize steps 3, 4, 7 (short), 9 of the 11-step flow.

## Defaults

- Default target level: **Explain**. If the user asks to implement or teach, adjust.
- Fast mode by default: essential steps without long initial questions.
- If the topic is ambiguous or very broad: a single question to narrow it down.

## 11-step flow (scaffolding, not a rigid checklist)

Use the steps the concept needs. Skip the ones already covered by context. If the user asks for speed, compress.

### 1. Orient

One question: "What do you need it for and at what level (recognize / explain / apply / implement / teach)?" If clear from context, skip it.

### 2. Decompress

Before defining formally, open the concept. Choose 1–3 questions that open the concept best for this specific topic:

- What problem existed before?
- What pain or failure does it try to solve?
- Who are the actors?
- What happens step by step without the concept?
- What changes when it appears?
- What is the idea that makes it work?

### 3. Capture the central pattern

Propose the deep, reusable pattern. One sentence. Example:

> "The central pattern of fencing tokens: an old actor can act late and cause damage."

Verify with the user: "Does this resonate? Should we adjust it?"

### 4. Build a minimal example

Concrete scenario, mentally executable:

- Initial state
- Something fails
- The risk appears
- The concept enters
- Result

Specific, not generic. Concrete names. Numbers if they help.

### 5. Create an analogy with limits

Structurally correct analogy. Preferably from the everyday or physical world if it works.

Always mark the limit:

> "The analogy breaks when [X]."

### 6. Detect limits

- When it applies
- When it does NOT apply
- What problem it does not solve
- What happens if it is misused

### 7. Package

Load `templates/concept-package.md` and fill in the critical fields: CONCEPT, CENTRAL PATTERN, PROBLEM, MECHANISM, EXAMPLE, USE. Short version first. Long version if the user wants it.

**Mandatory rules for level and state fields** (anti-false-mastery):

- `TARGET LEVEL`: the level from the intake.
- `TAUGHT LEVEL`: the level at which it was taught (typically = target).
- `VALIDATED LEVEL`: **always `pending`** (display: `Pending`) in the initial output. Only rises after Mode 4.
- `STATE`: **always `ready-for-validation`** after teaching. Never `installed`, `validated`, `applicable`, or `teachable` at this step.

State this explicitly to the user when closing the package: _"I'm marking this as `ready-for-validation`. To move to `installed`, you need to pass the mini-rubric — Mode 4."_

If the user reuses an old template with `CURRENT LEVEL`, translate to the three new fields before continuing.

### 8. Connect

- Close concepts (similar but distinct)
- Prerequisites
- Situations where it activates
- Anchor words

### 9. Serialize

Produce a 30-second explanation following the rules in `modes/serialize.md` (load only if audience detail is needed).

### 10. Validate

Chain with `modes/validate.md`, or do a short inline validation:

> "Control question: give me a different example from the one we saw, without thinking too hard."

### 11. Expand only if needed

List possible branches:

> "These are branches that can be opened: A, B, C. For your goal (Explain) I recommend leaving them compressed. If we move to Implement, we open A."

## Flow decisions

- **If the concept is simple**: compress steps 1, 2, 5, 8 — go directly to pattern → example → use.
- **If the user says "fast"**: only steps 3, 4, 7 (short), 9 (30 seconds).
- **If the user already has part of the topic**: start at the step where they have the gap.
- **If the concept is very abstract**: extend step 4 (example) and step 5 (analogy).
- **If the concept is very operational**: extend step 6 (limits) and step 10 (validation with a new case).

## Optional markers

Use step markers only if they help the user visually. Examples in plain text:

- "Central pattern →"
- "Minimal example:"
- "Where the analogy breaks:"

Do not use decorative emojis. Do not use 🎯/📦/🔧 unless the user is already using them first.

## Anti-false-mastery rule (critical)

After teaching a new concept, **the Skill does not declare knowledge installed**. Installation is validated with the user, not by fiat of the Skill.

Always distinguish three levels:

- **TARGET LEVEL**: what the user asked to reach.
- **TAUGHT LEVEL**: the level at which it was taught (typically coincides with target).
- **VALIDATED LEVEL**: what the user has demonstrated. **Always starts at `pending`** (display: `Pending`) after teaching.

What the Skill cannot write after teaching (without Mode 4 intervening):

- ❌ `CURRENT LEVEL: Solid Explain` (field deprecated for collapsing the three dimensions).
- ❌ `STATE: installed`
- ❌ `STATE: validated`
- ❌ "You have this concept."
- ❌ "This is installed."

What the Skill does write after teaching:

- ✓ `TARGET LEVEL: explain`
- ✓ `TAUGHT LEVEL: explain`
- ✓ `VALIDATED LEVEL: pending`
- ✓ `CONFIDENCE: high` (separate from the level; the level is the closed enum)
- ✓ `STATE: ready-for-validation`
- ✓ "I'm marking this as `ready-for-validation`. To move to `installed`, you need to pass the mini-rubric — Mode 4."

If the user says "I already have it" or "no need to validate", accept it but **do not change the state**. The state reflects evidence, not self-perception. Mini-rubric in `templates/validation.md`.

## Technical simplifications (honesty caveat)

When teaching a technical concept at a target level simpler than the real one, the Skill simplifies — but **must declare the simplification** and leave the nuance as a compressed branch. Never present a simplification as the complete truth.

Canonical pattern:

```
[Explanation at the user's target level]

MARKED SIMPLIFICATION:
  What was taught: [useful version at the target level].
  The full nuance: [what was omitted and why].
  When it matters: [scenario where the nuance cannot be ignored].
  Compressed branch: [reference to open when needed].
```

Example (Raft, Explain level):

```
CENTRAL PATTERN:
Raft elects a leader, replicates the log to a majority, and considers it committed when the majority confirmed.

MARKED SIMPLIFICATION:
  What was taught: "replication to majority implies commit".
  The full nuance: for entries from earlier terms, the leader cannot declare commit
    just by having replicated them to a majority — it must wait to commit an entry from its
    own term (case in the original paper, Figure 8). If ignored, there is a risk of losing
    committed entries.
  When it matters: implementing real Raft, debugging entry loss, or discussing
    correctness with a paper author.
  Compressed branch: "Leader Completeness Property and entries from earlier terms"
    — open if moving to Implement level.
```

Rule for when to apply:

- **Always** when the target level is Explain but the concept has known nuances at the Implement level.
- **Always** when the simplification would lead to a wrong decision in production if believed complete.
- **Optional** when the nuance is academic and does not affect real use at the target level (mentioning it in NEXT BRANCH is enough).

## Mode output

When finished:

1. Brief summary: "You have the pattern, mechanism, and a taught example. State: `ready-for-validation`. Natural next step: validate with Mode 4, or serialize for [audience]."
2. **Show fields**: `TARGET LEVEL`, `TAUGHT LEVEL`, `VALIDATED LEVEL: pending`, `STATE: ready-for-validation`.
3. Suggest chaining Mode 4 (validate) or Mode 3 (serialize).
4. If the user wants to save: chain Mode 9 (library) with confirmation, **with state `ready-for-validation`**, not `installed`.

## Gold-standard reference

`examples/fencing-tokens.md` shows the expected output for a technical concept.
`examples/invisible-product-debt.md` shows the output for a product/business concept without a consolidated standard name.
