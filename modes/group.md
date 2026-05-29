# Mode 14 — Group: collaborative construction with roles

Activation: "we are a team of N people and want to build a shared understanding of X", "facilitate a group session on X", "group workshop to build shared model of X" — ES: "somos un equipo de N personas y queremos construir un entendimiento compartido de X", "facilitar sesión grupal sobre X".

## Philosophy

In a group, "let's discuss X together" collapses toward the voice with the most authority or the fastest pace. For the final package to carry the group's distributed information, **silent intake before discussing, differentiated roles, and an explicit skeptic round** are required.

> "We don't start by discussing. First, everyone writes in silence. If we discuss first, we lose the information that lives in the voices that don't volunteer."

## When to use

- 3–5 people who need a shared mental model (architecture, technical concept, product decision, new domain).
- Onboarding workshop, cross-functional alignment, knowledge capture, structured sparring.

## Size

| Participants | Configuration |
|---|---|
| 1 | Individual Modes 1–12 |
| 2 | Mode 13 (Duo) |
| 3–4 | Group native (optimal) |
| 5 | Group native if roles are clear |
| 6+ | Pods of 3–4 + meta-merge (see below) |

## Roles

Full detail (cards, anti-domination, canonical interruptions): `templates/collaboration-modes.md`.

Summary:

1. **Concept Owner** — proposes the topic; first draft; clarifies context. Risk: dominating.
2. **Mechanism Builder** — pushes for "how does this really work?".
3. **Example Maker** — contributes cases from the group's context; replaces generic examples.
4. **Skeptic / Boundary Finder** — attacks the package; looks for counter-examples and limits. **Without this role, the package comes out fragile.**
5. **Serializer** (optional, recommended with >4 people) — converts the final package per audience.

Assignment by size:

- 3 people: Owner + Mechanism + Skeptic. Example Maker is rotated or taken by Owner.
- 4 people: 1 role per person, Serializer optional.
- 5 people: full roles + Serializer (or double Skeptic: technical + product).

## Critical anti-patterns (reinforcing SKILL.md)

- Starting with open discussion. **Force silent intake.**
- Concept Owner monopolizing (>40% of visible contributions). Interrupt.
- No active Skeptic → fragile package.
- Agreement without paraphrasing. "Yes, of course" is not alignment or installation.
- Skipping the final validation.

## Collaboration Intake (max 4 questions + label blocking)

0. **Participant labels (blocking).** Ask explicitly: "How do I identify each participant? — use names or labels A: / B: / C: / D:". If not provided, **do not proceed**. The silent intake, contribution tracking, and per-participant validation all require clear attribution.
1. **Package topic.**
2. **Assigned roles.** If there's a vacancy, decide how to cover it.
3. **Why now.** Upcoming decision / onboarding / knowledge capture / sparring.
4. **Total time available.** <45 min: compress. >90 min: split into sessions.

## Intake modality — true silent vs sequential

Distinguish the same way as in `modes/duo.md` (section "Intake modality"):

- **True silent intake**: each participant writes privately and shares only when everyone is ready. No anchoring.
- **Sequential intake** (shared channel): if the session lives in a single channel where what A writes is read by B/C/D before they write, **declare explicitly** the anchoring risk. Mark the session as `sequential intake` in the final report.

## Flow

### 0. Setup (≤5 min)

Confirm topic and roles. Announce the protocol: silent intake first, then comparison, then directed construction, then skeptic round, then validation.

### 1. Silent intake (10–15 min)

Each participant writes **without seeing the others**:

- CENTRAL PATTERN in one phrase.
- MECHANISM in 3–5 steps.
- One EXAMPLE of their own from the group's context.
- One question or doubt.

Environments: async (Slack/doc, the Skill shows none until all arrive) or synchronous (timer + simultaneous reveal).

### 2. Reveal and comparison

The Skill receives the N versions and produces the `COMPARISON — N versions` block with pattern / mechanism / example / questions raised / agreements / differences / absences. Exact format: `templates/collaboration-modes.md`.

### 3. Role-directed construction

For each field of the package, the Skill activates the responsible role first. The rest complement afterward.

Rules:

- Each role speaks first in its field.
- If a role doesn't contribute in 2 consecutive turns, the Skill names it ("Example Maker, this is your turn and I haven't heard from you yet").
- If the Concept Owner exceeds 40% of visible contributions, the Skill redirects.

### 4. Skeptic round (mandatory before closing)

```
SKEPTIC ROUND:
  Skeptic, present:
  - A case where this package does NOT apply.
  - A neighboring concept that gets confused with this one.
  - A condition where the mechanism breaks.

Rest of the group: respond to each attack.
```

If the group cannot respond to an attack, it remains as a **declared weakness**. It is not papered over.

### 5. Synthesis

Shared package with provenance per field. Full format (includes DECLARED WEAKNESSES, PENDING DECISIONS with owner + deadline): `templates/collaboration-modes.md` section "Package template with provenance".

### 6. Group validation — alignment, not installation

Each participant, separately and without seeing the others, writes their 30-second version. The Skill compares and reports using the collaborative state table (see `templates/validation.md` "Group validations — aligned vs installed"):

```
COLLABORATIVE VALIDATION:
  A: pattern ✓ / mechanism ✓ / own example ✓ / counter-example ✗ / new-case ✗  → aligned
  B: pattern ✓ / mechanism ✗ / own example ✓ / counter-example ✗ / new-case ✗  → not aligned yet
  C: pattern ✓ / mechanism ✓ / own example ✓ / counter-example ✓ / new-case ✓  → mini-rubric passed
  D: pattern ✓ / mechanism ✓ / own example ✓ / counter-example ✗ / new-case ✗  → aligned

Collaborative state reached:
  → aligned                       (default after 30s explanations per participant)
  → shared explanation confirmed  (own explanation + own example, no echoing)
  → validated at explanation level (per-level Explain rubric passed by each one)
  → installed (collective)        (full mini-rubric per-participant individual)
```

If someone fails: micro-iteration on the field that failed only, directed to that person. **Do not declare `installed (collective)`** until each participant passes the full mini-rubric (own explanation + mechanism + own example + counter-example or limit + application to new case). Default after a normal session: `aligned`. Detail in `templates/validation.md`.

### 7. Close

```
SESSION STATUS:
  Shared package: [created / pending]
  Collaborative state: [aligned / shared explanation confirmed / validated at explanation level / installed (collective)]
  Intake modality: [true silent / sequential — anchoring not eliminated]
  Visible contributions: A=N, B=M, C=K, D=L (not real-time percentages)
  Declared weaknesses: [list]
  Pending decisions: [list + owner + deadline]
  Next step: [validate against real case / serialize / follow-up session]

TURNS — FINAL DISTRIBUTION:
  [person]: N contributions (X% of total visible)
  ...
  Detected asymmetry: [none / Concept Owner dominated / Skeptic underused / ...]
```

## Pods + meta-package (for groups of 6+)

1. Split into pods of 3–4 with full roles per pod.
2. Parallel or sequential sessions, one per pod.
3. Each pod produces its package.
4. **Meta-merge**: an additional session with 1 representative per pod (≤4 people), applying the generalized Mode 13 (Duo) flow: compare packages block by block, identify agreements/differences/contradictions, produce a meta-package, validate.
5. Output: meta-package + list of differences between pods.

Rules:

- The representative is whoever can best explain the pod's package, not necessarily the Concept Owner.
- If the pod packages are very different, the large group was probably talking about different things. Mode 8 (glossary) first.

## Quick group mode (~30 min)

Silent intake 5 min → comparison + synthesis 15 min → skeptic round 5 min → short validation 5 min (only PATTERN + MECHANISM in one phrase each). Declare "compressed skeptic round" as a risk of the output.

## Conflict handling

- **Factual** (verifiable): pause, verify, return. Do not "consensus" a false fact.
- **Mental model** (consistent but different): keep both as complementary views or explicitly decide the dominant one.
- **Priority**: declare the group's priority + mark dissent.
- **Interpersonal**: the Skill marks the boundary. It is not a human conflict facilitator.

## Chaining

- Deep validation of the group package → Mode 4 individual with each participant.
- Package for saving → Mode 2 + Mode 9 with Concept Owner confirmation.
- Serialize for external audience → Mode 3 + Communication modifier (ideally with the Serializer).
- Pod meta-merge → repeat Mode 14 with representatives.
- If 2+ distinct packages emerge in the session → schedule separate sessions.
- If the group discovers it was talking about different things → Mode 8 (glossary).

## References

- Full protocols, role cards, anti-domination, package template with provenance: `templates/collaboration-modes.md`.
- Package template: `templates/concept-package.md`.
- Validation rubric: `templates/validation.md`.
- Gold-standard example: `examples/group-package-session.md`.

## Mode limitations

- Does not replace expert human facilitation in political or interpersonal conflicts.
- Requires a simultaneous writing channel. Purely oral meetings degrade quality.
- Produces a shared package and pending items; the group makes the decisions.
- With >5 people in a single session, quality drops even if the flow is followed. Use pods.
