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

```
CONCEPT: Information collapse by authority (provisional name — search for standard term in literature)

CENTRAL PATTERN:
When the decision is ambiguous and there is no external evidence, rank substitutes for argument — and the local information of the lower rank is silently lost.

PROBLEM:
In decisions where information is distributed (juniors with local knowledge, seniors with global vision), the system collapses toward the most authoritative voice. The junior doesn't volunteer. The senior doesn't ask. Nobody notices the loss because there is no visible artifact.

MECHANISM:
1. The decision is ambiguous (no clear evidence).
2. The system rewards speed.
3. The most authoritative voice fills the vacuum.
4. Voices with local information are inhibited by default.
5. The decision is made without the distributed information.
6. No record remains of what was lost.

EXAMPLE:
Architecture planning: a module migration is proposed. The senior decides in 10 minutes based on their general read. A junior worked in that module last month and knows it has a critical hidden dependency. They don't speak up because "the senior already decided" and "they don't want to seem like they're pushing back". Three weeks later, the migration uncovers the problem.

COUNTER-EXAMPLE:
Does not apply in code review (there is an artifact). Does not apply when data is shared before deciding. Does not apply in cultures where explicit challenge is institutionalized (e.g. tech reviews with formal red team).

RELATIONS:
- Authority bias (social psychology): the conceptual family.
- Information cascades: when one voice silences the next ones.
- HiPPO effect (highest paid person's opinion): particular case in companies.
- Psychological safety: the condition that breaks the pattern.

USE:
Design decisions where information is distributed: force evidence, slow down the decision, have the junior speak first, separate opinions from information.

30-SECOND PITCH:
When a decision is ambiguous and there is no clear evidence, rank weighs more than argument. The authoritative voice fills the vacuum, those with local information stay quiet, and the decision is made without the best information. Nobody sees the loss because no artifact remains.

ANCHOR WORDS: authority bias, information cascade, HiPPO effect, psychological safety, distributed information.
TARGET LEVEL: explain
TAUGHT LEVEL: pending (intuition decompressed, no formal teaching yet)
VALIDATED LEVEL: pending
STATE: packaged (needs validation against literature: Cialdini, Edmondson) → ready-for-validation (after Mode 1) → installed (only after Mode 4) → validated.
```

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
