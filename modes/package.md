# Mode 2 — Package concept

Activation: "package this", "turn it into a concept package", "save this concept" — ES: "empaqueta esto", "conviértelo en paquete conceptual", "guarda este concepto".

## When to use this mode

- When the user already understood a concept and wants to turn it into a reusable package.
- When Mode 1 ends and they want to consolidate.
- When they are going to save to the library (Mode 9 will invoke this).

## Calibration

Apply global calibration from SKILL.md. Specific to packaging:

If the concept comes raw or ambiguous, ask about the **package goal**:

- **internal use** (personal recall): short version + 30 seconds.
- **meeting**: emphasize 30-SECOND PITCH + EXAMPLE. Activate Communication modifier.
- **product / decision**: emphasize RELATIONS + USE + COUNTER-EXAMPLE. Activate Product modifier.
- **implementation**: emphasize detailed MECHANISM + NEXT BRANCH + technical COUNTER-EXAMPLE. Activate Implementation modifier + double-check if there are claims.
- **library**: full long package + frontmatter (see `templates/library-entry.md`).

The package goal changes which fields to emphasize.

## Template

Load `templates/concept-package.md`.

## Critical fields (required)

If one is missing, mark it and propose how to complete it. Do not reject bluntly.

- **CONCEPT**: name of the concept (can be provisional).
- **CENTRAL PATTERN**: the deep, reusable idea, in one sentence.
- **PROBLEM**: what fails when the concept does not exist.
- **MECHANISM**: how it works, step by step.
- **EXAMPLE**: concrete case, mentally executable, with names and numbers if they help.
- **USE**: when to apply it, where it appears in practice.

## Optional fields (if they add value)

- **COUNTER-EXAMPLE**: case where the concept does NOT apply or would be a mistake to use.
- **RELATIONS**: close concepts, prerequisites, situations where it activates.
- **30-SECOND PITCH**: linear pitch ready to use.
- **TARGET LEVEL**: recognize / explain / apply / implement / teach (from the intake).
- **TAUGHT LEVEL**: the level at which it was taught.
- **VALIDATED LEVEL**: `pending` by default (display: `Pending`); only rises after Mode 4.
- **CONFIDENCE**: low / medium / high.
- **SOURCE**: origin (paper, conversation, own intuition).
- **ANCHOR WORDS**: terms that open the search.
- **NEXT BRANCH**: what to go deeper on later if needed.
- **SIMPLIFICATIONS**: useful simplifications + nuances left as a compressed branch (see `modes/learn.md` section "Technical simplifications").
- **STATE**: raw / packaged / ready-for-validation / partially-installed / installed / validated / aligned / applicable / teachable / stale.

**Anti-false-mastery rule**: never mark `installed`, `validated`, `applicable`, or `teachable` without evidence. Default after packaging interactively: `ready-for-validation`. Detail in `templates/concept-package.md`. If an old template uses `CURRENT LEVEL`, translate to the three new fields.

## Versions

- **Short version** (3 fields): CENTRAL PATTERN + MECHANISM + USE. For Slack, fast recall.
- **Long version**: critical fields + relevant optional fields.

**Default (non-negotiable unless the user asks explicitly):** emit **only the short version**, and at the close ask `Should I expand to the long version?`. Do not emit both in the same message. Exception: if the user's trigger explicitly names "long version", "for library", "full package", or a goal that requires it (implementation / decision / library), skip the short and produce the long directly.

## If a critical field is missing

Say what is missing and propose how to complete it:

- Without **MECHANISM**: "How does it work step by step? If it's not clear, we can open that branch (Mode 5)."
- Without **EXAMPLE**: "In what concrete situation did you see it or would you see it?"
- Without **USE**: "Where would you apply it tomorrow?"
- Without **CENTRAL PATTERN**: "We don't have the pattern yet. Let's go back to Mode 1 step 3 or to Mode 7."

## Final verification

Before closing:

- Does the 30-SECOND PITCH contain pattern + mechanism + example? If it is only a definition, rewrite it.
- Is the EXAMPLE specific (names, numbers) or generic? If generic, ask for a concrete one.
- Does the COUNTER-EXAMPLE exist and distinguish well?

## Mode output

- If the user wants to save → chain Mode 9 (library) with explicit confirmation.
- If they want other audiences → Mode 3 (serialize).
- If they want to validate → Mode 4.

## Gold-standard reference

`examples/fencing-tokens.md` shows a well-built long package.
