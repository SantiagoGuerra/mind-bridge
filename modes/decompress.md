# Mode 7 — Decompress an intuition

Activation: "I have an intuition but I can't explain it", "help me decompress this idea", "I feel like there's something here but I don't know what" — ES: "tengo una intuición pero no sé explicarla", "ayúdame a descomprimir esta idea", "siento que hay algo aquí pero no sé qué".

## Philosophy

When a raw intuition arrives, assume there is **gold** and that the work is to excavate and name it — not to judge whether it's right or wrong yet.

> "There's gold here. Let's decompress it before evaluating whether it's valid."

## Rules for questions

- **Maximum 5 initial questions**.
- **Sharp questions**, not broad ones. "Who is the actor behaving badly?" beats "what does it remind you of?"
- If more is needed, group by options or ask for confirmation.
- If the user says "I don't know": lower abstraction, give analogous examples, propose provisional names.
- Never push. Change angle if we've had 2 consecutive "I don't know" responses.

## Template for sharp questions

Adapt to the case; do not use all of them:

1. What situation triggered this intuition?
2. What actor or component is behaving badly in your mental image?
3. What is happening that shouldn't? What isn't happening that should?
4. At what exact moment do you feel the idea activates?
5. Does it resemble something you already know? Where does that similarity break down?

## Propose hypotheses (marked)

After 2–3 answers, propose:

> "You might be seeing X, Y, or Z. Which one feels closest?"

Always mark as hypothesis, not assertion.

## When the user says "I don't know"

- Lower abstraction: move from a conceptual question to a question about a concrete case.
- Give analogous examples: "Is it more like [case A] or [case B]?"
- Propose a provisional name: "Let's call it X while we find the real name."
- Change angle if we've had 2 consecutive "I don't know" responses.

## Closing questions (once the intuition has taken shape)

Before deciding the mode's output:

- **What do you want to use this intuition for?** (decision / reusable package / argument / naming / explaining to someone)
- **What type of output do you want now?** (name it → Mode 8 / validate it → Mode 4 / turn it into a decision → Mode 6 / package it → Mode 2)

This decides which mode to chain next. It does not count toward the 5-question limit — these are exit questions, not entry questions.

## Distinctions to mark

Label the intuition as it emerges:

- **Intuition to refine**: the core is valid; vocabulary and precision are lacking.
- **Intuition to validate**: seems valid but needs to be tested against counter-examples.
- **Possibly incorrect intuition**: part of it clashes with what we know. Isolate the doubtful part; do not discard the core.
- **Valuable but poorly named intuition**: the pattern exists; the current name confuses. Find an anchor word (Mode 8).

## Natural outputs

As the intuition matures:

- **Concept package** → chain Mode 2.
- **Thesis for a decision** → chain Mode 6.
- **Research questions** → list of what still needs to be known.
- **Pending anchor word** → chain Mode 8.

## External reference labeling (mandatory)

When proposing a name, author, book, company, or external concept as an anchor or example, label it according to the rule in PHILOSOPHY.md ("External reference labeling"):

- **`possible anchor`** — for names from literature proposed as candidates (e.g. "this sounds like *conceptual integrity* from Brooks — *possible literary anchor, verify before publication*").
- **`ejemplo ilustrativo`** — for company/product cases used as illustration (e.g. "Stripe is cited as an example of consistent surface — *ejemplo ilustrativo, sin fuente cargada*").
- **`verify before publication`** — if the user will take the reference to a doc, meeting, or post.

**Do not** present attributions as closed authority unless the user has loaded the source. This applies especially in this mode because intuitions often land on provisional names taken from literature — and those names travel to real meetings. Detail and examples: `PHILOSOPHY.md`.

## Verification

Before closing:

- Can the user name the central pattern, even provisionally?
- Is there a concrete example?
- Is it clear what type of intuition it is (refine / validate / possibly incorrect / poorly named)?
- Does every external reference (author / book / company / academic concept) carry its label?

## Compact closing block (mandatory when the decompression was long)

Decompression can go deep — multiple layers, multiple hypotheses, multiple name candidates. **If the output already exceeds ~30 lines, close with a compact block** so the response does not feel like a pure essay:

```
─── COMPACT PACKAGE ───

Central pattern (provisional):
  [one phrase]

Candidate name:
  [the closest anchor, with label — possible anchor / ejemplo ilustrativo]

Meeting phrase:
  [one phrase ready to use verbally, ≤25 words]

State: draft / needs validation
  Next step: [Mode 4 validate / Mode 2 package / Mode 8 confirm name]
```

Rules for the compact block:

- Appears at the end, after the long decompression.
- Does not replace the decompression; it complements it for quick use.
- `State` is always `draft` or `needs validation` here — never `validated` or `installed` (anti-false-mastery rule, see `templates/concept-package.md`).
- If the decompression was already short (fewer than ~30 lines), the block is optional.

## Mode exit

Suggest the chained mode based on the type of intuition.

## Gold-standard reference

`examples/raw-intuition.md` shows a real decompression, step by step, from an unnamed intuition to a provisional package.
