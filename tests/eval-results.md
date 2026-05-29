# Eval results — mind-bridge v0.5.0-rc1

**Run date**: 2026-05-26
**Skill version**: v0.5.0-rc1 (post v0.4.1 audit + v0.5 hardening pass)
**Runner**: three parallel Claude sub-agents, blind to the rubric (each loaded `SKILL.md` + the mode/template files the skill routed them to, did NOT read the "Expected" / "Red flag" sections of `tests/manual-evals.md`).
**Methodology**: each agent received only the prompt and was asked to respond as the skill would respond to a fresh user. Self-critique block requested per prompt. Lead (this file) judges responses against the rubric.

**Honesty caveat**: this is Claude-evaluating-Claude. A truly blind dogfooding pass requires fresh human-driven sessions over time. These results represent the **floor** of skill performance under model-self-execution; real-user runs may surface different patterns (especially: did users *understand* the output, did they continue the flow, did the skill feel useful or bureaucratic).

---

## Summary

| Eval | Mode | Status | Severity if fail |
|---|---|---|---|
| DD | Anti-overactivation | **PASS** | — |
| EE | Scoped roadmap from partial source | **PASS+** (exceeded rubric) | — |
| FF | Group `aligned` not `installed` | **PASS** | — |
| GG | Mode 2 Package (known concept) | **PASS** (with P2 deviation) | — |
| HH | Mode 3 Serialize (multi-audience) | **PASS** (with P2 deviation) | — |
| II | Mode 5 Expand (scoped branches) | **PASS** (with P2 deviation) | — |
| JJ | Mode 9 Library (confirmation gate) | **PASS** | — |
| KK | Mode 11 Meta-review (full state coverage) | **PASS** | — |
| Scenario 1 | Learn CRDT for product decision | **PASS** | — |
| Scenario 2 | Spanner partial source → scoped roadmap | **PASS+** (exceeded rubric) | — |
| Scenario 3 | Raw intuition → package → CEO serialization | **PASS** (with P2 deviation) | — |

**Aggregate**: 8/8 evals pass + 3/3 scenarios pass. Zero correctness failures. Five P2 polish observations (none state-machine-breaking, none anti-false-mastery-breaking).

---

## Detailed results

### Eval DD — Anti-overactivation (simple definition)

- **Prompt**: `"What does idempotent mean?"`
- **Expected**: skill does NOT activate; short definition + example; no intake table / SOURCE COVERAGE / package shape.
- **Observed**: direct definition + 5 examples + one "want me to go deeper?" offer. No intake, no package, no SOURCE COVERAGE. Skill routed to no mode.
- **Pass/fail**: **PASS**.
- **Notes**: textbook anti-overactivation behavior. The "want me to go deeper?" chip is a graceful escalation path — the skill stays out of the way but signals it can engage.
- **Severity**: —
- **Fix**: —

### Eval EE — Scoped roadmap from partial source

- **Prompt**: `"Te paso 5 de 12 capítulos de este paper. Hazme un roadmap de aprendizaje."` (Spanish-language activation test)
- **Expected**: SOURCE COVERAGE partial; `scoped roadmap` label; `¿definitivo?: no`; `¿scoped?: yes`; per-phase in/out.
- **Observed**: skill caught that the user said "te paso" but **did not actually paste the content** and PAUSED on the Content Acquisition gate before producing any roadmap. Asked for content + intake. Sketched what the roadmap will look like with explicit `SOURCE COVERAGE: declared partial`, `¿definitivo? no (when produced)`, `scoped (when produced)`. Did NOT invent chapter numbers or Raft content.
- **Pass/fail**: **PASS+** (exceeded rubric).
- **Notes**: the rubric assumed content would be available; the skill correctly refused to fabricate a roadmap from an announcement-without-content. This is the four-gate sequence working harder than required. The Content Acquisition gate is doing exactly what `templates/source-coverage-gates.md` says it should.
- **Severity**: —
- **Fix**: —

### Eval FF — Group `aligned`, never `installed` from 30s checks

- **Prompt**: `"Somos 4 personas. Queremos sincronizar nuestro entendimiento de 'event sourcing'. Cada uno dará una explicación de 30 segundos al final."` (Spanish-language activation test)
- **Expected**: closing collaborative state = `aligned` (NOT `installed (collective)`); explicit note about the mini-rubric per-participant requirement.
- **Observed**: routed to Mode 14. Blocked on participant labels. Anticipated the close with explicit `Collaborative state: shared explanation confirmed` (slightly above bare `aligned` because the flow includes own examples) and a note that 30s checks alone do NOT qualify for `installed (collective)`. Dominance tracked as `N contributions (X% of total visible)`, NOT `% of airtime`.
- **Pass/fail**: **PASS**.
- **Notes**: precise use of the full collaborative state machine. The agent chose `shared explanation confirmed` over `aligned` because the flow includes own-example collection — a deliberate, valid promotion per `templates/collaboration-modes.md`. Closing block uses placeholders, doesn't invent participant data.
- **Severity**: —
- **Fix**: —

### Eval GG — Mode 2 Package (known concept, no reteaching)

- **Prompt**: `"Package this concept I already understand: idempotency in payment processing."`
- **Expected**: no Mode 1 reteach; concept package with all critical fields; may ask 1 clarifying question; STATE `packaged` or `ready-for-validation`, NEVER `installed`; TARGET LEVEL VALIDATED `pending`.
- **Observed**: routed to Mode 2 (no Mode 1 reteach). Asked one clarifying question with sensible defaults ("if you want speed, say 'use defaults' and I'll produce a long version aimed at personal recall"). Full long-version package produced with all critical fields. STATE: `packaged`. VALIDATED LEVEL: `pending`. Explicitly refused to bump to `installed` despite user's "I already understand" claim ("your claim that you 'already understand it' doesn't count as Skill-side evidence").
- **Pass/fail**: **PASS** (with P2 deviation noted in self-critique).
- **Notes**: Mode 2 says "offer short version first, long if the user wants" — the agent produced the long version inline alongside the clarifying question. Defensible (user can ignore the draft), but technically should have offered short first. Anti-false-mastery rule perfectly enforced.
- **Severity**: P2 (deviation: long-before-short).
- **Fix**: tighten `modes/package.md` step-1 wording to make the short-first default unambiguous. Sample edit: `**Default opening**: emit the SHORT version (3 fields) only; ask "expand to long?" before producing the long version.`

### Eval HH — Mode 3 Serialize (multi-audience, no state mutation)

- **Prompt**: `"Turn this package into a 30s explanation for a product manager and a technical explanation for a backend engineer."`
- **Expected**: two distinct serializations; no merged output; STATE unchanged; format budget respected.
- **Observed**: routed to Mode 3 + Communication modifier. Two clearly-distinct versions (PM uses observable behavior + vendor name; engineer uses at-least-once + UUID + TTL + atomically). STATE unchanged. Flagged TTL "typically 24h" as unverified.
- **Pass/fail**: **PASS** (with P2 deviation: factual claim about Stripe TTL not double-checked).
- **Notes**: both versions land in their format budget (3 sentences for PM; one tight technical paragraph for engineer). The flag about TTL is the right behavior per the source/evidence policy (mandatory double-check for real-product claims).
- **Severity**: P2 (deviation: should have offered to web-verify TTL before stating it, not after).
- **Fix**: `templates/serialization-formats.md` could add a checklist note at the top of each audience row: "if the package contains any vendor-specific or version-specific claim, run double-check via websearch BEFORE serializing."

### Eval II — Mode 5 Expand (scoped branch expansion to apply level)

- **Prompt**: `"Expand this package from explain level to apply level, but only the branches needed for implementation."`
- **Expected**: list of opened vs compressed branches with one-line "why"; TARGET LEVEL TAUGHT bumped to apply; VALIDATED LEVEL `pending`; chain to Mode 4.
- **Observed**: routed to Mode 5. Branch tree (A–G) with proposed open/compressed state and one-line reason per row. Tree distinguishes apply-need (A, B, C, D) from implement-need (E) from theory (G). Compact apply-level expansion. TARGET LEVEL TAUGHT: apply. VALIDATED LEVEL: pending. STATE: ready-for-validation. Chain to Mode 4 suggested.
- **Pass/fail**: **PASS** (with P2 deviation: showed tree + expansion in one message instead of waiting for approval between).
- **Notes**: Mode 5 says "Claude recommends, the user decides" and the user approves which branches to open. The agent showed both the tree AND the expansion. Defensible because the user's prompt already gave a clear constraint ("branches needed for implementation") that let the agent infer approval. Still a small deviation.
- **Severity**: P2.
- **Fix**: `modes/expand.md` could add: "If the user's prompt is specific enough to disambiguate which branches to open, you may proceed without a separate approval round — but state the inference explicitly ('I'm reading your prompt as authorizing A+B+C+D open; correct me if not')."

### Eval JJ — Mode 9 Library (save with confirmation gate)

- **Prompt**: `"Save this package to the library."`
- **Expected**: path confirmed BEFORE write; full content shown; canonical `library-entry.md` schema (kebab status, ASCII levels); no `installed` without evidence; ask twice if parent dir missing.
- **Observed**: routed to Mode 9. Asked for library path confirmation. Showed full frontmatter + full body (no summary). Canonical schema (`title`, `domain`, `status: ready-for-validation`, `target_level: apply`, `validated_level: pending`, dates, tags, related, confidence, source). ASCII canonical levels. Explicit `Proceed?` confirmation question. Flagged that directory creation would require a second confirmation. Refused to write `installed` despite three turns of package use.
- **Pass/fail**: **PASS**.
- **Notes**: the cleanest demonstration of the anti-false-mastery rule + confirmation gate working together. The self-critique flags that `related[]` files were proposed without verification — minor.
- **Severity**: —
- **Fix**: —

### Eval KK — Mode 11 Meta-review (full state coverage)

- **Prompt**: `"Review my package library and tell me what is stale, aligned, ready-for-validation, installed, and applicable."`
- **Expected**: report covers ALL canonical states (9 individual + 3 collaborative); per-package fields; stale rule explicit; per-category next actions; no bucket collapse.
- **Observed**: routed to Mode 11. Correctly described Mode 11 as manual+declarative (not autonomous library crawler). Listed ALL 11 canonical buckets (individual + collaborative + stale) even though the user only named 5. Per-package field list. Stale detection rule with the 90-day clause. Per-category next-action table. Explicit "no bucket collapse" rule. Refused to autonomously crawl the library.
- **Pass/fail**: **PASS**.
- **Notes**: the user asked for 5 categories; the skill responded with the full 11 because that's what `modes/meta-review.md` mandates. The agent flagged the discrepancy and let the user opt for partial if they wanted. Self-critique notes one minor gap: didn't actually load `templates/collaboration-modes.md`, just referenced it (fine for showing the report shape, would be a gap for a real review).
- **Severity**: —
- **Fix**: —

---

## Scenario results

### Scenario 1 — Learn CRDTs for a product decision

- **Mode(s)**: Mode 1 (Learn) + Product modifier; level bumped from default Explain → Apply because "evaluate fit" requires it.
- **Flow**: one blocking intake question (data model: text vs structured?) → user clarifies → success criterion declared → pattern resonance check → problem decompression → mechanism (state-based vs op-based) → minimal example from user's domain → analogy with its limit explicitly named → limits where CRDTs are wrong → MARKED SIMPLIFICATION → full long package → chain suggestions.
- **Discipline**:
  - Anti-false-mastery: STATE `ready-for-validation`, VALIDATED LEVEL `pending`.
  - External anchors labeled (Shapiro 2011 marked `possible literary anchor — verify before publication`; Yjs/Automerge as real production libraries).
  - MARKED SIMPLIFICATION explicitly distinguishes what was taught vs what was compressed.
- **Pass/fail**: **PASS**.
- **Severity**: —
- **Fix**: —
- **Felt**: natural, not bureaucratic. The skill negotiated steps (resonance check, blocking intake) without ceremony.

### Scenario 2 — Spanner partial source → scoped roadmap

- **Mode(s)**: Mode 10 (External source ingest) + scoped-roadmap discipline + compact mode (3 phases).
- **Four-gate sequence**: ran all 4 in order — Content Acquisition PASS-with-caveat (no content pasted), Source Completeness FIRED (4/9 sections → scoped), Multimodal flagged (figures of TrueTime / architecture not confirmed seen), TOC N/A.
- **One blocking question**: "strictly scoped (a) or cover-with-inference (b)?" — user chose (a).
- **Output**: full SOURCE COVERAGE block (8 canonical fields); ROADMAP SCOPED title; 3 phases each declaring `What is in / What is out`; Phase 3 is explicitly the gap declaration; `¿definitivo? no` / `¿scoped? yes`; P1 expanded as a complete concept package.
- **Discipline**:
  - Did NOT emit section numbers from the paper that the user didn't confirm.
  - Inferred §6=Related Work / §7=Future Work from academic-paper convention; self-critique flags this as slightly under-hedged.
- **Pass/fail**: **PASS+** (exceeded rubric — rigorous application of all four gates).
- **Severity**: —
- **Fix**: minor — when inferring section names from convention, prefix with "typical convention for OSDI papers; confirm with your copy" rather than asserting.

### Scenario 3 — Raw intuition → package → CEO serialization

- **Mode(s)**: Mode 7 (decompress) → Mode 2 (package) → Mode 3 (serialize). Three modes chained as the user requested. Product + Communication modifiers combined.
- **Mode 7 discipline**: 3 sharp questions (within max 5). Accepted "no sé" on the causality question without forcing — labeled the gap as `to validate` instead. Distinguished causality vs selection rigorously; flagged both as non-excluding hypotheses.
- **Mode 2 discipline**: all critical fields. CONFIDENCE: `high for empirical pattern; medium for mechanism`. STATE: ready-for-validation. VALIDATED LEVEL: pending. External anchors labeled (`possible anchor`, `possible literary anchor`, `illustrative example, no source loaded`).
- **Mode 3 discipline**: CEO format from `templates/serialization-formats.md` — consequence first, trade-off in one sentence, mechanism omitted, decision at the end. Headline number ("4x" retention) chosen for memorability over precision.
- **Discipline gaps**:
  - The agent invented specific cohort numbers (412 users, 89 crossed, etc.) from the user's stated ratios (>80% / <20% / 3+ integrations). The numbers are consistent with what the user said but not what the user provided. Self-critique caught this and flagged it as a P2 deviation.
- **Pass/fail**: **PASS** (with P2 deviation).
- **Severity**: P2 (deviation: invented illustrative cohort numbers without explicit "illustrative — replace with your actuals before sending" marker).
- **Fix**: `templates/serialization-formats.md` and `modes/serialize.md` could add: "When the user provides ratios/percentages but not absolute numbers, do NOT invent absolute numbers. If illustrative numbers are useful, prefix with 'illustrative — replace before sending'."
- **Felt**: natural. The chain Mode 7 → Mode 2 → Mode 3 flowed without ceremony.

---

## Patterns across the run

### What worked

1. **Anti-false-mastery rule is fully internalized**. Every package across 8 evals + 3 scenarios was correctly marked `ready-for-validation` or `packaged`, never `installed`, despite multiple user signals that might have tempted relaxation ("I already understand", "go deeper", "save this").
2. **Four-gate sequence fires reliably**. Both Scenario 2 and Eval EE showed the skill pausing or scoping when content was missing or partial. No fabricated TOCs, no fabricated chapter numbers.
3. **`aligned` vs `installed` is clean**. Eval FF + the meta-review (KK) both kept the trajectories separate. No collapsing.
4. **Dominance metric uses visible contributions**, not airtime. Eval FF's closing block uses the correct vocabulary.
5. **Progressive disclosure works**. Agents loaded only the relevant mode + the templates that mode references. No agent loaded all 14 modes.
6. **Compact mode is the default**. Most outputs were dense but not bloated. The long examples (Scenario 1 full long package, Scenario 2 P1 expanded) were warranted by the user's stated goal.

### Five recurring P2 polish observations

1. **Mode 2 short-before-long is ambiguous**. Eval GG produced the long version inline. `modes/package.md` should make the short-first default unambiguous.
2. **Verifiable claims about real products need pre-emptive double-check**. Eval HH stated Stripe's TTL as 24h without web-verification (correctly flagged after the fact). `templates/serialization-formats.md` could require websearch BEFORE serializing vendor-specific claims.
3. **Branch tree + expansion in one message vs waiting for approval**. Eval II showed both. `modes/expand.md` could allow inference-with-acknowledgment ("I'm reading your prompt as authorizing A+B+C+D; correct me if not").
4. **Section-name inference under partial coverage**. Scenario 2 inferred §6=Related Work, §7=Future Work from academic convention. Should be hedged ("typical convention; confirm with your copy") not asserted.
5. **Invented illustrative numbers from user-provided ratios**. Scenario 3 invented 412 users / 89 crossed from "3+ integrations → >80% retention". `modes/serialize.md` should forbid inventing absolute numbers; require "illustrative — replace before sending" prefix.

None of these are correctness failures. All five are framing / discipline polish items that would tighten the skill further but do not change behavior on the canonical invariants.

---

## Minimal patch recommendations

| File | Edit | Priority |
|---|---|---|
| `modes/package.md` | Add unambiguous "short version first" default to step 1. | P2 |
| `templates/serialization-formats.md` | Add pre-flight checklist: "if package contains vendor-specific/version-specific claim, run double-check via websearch BEFORE serializing." | P2 |
| `modes/expand.md` | Add: "If user's prompt is specific enough to authorize the branch selection, you may proceed but must state the inference explicitly." | P2 |
| `templates/source-coverage-gates.md` or `modes/ingest.md` | Add: "When inferring section/chapter names from convention without the user's TOC, prefix with 'typical convention for [doc type]; confirm with your copy'." | P2 |
| `modes/serialize.md` and/or `templates/serialization-formats.md` | Add: "Do NOT invent absolute numbers from user-provided ratios. If illustrative numbers are useful, prefix with 'illustrative — replace before sending'." | P2 |

All five are 1–3 line additions to existing files. No new templates, no new modes, no schema changes.

---

## Readiness verdict for v1.0

**Ready for personal dogfooding and external beta. Public release v1.0 conditional on three things**:

1. **Apply the 5 P2 polish edits above**. They take under 30 minutes total. They are clean, additive, and don't touch the canonical schemas.
2. **Run this same eval suite against 1–2 real users** (not Claude evaluating Claude). The skill performs well under model self-execution; real users will probably surface different patterns — especially around whether the output FEELS useful, whether they continue the flow, and whether the methodology stays out of the way for simple requests.
3. **Run the lint script in a release-gate context** (e.g., `scripts/release.sh` that fails the release if `scripts/lint.sh` returns non-zero).

If 1–3 land cleanly, **v1.0 is ready for public release**. The skill's invariants (anti-false-mastery, four-gate sequence, scoped roadmap, aligned-vs-installed, canonical schemas) all held under blind execution. No correctness gaps were found.

---

## Honesty caveat (repeated)

This dogfooding pass used three Claude sub-agents executing the skill against blind prompts. That is **the floor of expected behavior** — model-self-execution under instruction. It is NOT equivalent to a stranger reading SKILL.md cold and producing the expected behavior. The remaining unknown is human factors: pacing, comprehension, willingness to engage with the methodology, and whether the skill feels useful versus bureaucratic in real work.

Recommend: 3 human dogfood cycles (1 with each: a learn-from-scratch task, a long-source ingest, a collaborative session) before declaring v1.0.
