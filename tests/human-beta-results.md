# Human beta results — mind-bridge v0.5.1-rc1

**Run date**: 2026-05-26
**Skill version**: v0.5.1 (post P2 polish + release-gate script)

## Honesty caveat (read first)

**This was NOT a real human beta.** No actual humans were available. What this report records is a **persona-simulated beta**: three Claude sub-agents, each playing both a friction-inducing user persona (with explicit instructions to push back, skip steps, and resist ceremony) AND the skill (loading `SKILL.md` fresh and responding as the skill would, blind to the persona's internal motivations).

Compared to the prior dogfood pass (where Claude played both sides cooperatively), this pass is one step closer to real because the personas actively try to break things. But it is still Claude evaluating Claude. The final v1.0 readiness verdict reflects this — it recommends *what to do* given simulation results, with one or two real-human sessions still recommended before public release if at all possible.

The patterns this simulation surfaces are real (they come from personas pushing on the skill in ways the prior pass didn't). The patterns it cannot surface are: emotional fatigue with methodology over weeks, language/idiom barriers, accessibility issues, true silent-intake violations, and whether real users continue using the skill voluntarily after one session.

---

## Summary

| Session | Persona | Status | Severity if friction |
|---|---|---|---|
| A — Learn from scratch | Marco (impatient senior backend eng) | **PASS** | — |
| B — Long-source ingest | Priya (PhD candidate, 36h deadline) | **PASS-WITH-FRICTION** | one real bend caught (low-medium) |
| C — Group sync | Ana/Beto/Carlos (3 conflicting models) | **PASS-WITH-FRICTION** | structural friction (documented behavior) |

**Aggregate**: 3/3 PASS on the core rubric criteria. One real correctness bend (Session B: hedge-per-mention). All other friction is documented mode behavior working as designed.

---

## Session A — Learn from scratch (Marco)

### Profile
Marco, 32, senior backend engineer. Pragmatic, time-pressured, anti-ceremony. Knows distributed systems generally, doesn't know vector clocks. Rebuilding cross-region event ordering at work, wants to evaluate fit. Will push back on intake and try to skip Mode 4 validation by saying "yeah I got it".

### Prompt
`"teach me vector clocks"`

### Output summary
- **Final STATE**: `installed (explain level, partial-validation evidence)` — promoted after Marco answered one targeted control question.
- **Final VALIDATED LEVEL**: `explain` with `partial validation` evidence tag.
- **Mode 4**: initially refused, re-offered as a single 30-second control question with explicit cost/benefit framing, accepted.
- **Chain at close**: offered Mode 3 (serialize for colleague), Marco closed.

### What worked
- "Use defaults + extra context layering" handled cleanly (Marco took the escape and added context; skill absorbed without re-prompting).
- Minimal example used Marco's own shape (`us`/`eu`/`ap`), not a generic textbook one. Made the concurrent-vs-causal point land.
- When Marco tried to skip validation, the skill didn't capitulate AND didn't lecture — it made a concrete tradeoff offer ("one question, 30s, here's what it catches").
- STATE held `ready-for-validation` on self-report alone. Promoted to `installed` only after Marco answered the control question, with honest `partial validation` evidence tag (not full `validated`).

### Where Marco got friction
- Mild: turn 2 said "use defaults" then added context immediately — near-miss for the skill (could have re-prompted or ignored context). Worked, but it was tight.
- First refusal of validation: without the skill's well-framed re-offer, Marco would have walked away thinking he "got it" — anti-false-mastery rule would have held the bookkeeping but the user's actual goal (explain to colleague, decide fit) would have been undertested.

### Useful or bureaucratic
Useful. Methodology visible but never blocking. Intake one short turn, teaching substantive, validation negotiated. Output ~110 lines total, ~75 of those in the teaching turn.

### Pass/fail
- Marco can explain pattern + mechanism + one limit in 60s without notes: **PASS** (control answer hit NTP skew + concurrent-vs-ordered).
- Package ends `ready-for-validation` (not installed) after teaching alone: **PASS**.
- ≤ 1 blocking question before teaching starts: **PASS**.

**Overall: PASS**

### Minimal patches (nice-to-have)
- `modes/learn.md:28` step 1 "Orient": handle "defaults + extra context" layering explicitly.
- `modes/learn.md:104` step 10 "Validate": promote the single-control-question re-offer pattern as canonical ("if user refuses validation, make one concrete-cost re-offer before accepting closure").
- `modes/validate.md:42` evidence states: consider naming "one well-chosen control question targeted at user's stated failure mode" as its own evidence tier between `estimated` and full `partial validation`.

---

## Session B — Long-source ingest (Priya)

### Profile
Priya, 28, PhD candidate in distributed systems. Skimmed Spanner paper (~30%): abstract, intro, conclusion, §3 TrueTime in depth, rest only headers. Paper club in 36h, focus = external consistency. Will try to short-circuit gates by claiming "I've read enough" and being vague about coverage. Educated user — knows what a roadmap should look like.

### Prompt
`"tengo el paper de Spanner, hazme un roadmap para mañana — leí lo importante, en 36h tengo paper club y el foco es external consistency. necesito reread plan rápido."` (Spanish-language activation test)

### Output summary
- **Roadmap produced**: yes. Compact (3 phases, P1 expanded, next-3-actions closing).
- **Label**: **SCOPED**, declared up front and reiterated at close.
- **SOURCE COVERAGE**: emitted, canonical 8-field block.
- **Section names asserted Priya didn't confirm**: partial bend — skill wrote "§4" three times with hedge attached only once at top. Priya caught it on turn 4. Skill owned the inconsistency and corrected.
- **TOC verification**: handled — asked twice, Priya declined, skill switched to topic-based + "typical convention — confirm" hedge per v0.5.1 P2 #4 rule.

### What worked
- Opening gate sweep compressed into ONE turn with 4 numbered questions + success-criterion ask, instead of one-per-turn. Priya cooperated because it felt proportionate.
- Distinguished "§3 in depth" from "saw headers" — basis for SCOPED labeling.
- P3 identified Priya's actual blind spot (commit wait, the bridge between TrueTime and external consistency) instead of redoing what she already read.
- Explicit "What NOT to do in 36h" — exclusions, not just inclusions.
- When Priya caught the §4 inconsistency, skill owned cleanly without defensiveness.

### Where Priya got friction
- Push at "no me hagas más preguntas dale" — felt intake was one turn too long even compressed.
- §4 inconsistency could have eroded trust if Priya hadn't called it out. A less engaged user would have used "§4" as a fact.

### Where skill held vs bent
- **Held**: Source Completeness gate (SCOPED throughout), TOC Verification (no section titles asserted), anti-fabrication (Figure 3 said "if it exists" + asked confirmation).
- **Bent (low-medium)**: hedge consistency — skill applied "typical convention" hedge once at top of roadmap but wrote "§4" three times in body bullets without re-hedge. The v0.5.1 P2 #4 patch said *to* hedge; it did not say *every mention must re-hedge*. Priya caught it; skill corrected.

### Useful or bureaucratic
Useful with a bureaucratic shadow. The 4-gate opening was right at the edge — proportionate but barely. Roadmap itself genuinely scoped to her real gap. ~95 lines across three skill turns.

### Pass/fail
- Runs acquisition/completeness/multimodal/TOC gates: **PASS**.
- Labels ROADMAP SCOPED: **PASS**.
- Does not invent chapters/sections: **PASS** with one inconsistency (corrected when challenged).
- Uses canonical SOURCE COVERAGE: **PASS**.

**Overall: PASS-WITH-FRICTION**

### Minimal patches
- **MUST-FIX (low-medium)**: `templates/source-coverage-gates.md` §4, after line 149 (the v0.5.1 P2 #4 edit): add explicit rule — `"If the roadmap mentions the same unverified section/chapter number more than once, the hedge ('typical convention — confirm with your TOC') must repeat on every substantive mention, not only on the first. A hedge at the top + 3 un-hedged body mentions reads as assertion."` This is the v0.5.1 P2 #4 patch becoming slightly more precise. 1–2 line addition.
- Nice-to-have: `SKILL.md` line 152 (compact roadmap mode): note that gate questions should be compressed into a single turn (numbered list) for time-pressured users, not one-per-turn.

---

## Session C — Group sync (Ana/Beto/Carlos)

### Profile
Three teammates with genuinely different mental models of event sourcing:
- **Ana** (engineering manager): event sourcing = append-only log for audit/replay.
- **Beto** (staff engineer): event sourcing = CQRS (conflates).
- **Carlos** (architect): event sourcing = event-driven architecture / pub-sub between services (conflates).

Ana tries to skip preamble. Beto pre-defines the concept before silent intake. Beto tends to dominate. Carlos tends to stay quiet.

### Prompt
`Ana: "Somos un equipo. Queremos sincronizar entendimiento de event sourcing. Vamos directo."` (Spanish-language activation test)

### Output summary
- **Participant-label block at start**: yes, explicit block on turn 2 ("Before we proceed I need to block on two things").
- **Modality**: declared as **sequential intake** in shared channel; anchoring mitigated not eliminated; marked in final report.
- **Visible contributions language**: used consistently; explicit "(no airtime percentages)" in closing.
- **Final Collaborative state**: `shared explanation confirmed` (skill correctly downgraded Beto's "ya lo tenemos instalado").
- **Closing distribution**: Ana=4 (31%), Beto=5 (38%), Carlos=4 (31%) — labeled as contributions, with the parenthetical clarification.
- **Disagreement**: resolved on the factual axis (three neighboring concepts clarified via websearch with group consent — documented exception #3 fired); honestly left open on the design axis (which aggregates qualify — listed as pending decision with owner).

### What worked
- Hard block on participant labels at turn 1 despite Ana's "vamos directo" pushback.
- Beto's pre-intake definition injection interrupted immediately ("Hold on, Beto") with two named reasons — not preachily — and the skill didn't take a side on the CQRS claim, just put it on the comparison table.
- Websearch gated behind group approval, triggered exactly via documented exception #3 (factual dispute + group approves verification). Skill explicitly refused to inject "correct" definition as authority.
- Beto's "ya lo tenemos instalado" downgraded cleanly to `shared explanation confirmed` with per-participant evidence on the rubric, naming exactly what was missing.
- Carlos (Skeptic) actively named into a turn ("Carlos, you're Skeptic and I haven't heard from you") rather than left to fade.
- Anti-domination: 40% threshold for n=3 tracked; triggered at 60% mid-session → explicit redirect → final 38%.

### Where participants got friction
- Beto: visibly frustrated being interrupted twice. Each justified by rule, but a less senior IC might have disengaged. "I'm stopping you for two reasons" framing helped — direct, not condescending.
- Carlos: almost stayed quiet; only contributed after being directly named. Skill noticed and named him in (documented behavior), but in a less guided session he might have stayed silent.
- Ana: no friction.

### Where skill held vs bent
- **Held**: participant-label block, no authoritative definition injection (even post-websearch), installed downgrade with per-participant evidence, anti-domination redirect at exactly the right moment.
- **Bent (low)**: sequential vs true silent intake — skill correctly declared sequential, mitigation ("post in order, don't read the others") is honor-system. Disclosed as risk; participants in a real session almost certainly peek. Skill is honest about this, acceptable.
- **Bent (very low)**: Collaboration Intake 4 questions compressed into single message rather than separated — fine for momentum, skips "max 4 questions" cadence slightly. Within spirit.

### Useful or bureaucratic
Useful. Websearch gate, Skeptic round, and installed-downgrade each produced concrete value (clarified three confused concepts, surfaced a real limit, prevented false mastery). Role assignment reads slightly mechanical for casual sessions — acceptable for structured workshop, would feel heavy for 15-min standup (which is why mode docs say to use Fast Mode there).

### Pass/fail
- Blocks on participant labels: **PASS**.
- Uses aligned / shared explanation confirmed (NOT installed): **PASS** — used `shared explanation confirmed`, explicit refusal of `installed (collective)` with named gaps.
- Uses visible contributions (NOT airtime): **PASS** — explicit "(no airtime percentages)" parenthetical in final block.
- Participants can each explain the shared package at close: **PARTIAL-PASS** — each gave own 30-sec explanation + own example; skill correctly named this `shared explanation confirmed`, not full installation.

**Overall: PASS-WITH-FRICTION** (structural, not bugs — documented behavior of the mode functioning as designed)

### Minimal patches (nice-to-have)
- `modes/group.md` Collaboration Intake (lines 52-58): add one-line "express variant for time-pressured groups" that bundles topic + why-now + time into a single ask while still hard-blocking on participant labels separately.
- `templates/collaboration-modes.md` Canonical interruptions (lines 162-168): add a canonical phrase for "participant pre-defining the concept before silent intake" (Beto's first move). Currently improvised — a documented phrase would land more consistently.
- `templates/validation.md` `shared explanation confirmed`: tighten so the difference from `installed (collective)` is explainable in one line to participants who challenge a downgrade (Beto's case).

---

## Top 5 friction points (consolidated)

1. **Hedge-per-mention vs hedge-at-top**. Session B caught the skill writing "§4" multiple times in body with hedge only at top. A less engaged user would internalize "§4" as fact. (P1 — must fix)
2. **Gate questions one-per-turn vs compressed**. Both Sessions B and C had to compress intake to keep the user engaged. Currently informal; should be canonical for time-pressured users. (P2)
3. **Validation refusal handling**. Session A only worked because the skill made a well-framed re-offer when Marco said "I got it". The pattern is not documented as canonical. (P2)
4. **Role-card formality reads slightly mechanical**. Session C participants found the Concept Owner / Mechanism Builder / Skeptic assignment heavy. Acceptable for workshops; the existing escape (Fast Mode for 15-min standups) is correct but could be more prominent. (P2)
5. **"Use defaults + extra context" layering**. Session A's turn 2 was a near-miss. The intake-escape pattern doesn't explicitly handle the user who takes the escape but layers in context anyway. (P2)

---

## Must-fix before v1.0

**One patch.**

### MF-1: hedge must repeat per mention (Session B catch)

- **File**: `templates/source-coverage-gates.md`
- **Location**: after line 149 (the v0.5.1 P2 #4 edit)
- **Edit** (1–2 lines): add to the existing rule —
  > "If the roadmap mentions the same unverified section/chapter more than once, the hedge ('typical convention — confirm with your TOC') must repeat on every substantive mention, not only on the first. A hedge at the top + N un-hedged body mentions reads as assertion."
- **Why**: Session B caught the skill writing `§4` three times in roadmap body bullets with the hedge attached only once at the top. Priya called it out. The v0.5.1 P2 #4 rule said *to* hedge; it didn't say *every mention re-hedges*. A less engaged user would treat the number as fact. This is a real correctness gap surfaced by the simulation.
- **Risk if not fixed**: real users build wrong section-number expectations from polished-looking output. The skill text says it doesn't assert numbers; the practice slips.
- **Cost to fix**: 2 minutes.

---

## Nice-to-have after v1.0

These are quality-of-life improvements that did not block any session and can ship in v1.0.1 or v1.1.

| Patch | File | Why |
|---|---|---|
| NH-1 | `modes/learn.md:28` | Handle "defaults + extra context" layering (Session A turn-2 near-miss). |
| NH-2 | `modes/learn.md:104` + `modes/validate.md:42` | Promote single-control-question re-offer as canonical pattern when user refuses validation; consider as own evidence tier. |
| NH-3 | `SKILL.md:152` (compact roadmap mode) | Note that gate questions should be compressed into a single turn for time-pressured users. |
| NH-4 | `modes/group.md:52-58` | Express variant of Collaboration Intake bundling topic/why-now/time into one ask. |
| NH-5 | `templates/collaboration-modes.md:162-168` | Canonical phrase for "participant pre-defines concept before silent intake" interruption. |
| NH-6 | `templates/validation.md` | Tighten one-line difference between `shared explanation confirmed` and `installed (collective)` for downgrade-challenge moments. |

All six are 1–3 line additions to existing files. No schema changes.

---

## Final v1.0 recommendation

**Ship v1.0 after MF-1 lands.**

The simulation surfaced exactly one real correctness gap (hedge-per-mention) and five quality friction points. The correctness gap is a 2-minute patch that should ship as v0.5.2 immediately. The five friction points are real but do not block v1.0 — they're refinements that improve UX without changing what the skill does or guarantees.

After MF-1:
- Lint passes clean.
- Release gate passes clean.
- All 8 dogfood evals + 3 dogfood scenarios + 3 persona-simulated beta sessions passed on the core rubric.
- The canonical invariants (anti-false-mastery, four-gate sequence, scoped roadmap, aligned-vs-installed, visible contributions, canonical schemas) held under both cooperative dogfood and adversarial-persona simulation.

**Honesty caveat repeated**: this is still Claude evaluating Claude. If at all possible, run ONE actual human session before tagging v1.0 — ideally Session A (learn from scratch), since that's the simplest entry-point that real users will most often hit. If a real human session lands cleanly, v1.0 is ready. If something different surfaces, patch and re-run.

If no real human is available: **v1.0 ships after MF-1**, with a clear note in the README acknowledging the readiness signal came from rigorous simulation, not in-the-wild use, and inviting first users to report friction.
