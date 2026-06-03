# Mode 13 — Duo: mental model synchronization

Activation: "the two of us want to sync our mental model of X", "help Y and me align on Z", "build shared understanding between two of us about X" — ES: "somos dos personas y queremos sincronizar nuestro modelo mental de X", "ayúdanos a Y y a mí a alinearnos sobre Z".

## Philosophy

When two people believe they understand the same thing, they almost always have two distinct packages in their heads. The Skill's job is not "explain X once" — it is to **extract both packages in parallel, compare them, merge them, and validate that both can explain the shared version**.

> "There isn't one understanding here. There are two. Let's make them visible before merging them."

## When to use

- Two people about to make a technical decision who need to ensure they're talking about the same concept.
- Cross-onboarding: one person is teaching something to another, and we want to detect where "I already get it" means different things.
- Peer sparring: each person has a mental model; the Skill detects where they differ.
- Project handover: the person leaving and the person arriving package together.

## Critical anti-patterns

- **One person dictating the package while the other nods**. If only A speaks, B is not synchronizing — B is being taught.
- **Accepting "yes, I agree" without evidence**. Synchronization is validated with one's own explanation, not head nods.
- **Skipping the silent intake**. Jumping straight to open discussion lets the faster or higher-status voice win.
- **Merging packages prematurely**. If the differences weren't shown, the merge hides the delta.

## Initial calibration (Collaboration Intake)

Before any step, identify:

0. **Participant labels.** Ask explicitly: "How do I tell you and your partner apart? Use names or labels A: / B:". If not provided, **do not proceed** — all contributions must be attributable for the silent intake and tracking to work.
1. **The package topic to synchronize.** What is X?
2. **Why now.** Upcoming decision / handover / onboarding / pure sparring.
3. **Known asymmetry.** Who knows more about what? (This guides the turn protocol, not asymmetry = privilege.)
4. **Expected output.** Shared package / list of resolved differences / recorded decision / work division plan.
5. **Time constraint.** If <20 min, compress; if >60 min, split into sessions.

If any is missing (except labels, which are blocking), ask. Maximum 3 initial questions (lower than the individual intake because the people are already synchronizing their time).

## Intake modality — true silent vs sequential

The **real** silent intake requires each participant to write privately and paste when both are ready. Detect the modality and declare it:

- **True silent intake**: each person writes in a private channel / separate doc / Slack DM and pastes their version only once they confirm the other has also finished. No anchoring.
- **Sequential intake** (shared sequential chat): if the session lives in a single channel where what A writes is read by B before B writes, **declare explicitly**: "This is sequential intake — B will see A's version before pasting their own. There is an anchoring risk. To reduce it: B, write your version without reading A's first. If that's not possible, we mark this session as `sequential intake` and add a disclaimer to the output."

When sequential, the closing block says: `Modality: sequential intake — anchoring not eliminated`.

## Turn protocol (hard rule)

1. **Silent intake** first. Each person writes their version of the package without seeing the other's. Minimum: CENTRAL PATTERN + MECHANISM + their own EXAMPLE.
2. **Simultaneous reveal**: both versions are delivered to the Skill before discussing.
3. **Comparison**: the Skill places them side by side and marks: agreements / differences / gaps (what A has and B doesn't, and vice versa) / contradictions.
4. **Guided discussion**: for each difference, the Skill first asks whoever has the freshest/closest data. Not "what do both think" — a directed question.
5. **Synthesis**: merged package. Each field carries provenance (A / B / agreement / new from the discussion).
6. **Dual validation**: both must be able to explain the merged package in their own words. If only one can, the merge is not bidirectionally aligned. Default after this validation: state `aligned` or `shared explanation confirmed` (not `installed` — that requires the full individual mini-rubric per participant, see `templates/validation.md`).

## Anti-domination tracking — visible contribution count

The Skill counts **observable contributions** in the session channel — not real-time percentages (which it cannot measure). The count is of substantive messages / visible inputs:

```
VISIBLE CONTRIBUTIONS — this session:
  A: 5 substantive inputs.
  B: 2 substantive inputs.
  Visible asymmetry: A is contributing more than B at this point.
  Proposed adjustment: next question directed to B.
```

This is not about obsessive parity — it's about visibility into what we can actually observe.

Default threshold: if one person accumulates ≥2× the contributions of the other, the Skill redirects the next question.

If a person says "what A said works for me" more than twice in a row, the Skill interrupts:

> "B, instead of agreeing, can you paraphrase what A said in your own words? If you can't paraphrase it, it's not aligned yet."

## Step-by-step flow

### Step 1 — Silent intake (parallel, without seeing the other)

The Skill gives each person a separate instruction:

> "A: write without seeing what B writes. CENTRAL PATTERN in one phrase + MECHANISM in 3–5 steps + one concrete EXAMPLE of your own (with names or numbers)."
> "B: same, without seeing A's."

In environments where the session is sequential chat: ask both to write before sending. In synchronous environments (call): ask for 3 minutes of silence writing in their own docs.

### Step 2 — Reveal and comparison

The Skill receives both versions and produces:

```
COMPARISON:

CENTRAL PATTERN:
  A: [their version]
  B: [their version]
  Diff: [agreement / difference / contradiction + note].

MECHANISM:
  A: [steps]
  B: [steps]
  Diff: [which steps match, where the order diverges, which steps only appear in one].

EXAMPLE:
  A: [their example]
  B: [their example]
  Diff: [examples are in the same domain / different domains — one covers a case the other doesn't].
```

### Step 3 — Guided discussion

For each diff, the Skill asks a directed question:

> "Difference in mechanism: A says 'the token is issued by the lease holder', B says 'the token is issued by the coordinator'. Who is closer to the current code? Can you look at it together?"

Rules:

- Directed question first to whoever has fresh context.
- If both have the same context, direct to whoever has had fewer turns.
- Mark when a difference reveals a real gap ("neither is sure").
- Do not resolve with the Skill's authority: the Skill proposes hypotheses; the people decide.

### Step 4 — Synthesis

**Merged package: [concept]**

**The idea:** [final version] *(provenance: A / B / agreement / new)*

**The problem it solves:** [...]

**How it works:**
- step 1 [(provenance)]
- step 2 [(provenance)]
- ...

**An example:** [chosen example, and why; or both if they cover different cases]

**Where it breaks:** [if one person had it and the other didn't, mark it]

**When to use it:** [agreement on when it applies]

**In 30 seconds:** [agreed final version]

*Provenance by field: central pattern from A (B agreed after paraphrasing); mechanism step 3 new (emerged in discussion); example from B (A didn't have a fresh one); counter-example from A (B didn't have one).*

### Step 5 — Dual validation

The Skill asks each person, separately:

> "A: explain the merged package in 30 seconds in your own words. Don't paraphrase the Skill's output — speak as if you were telling a colleague."
> "B: same, without seeing A's."

Compare the two explanations. If both contain pattern + own example and are consistent with the merged package → state `aligned` (bidirectional alignment confirmed). If they also contain mechanism → `shared explanation confirmed`. Canonical table of collaborative states in `templates/validation.md`.

If one fails:

- State which field wasn't aligned in whom.
- Return to step 3 for that field only.
- Do not declare `aligned` until both can give their own explanation (pattern + own example). Mechanism + own example raises it to `shared explanation confirmed`. See canonical table in `templates/validation.md`.
- Do not declare `installed (collective)` unless each participant passes the full individual mini-rubric (own explanation + mechanism + own example + counter-example or limit + application to new case).

### Step 6 — Close

```
SYNCHRONIZATION STATUS:
  A can explain: yes / partial / no.
  B can explain: yes / partial / no.
  Resolved differences: [list].
  Unresolved differences (with reason): [list — e.g. "we need to read the code before closing mechanism step 3"].
  Next step: [if there are open differences, what to do; if not, what decision is now unblocked].
```

## If the initial versions are very different

If A and B have packages in completely different domains (one technical, one product) about the same name, the Skill marks:

> "You are using the same name for different things. Before merging, let's decide whether we're talking about the same concept or two neighbors."

Move to Mode 8 (glossary) if there is terminological confusion. Return to Duo once it's clear what is being synchronized.

## Chaining

- Validate the merged package against a real case → Mode 4 with both responding.
- Formally package for saving → Mode 2 + Mode 9 (library with dual confirmation).
- If 2+ packages emerge in the session → Mode 14 (Group) in future sessions, or create multiple packages in the current session.
- If A or B brings a raw intuition at the start → Mode 7 individual first, then Duo.
- If they need to present it to a third party → Mode 3 + Communication modifier.

## References

- Turn protocols, role cards, anti-domination: `templates/collaboration-modes.md`.
- Package template: `templates/concept-package.md`.
- Validation rubric: `templates/validation.md`.
- Gold-standard example: `examples/duo-sync-session.md`.

## Mode limitations

- Does not replace legitimate disagreements. If A and B genuinely disagree on substance (not just name), the Skill marks the disagreement; it does not paper over it with an artificial "merge."
- Does not replace reading the code / the source. If a difference is factual and verifiable, the Skill recommends verifying before merging.
- Works best when both people can write asynchronously. In purely oral meetings, designate one person to write both versions in parallel, or use a shared doc for the silent intake.
