# Canonical Example — Raw intuition decompression

Gold-standard example of the Skill. Intuition without a name, without structure, that the Skill decompresses into a provisional package. Serves as reference for Mode 7.

## Initial state

The user says:

> "There's something weird about how we define seniority in my team. I feel like people with higher rank make decisions faster, but not necessarily better. And people with lower rank stay quiet about things where they have better information. I don't know exactly what to name it."

Raw intuition. No pattern. No term. Possibly valid but without structure.

## How the Skill decompresses it (Mode 7)

### Question 1 (sharp, not broad)

> "Who is the actor behaving poorly in your mental image? The seniors deciding, the juniors staying quiet, or the system that rewards speed?"

User: "The system. Seniors are doing what the system expects."

→ Flag: **not a people problem, it's a systems problem**.

### Question 2

> "At exactly what moment do you feel the dynamic activates? Group decision, code review, planning, something else?"

User: "In planning and architecture decisions. Not in code review — there's more debate there."

→ Flag: **appears where information is distributed and the decision is fast; doesn't appear where there is an artifact to review**.

### Question 3

> "What does the planning situation have that the code review situation does NOT?"

User: "In code review there's a concrete artifact. In planning there are opinions about the future. The person who speaks with more authority carries more weight."

→ Flag: **voice weight is proportional to rank when there is no external evidence**.

### Hypotheses (flagged)

> "You may be seeing one of these patterns:
> - **Authority bias in ambiguous decisions**: when there is no evidence, rank substitutes for argument.
> - **Inverse information asymmetry**: those with more local information (juniors close to the code) have less voice than those with more global vision.
> - **Velocity over correctness**: the system rewards fast decisions over well-informed ones.
>
> Which one fits best?"

User: "All three are present, but the first one (authority bias) carries the most weight."

### Refine

> "Ok, let's go with authority bias as the core. And what do you think would happen if in an architecture decision a junior had data the senior doesn't have?"

User: "They probably wouldn't speak up unless someone asked. And the senior wouldn't know they need to ask."

→ Flag: **the junior doesn't volunteer, the senior doesn't ask. It's bidirectional**.

## Package (natural step — Mode 2)

> **Information collapse by authority** *(provisional name, standard term still to be found in the literature)*
>
> **The idea:** when a decision is ambiguous and there's no external evidence, rank takes the place of argument, and the local knowledge of the lower-ranked person is quietly lost.
>
> **The problem it solves:** in decisions where information is spread out (juniors with local knowledge, seniors with the wide view), the group collapses toward the most authoritative voice. The junior doesn't volunteer. The senior doesn't ask. Nobody notices the loss, because there's no visible artifact.
>
> **How it works:** the decision is ambiguous, with no clear evidence. The setting rewards speed. The most authoritative voice fills the gap. Voices with local information hold back by default. The decision gets made without the distributed knowledge, and no record remains of what was lost.
>
> **An example:** in architecture planning, a module migration is proposed. The senior decides in ten minutes on a general read. A junior worked in that module last month and knows it hides a critical dependency. They stay quiet, because "the senior already decided" and they don't want to seem like they're pushing back. Three weeks later, the migration uncovers the problem.
>
> **Where it breaks:** it doesn't apply in code review (there's an artifact). It doesn't apply when the data is shared before deciding. And it doesn't apply where explicit challenge is built in, like reviews with a formal red team.
>
> **Related:** authority bias from social psychology (the family it belongs to), information cascades (one voice silencing the next), the HiPPO effect or highest-paid-person's-opinion (a workplace special case), and psychological safety (the condition that breaks the pattern). *These are possible anchors, verify before publication.*
>
> **When to use it:** design decisions where information is spread out. The countermoves: ask for evidence, slow the decision down, have the junior speak first, and separate opinions from information.
>
> **In 30 seconds:** "When a decision is ambiguous and there's no clear evidence, rank weighs more than argument. The authoritative voice fills the gap, the people with local knowledge stay quiet, and the decision gets made without the best information. Nobody sees the loss, because no artifact is left behind."
>
> *Packaged from a decompressed intuition, not formally taught yet, so nothing is validated. Target level: explain. It still needs checking against the literature (Cialdini on authority bias, Edmondson on psychological safety) before it can move past `ready-for-validation` to `installed` or `validated`.*

Behind the card, the stored entry keeps: `TARGET LEVEL: explain · TAUGHT LEVEL: pending · VALIDATED LEVEL: pending · STATE: packaged`. Anchor words: authority bias, information cascade, HiPPO effect, psychological safety, distributed information. State path from here: `packaged` → `ready-for-validation` (after Mode 1) → `installed` (only after Mode 4) → `validated`.

## Flags during decompression

- **Intuition to refine**: ✓ the core is valid, vocabulary was missing.
- **Not necessarily wrong**: the pattern holds up under initial sparring.
- **Misnamed initially**: the user said "seniority", but the real pattern is authority bias + information asymmetry.
- **State**: draft. To raise to "validated", it needs to be checked against known literature (Cialdini on authority bias, Edmondson on psychological safety).

## Natural next step

- Mode 8 (glossary) → find the exact standard name (likely: variation of "information cascade" or "authority bias in epistemic decisions").
- Mode 5 (expand) → open branch "design of distributed decisions" if the user wants to apply.
- Mode 9 (library) → save with status `packaged` or `ready-for-validation`, not `installed`.

## Observation on the dynamic

5 initial questions. Hypotheses flagged as hypotheses (not assertions). When the user chose a hypothesis, the flow kept sharpening it without pushing. The name stayed provisional — no terminology was invented to sound erudite.

## Templates

- `templates/concept-package.md`
- `templates/validation.md`
- `modes/decompress.md` (canonical Mode 7 flow)
