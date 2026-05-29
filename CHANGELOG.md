# Changelog

All notable changes to mind-bridge will be documented in this file. Loosely based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## Historical note (read before older entries)

Earlier versions used different names for some concepts. Mappings:

- **"Work modes A–E"** → **"Execution modifiers"** (since v0.4). The letter labels were confusing because "mode" was already used for Modes 1–14. They are modifiers (Fast / Precise / Product / Implementation / Communication) that shape any mode's behavior, never used standalone.
- **`templates/validation-report.md`** and **`templates/validation-rubric.md`** → consolidated into **`templates/validation.md`** in v0.3.
- **`templates/learning-flow.md`** → removed in v0.3 (duplicated `modes/learn.md`).
- **`CURRENT LEVEL`** field → deprecated in v0.3.1 (replaced by separate `TARGET LEVEL` / `TAUGHT LEVEL` / `VALIDATED LEVEL`).
- **Level values in Spanish** (`reconocer / explicar / aplicar / implementar / ensenar`) → **ASCII English** (`recognize / explain / apply / implement / teach`) in v0.4. Display can still be in Spanish; the stored value is ASCII.
- **`installed` after Duo/Group 30s validation** → **`aligned`** in v0.4. `installed (collective)` requires per-participant full mini-rubric.
- **"Partial source → no roadmap"** → in v0.4, distinguish: partial source produces a **scoped roadmap**, never a full-source definitive roadmap.

Older entries below describe the state at the time. Refer to this section if a name doesn't match the current files.

---

## v1.1.0 — English translation + frontmatter key rename (2026-05-28)

The entire skill — all 14 modes, templates, examples, `README.md` / `SKILL.md` / `PHILOSOPHY.md`, this changelog, and the test suite — was translated to English so it reads cleanly for an international audience. The skill stays **functionally bilingual**: it still activates on Spanish triggers, still follows the "respond in the user's language" rule, and `PHILOSOPHY.md` keeps its canonical Spanish phrases. No methodology, mode, router, or behavior changes.

### Changed
- **All content translated to English.** Canonical concept-package labels are now English (`CONCEPT` / `CENTRAL PATTERN` / `PROBLEM` / `MECHANISM` / `EXAMPLE` / `COUNTER-EXAMPLE` / `RELATIONS` / `USE` / `30-SECOND PITCH`). Output-block labels: `COBERTURA DE FUENTE` → `SOURCE COVERAGE`, `CRITERIO DE ÉXITO` → `SUCCESS CRITERION`, package `ESTADO` field → `STATE`. ASCII machine values (`recognize | explain | apply | implement | teach`, `installed`, `ready-for-validation`, ...) are unchanged.
- **Frontmatter key rename**: `level_objetivo` → `target_level` and `level_validado` → `validated_level` in `templates/library-entry.md` and all consumers (`modes/library.md`, `modes/meta-review.md`, `tests/manual-evals.md`, `tests/eval-results.md`). This removes the last half-Spanish identifiers from the canonical schema.

### Preserved (bilingual)
- Spanish activation triggers in every mode file, alongside the English ones (`Activation: "teach me X" — ES: "enséñame X"`).
- The "respond in the user's language" rule, plus Spanish-display references for levels and validation-report headers.
- Canonical Spanish phrases in `PHILOSOPHY.md`.
- The Spanish eval prompts in `tests/manual-evals.md` (they exercise Spanish-language activation), each with an English gloss.

### Migration notes (from v1.0)
- **No behavior or trigger changes.** Existing prompts — English or Spanish — activate the skill exactly as before.
- **Library frontmatter**: existing entries using `level_objetivo` / `level_validado` should migrate to `target_level` / `validated_level` on next edit. The library mode will guide this.

### Verified
- `scripts/lint.sh`: PASS (0 errors, 0 warnings).
- No unintended Spanish remains outside the deliberately bilingual surfaces (triggers, Spanish-display references, `PHILOSOPHY.md` phrases, the Spanish eval prompts, and historical entries in this file).

---

## v1.0.0 — First stable release (2026-05-26)

Built directly from the v0.5.2 release candidate. No code or methodology changes from v0.5.2 — only release metadata and README updates. The full v0.5 hardening and v0.5.1 / v0.5.2 patch chain stands as the substantive content of this release.

### Included
- **Canonical state machine**: individual states (`raw` / `packaged` / `ready-for-validation` / `partially-installed` / `installed` / `validated` / `applicable` / `teachable` / `stale`) + collaborative states (`aligned` / `shared explanation confirmed` / `installed (collective)`), defined in `templates/concept-package.md` and `templates/library-entry.md`, with the anti-false-mastery rule enforced in every mode that writes state.
- **Source coverage gates** (canonical: `templates/source-coverage-gates.md`): four-gate sequence (Content Acquisition → Source Completeness → Multimodal Coverage → TOC Verification), 8-field `SOURCE COVERAGE` block, hedge-per-mention rule (MF-1).
- **Scoped roadmaps**: partial sources produce scoped roadmaps with declared coverage / exclusions / confidence, never full-source "definitive" roadmaps.
- **Collaboration modes**: Mode 13 (Duo) and Mode 14 (Group) with participant-label blocking, silent vs sequential intake distinction, role-card assignment, anti-domination tracking via *visible contributions* (never airtime), and the `aligned` → `shared explanation confirmed` → `installed (collective)` progression.
- **Eval suite** (`tests/manual-evals.md`): 31+ evals covering all 14 modes + execution modifiers + v0.4 / v0.5 invariants (DD anti-overactivation, EE scoped roadmap, FF collaborative state, GG–KK individual-mode coverage).
- **Lint gate** (`scripts/lint.sh`): 29 deterministic checks, cwd-independent, exits non-zero on hard failure.
- **Release gate** (`scripts/release.sh`): lint runner + CHANGELOG entry check + SKILL.md headline + working-tree advisory.
- **Dogfood + persona-simulated beta records**: `tests/eval-results.md` (cooperative dogfood) and `tests/human-beta-results.md` (friction-inducing personas).

### Notes
- **Human-factors feedback remains welcome.** The v1.0 readiness signal came from rigorous simulation, not in-the-wild use. First real users are warmly invited to report friction — especially outputs that feel too long, too formal, or too ceremonial. The simulation surfaced no correctness gaps after MF-1; the unknown is human experience over multiple sessions.
- **No correctness blockers known** at release.

### Provenance
- Built from v0.5.2 release candidate.
- All v0.5.1 nice-to-haves (NH-1 through NH-6 in `tests/human-beta-results.md`) intentionally deferred to v1.0.1 / v1.1 — none blocked release.

---

## v0.5.2 — MF-1 hedge-per-mention patch (2026-05-26)

Single must-fix from the v0.5.1-rc1 persona-simulated beta (`tests/human-beta-results.md`). No architecture changes, no schema changes, no new modes, no nice-to-haves.

### Fixed
- **`templates/source-coverage-gates.md`** §4 TOC Verification Gate: added the **Hedge-per-mention rule (MF-1)**. When the same unverified section/chapter/segment appears more than once in a roadmap, the hedge must repeat on every substantive mention — not only at the top. A hedge once + N body mentions without hedge reads as assertion. Short-form hedges documented for repeated mentions (`(§N — convention, unconfirmed)`, `(chapter X — no TOC)`, `(segment Y — no verified timestamp)`). Covers papers, books, talks/videos, and manuals/docs uniformly.

### Added
- **`scripts/lint.sh`**: one deterministic presence check (`MF-1 hedge-per-mention rule present in source-coverage-gates.md`) to guarantee future edits can't accidentally remove the rule. No semantic check — that would over-engineer the linter.

### Readiness
- Lint: PASS (0 errors, 0 warnings).
- Release gate (`scripts/release.sh v0.5.2`): PASS.
- **v1.0 candidate** after release gate. Recommend one real human session (Session A flavor — learn from scratch) before tagging v1.0 if at all possible; otherwise ship with README note acknowledging readiness signal came from rigorous simulation.

### Not changed
- All v0.5.1 nice-to-haves (NH-1 through NH-6 in `tests/human-beta-results.md`) deferred to v1.0.1 / v1.1. None blocked beta.

---

## v0.5.1 — P2 polish after dogfood (2026-05-26)

Five 1–3 line edits identified by the v0.5.0-rc1 dogfood pass (8 evals + 3 scenarios, all PASS, no correctness failures). Plus a release-gate script. No methodology changes; no schema changes; no new modes.

### Fixed (P2 polish from `tests/eval-results.md`)
- **`modes/package.md`**: short-version-first is now the unambiguous default. The skill emits only the short version, then asks `expand to long version?`. Long version is only produced directly when the trigger explicitly requires it (e.g. "for library", "implementation", "full package").
- **`templates/serialization-formats.md`**: added pre-flight check — when a package contains a vendor-specific or version-specific claim (Stripe TTL, Kafka retention, Postgres version-X), run double-check via websearch BEFORE serializing, not after. Caveat-after-publication travels slower than the polished claim.
- **`modes/expand.md`**: added inference-with-acknowledgment escape hatch. If the user's prompt is specific enough to authorize the branch selection ("only failure modes", "no theory"), the skill can skip the explicit approval round but must enunciate the inference ("I'm reading your prompt as authorizing A+B+C+D; correct me if not").
- **`templates/source-coverage-gates.md`**: added rule against asserting section names from genre convention. When the user reports section numbers but not titles, don't claim `§6 = Related Work` etc. as facts — hedge with "typical convention for OSDI papers / manuals / textbooks — confirm with your copy". Same rule for book chapter titles and talk segment titles.
- **`modes/serialize.md`**: added explicit prohibition against inventing absolute numbers from user-provided ratios. If the user gave ratios (`>80% vs <20%`, `4x`, `3 out of 10`) but not absolute totals (`412 users`), do not invent the absolutes. If an illustrative number aids the serialization, prefix with `illustrative — replace with your real data before sending`. Especially load-bearing for CEO/exec pitches where a single number does half the work.

### Added
- **`scripts/release.sh`**: release-gate script. Runs `scripts/lint.sh`, verifies `CHANGELOG.md` has an entry for the target version (auto-detected as the topmost `## vX.Y.Z` entry, or passed as `release.sh vX.Y.Z`), checks SKILL.md headline values, and reports working-tree state if the repo is git-tracked. Exits non-zero on any hard failure. Read-only; does not tag or publish.

### Verified
- `scripts/lint.sh`: PASS (0 errors, 0 warnings) after edits.
- `scripts/release.sh v0.5.1`: PASS.
- All 5 P2 patches verified by targeted grep.

---

## v0.5.0 — Hardening pass (2026-05-26)

Quality and dogfooding hardening on top of v0.4.1. No methodology changes; no new modes. Adds smoke-test coverage, fixes leaked v0.4.1 spellings, and ships a deterministic lint script.

### Added
- **`tests/manual-evals.md`**: dedicated evals for the five modes that previously lacked smoke tests:
  - Eval GG — Mode 2 Package (known concept, no reteaching).
  - Eval HH — Mode 3 Serialize (multi-audience, no state mutation).
  - Eval II — Mode 5 Expand (scoped branch expansion to apply level).
  - Eval JJ — Mode 9 Library (save with confirmation gate, canonical schema).
  - Eval KK — Mode 11 Meta-review (full state coverage incl. collaborative).
- **`scripts/lint.sh`**: deterministic sanity-check runner (29 checks across 7 sections). Verifies SKILL.md metadata, canonical files, v0.4.1 stale-terminology invariants, collaboration airtime metric scope, canonical spellings, v0.5 state-machine + eval presence, and repo hygiene. Exits non-zero on hard failure; warns on soft-target overruns.
- **`examples/QUICKSTART.md`**: 137-line compact behavioral reference for the six most common usage patterns (Learn / Package / Serialize / Validate / Scoped roadmap / Duo aligned). Hedges against the "long examples teach long outputs" failure mode by showing the minimum useful output per pattern.

### Fixed
- **`modes/meta-review.md`**: state filter now covers ALL canonical states (9 individual + 3 collaborative). Adds explicit trajectory distinctions (individual installation / collaborative alignment / decay), per-package field list, and explicit stale-detection rule (status `stale` OR updated > 90 days with no usage signal). Previously omitted `aligned` and `ready-for-validation`, silently skipping collaborative and in-progress packages.
- **`templates/learning-roadmap.md`**: stored level enum migrated to ASCII canonical (`recognize / explain / apply / implement / teach`). Added canonical display↔stored mapping note matching `templates/library-entry.md` style. Spanish display labels preserved for human-facing output.
- **`examples/external-content-roadmap.md`** and **`examples/clrs-book-roadmap.md`**: roadmap schema values converted to ASCII canonical levels (12 + 3 lines respectively). Prose narrative left untouched.
- **`ready-for-validation` kebab spelling propagated** to all consumers that still used the spaced form: `modes/learn.md` (7 hits), `modes/package.md` (1, plus added missing `aligned` to its state enum), `templates/validation.md` (5), `examples/clrs-book-roadmap.md`, `examples/invisible-product-debt.md`, `examples/fencing-tokens.md`, `tests/manual-evals.md` (2). Same swap applied to `partially-installed`.
- **`tests/manual-evals.md`**: Eval EE and FF headings promoted from h3 to h2 for consistency with DD and the new GG–KK block. Eval ordering and content unchanged.
- **`scripts/lint.sh`**: soft-target warning logic corrected (was firing when description was healthily short).

### Not changed (deliberately deferred)
- No `references/file-index.md`: SKILL.md mode router and templates list already serve as the canonical index; a second index would create drift risk (the same kind v0.4.1 just cleaned up).
- Modes 6–8 and Modes 10/12–14 retain their existing dedicated eval coverage from earlier versions.
- `tests/manual-evals.md` heading inconsistency between older evals (A–CC mixed h2/h3 in places) was left untouched outside the DD–KK block — out of scope for this pass.

---

## v0.4.1 — Patch consolidation (2026-05-26)

Audit-driven cleanup pass. No new features. Reduces leakage of pre-v0.4 vocabulary and tightens canonical schemas.

### Fixed
- **Execution modifiers rename completed**: all remaining "Modo A/B/C/D/E" references across modes/, templates/, examples/, and tests/ renamed to the canonical Execution modifier names (Fast / Precise / Product / Implementation / Communication).
- **Collaboration dominance metric**: removed remaining time-percentage wording ("% del tiempo") from `modes/group.md` and `templates/collaboration-modes.md`; metric is now uniformly "visible contributions" (Claude has no airtime telemetry).
- **`examples/raw-intuition.md`**: state trajectory and library-save instruction no longer leak `installed` for an unvalidated concept.
- **`examples/duo-sync-session.md` and `examples/group-package-session.md`**: `VALIDACIÓN INSTALACIÓN` and "instalación sólida" replaced with `aligned` / `shared explanation confirmed` per v0.4 semantics. Closing blocks emit the explicit collaborative state.
- **`examples/clrs-book-roadmap.md`**: migrated from legacy `Estado:`-only block to the canonical 8-field `SOURCE COVERAGE` (multimodal triad: text / source / artifact coverage).
- **`modes/duo.md`**: `aligned` bar aligned to `templates/validation.md` (pattern + own explanation); the higher bar (pattern + mechanism + own example) is `shared explanation confirmed`.
- **`templates/concept-package.md`**: state machine table now includes `aligned`; spellings standardized to kebab-case (`ready-for-validation`, `partially-installed`) matching `templates/library-entry.md`.
- **`pendiente` → `pending`** for stored schema values across modes/learn.md, modes/package.md, modes/expand.md, and example/test schemas. Spanish display (`Pendiente`) preserved where appropriate.
- **`VALIDATED LEVEL: explicar sólido`** → split into `VALIDATED LEVEL: explain` + `CONFIDENCE: high`. Enum no longer breached.
- **`modes/repo-ingest.md`** and **`templates/book-processing.md`**: partial source now explicitly mentions scoped roadmap as the v0.4 option.

### Added
- **`tests/manual-evals.md`**: new Eval DD (anti-overactivation), Eval EE (scoped roadmap from partial source), Eval FF (group `aligned`, never `installed` from 30-second checks).

### SKILL.md
- Description trimmed from 870 to ~847 chars; removed redundant collaboration phrasing.
- Generic trigger `"learn X"` removed from Mode 1 row (kept `"teach me X"`, `"install this concept"`); Mode 12 trigger tightened from `"explain this codebase"` to `"analyze this codebase as concept packages"`.
- Library path softened from "by default" to "configured by the user" wording.
- `"validate what we just installed"` → `"validate what we just taught"` to avoid semantic leak.

### Not fixed (deferred)
- Modes 2, 3, 5, 9, 11 still lack dedicated evals in `tests/manual-evals.md`.
- `templates/learning-roadmap.md:16` Spanish-only level enum (cosmetic, schema unaffected).
- `modes/meta-review.md` state filter omits `aligned` / `ready-for-validation` (P2; affects meta-review coverage of collaborative/in-progress packages).

---

## [0.4.0] — 2026-05-24 — Consolidation pass

Architecture consolidation, not new features. Goal: less ambiguity, less duplication, better states, clearer progressive disclosure, fewer internal conflicts.

### Added

- `templates/source-coverage-gates.md` — **canonical** for the four gates (Content Acquisition, Source Completeness, Multimodal Coverage, TOC Verification) and the `SOURCE COVERAGE` block. Single source of truth; other files reference instead of duplicating.
- Anti-overactivation rule visible at top of `SKILL.md`: skip the methodology for plain definitions or quick questions.
- Compact roadmap mode in `SKILL.md`: 3–5 phases, core packages only, P1 expanded, next-3-actions close. Default when user wants speed or doesn't ask for full version.
- `aligned` collaborative state in concept-package state machine and library frontmatter. Distinguishes from `installed` (which now requires per-participant full mini-rubric).
- Scoped roadmap concept in `templates/learning-roadmap.md`: partial sources produce a scoped roadmap with declared coverage/exclusions/confidence, not a full-source definitive roadmap.
- Participant labels as blocking intake in `modes/duo.md` and `modes/group.md` (Collaboration Intake step 0).
- Sequential intake vs true silent intake distinction in `modes/duo.md` and `modes/group.md`.
- "Visible contribution count" tracking (observable, not time percentages) replaces the previous time-based asymmetry metric.
- Facilitation rule exceptions in `templates/collaboration-modes.md`: Claude can introduce content when (1) the group asks for teaching, (2) a source is loaded, (3) a factual dispute requires verification, (4) the current phase is teaching/installation.
- macOS metadata exclusion notes in `README.md` (`.DS_Store`, `__MACOSX`, `._*`).
- Historical note in this file mapping renamed/removed concepts.

### Changed

- **`SKILL.md` rewrite**:
  - `description` reduced to 860 chars (under 1024 limit, target <850).
  - Work modes A–E renamed to **Execution modifiers** (Fast / Precise / Product / Implementation / Communication).
  - Read rule rewritten: "Start by reading only the selected mode file. Then load only the templates/examples explicitly referenced by that mode and needed for the task. Do not load unrelated mode files." (Was: "read only that file" — too rigid.)
  - Anti-overactivation rule added.
  - Compact roadmap mode added.
  - ASCII canonical level values throughout.
  - Still under 500 lines (239).
- **`modes/ingest.md` reduced 443 → 179 lines** by moving gate rules to canonical `templates/source-coverage-gates.md`. Now operates as a router: source type → acquisition gate → coverage gate → magnitude estimate → output shape → load template.
- **`modes/duo.md`** and **`modes/group.md`**:
  - Participant labels are now blocking intake.
  - Sequential vs true silent intake declared explicitly.
  - "Visible contribution count" (observable) replaces time-percentage tracking.
  - Validation reports use `aligned` / `shared explanation confirmed` / `validated at explanation level` / `installed (collective)` instead of generic `installation`.
- **`templates/validation.md`**: "Group validations" section rewritten with the four-state collaborative vocabulary and the rule that 30-second per-participant explanations default to `aligned`, never `installed`. Level naming section added (ASCII canonical, Spanish display).
- **`templates/collaboration-modes.md`**: validation report format updated to per-participant evidence matrix mapping to collaborative states. Facilitation rule clarified with explicit exceptions for when Claude can introduce content.
- **`templates/concept-package.md`**: field values now ASCII canonical (`recognize | explain | apply | implement | teach`; `low | medium | high`). New collaborative state `aligned` in the `STATE` machine.
- **`templates/library-entry.md`**: frontmatter schema declared **canonical** (no other file defines a different one). ASCII level values. `level_objetivo` and `level_validado` separated. Status machine includes `aligned`.
- **`modes/library.md`**: removed duplicated frontmatter schema; references `templates/library-entry.md` as canonical. Notes legacy `level` field is forbidden.
- **`templates/learning-roadmap.md`**: `SOURCE COVERAGE` block aligned with canonical (4 coverage dimensions + scoped vs full distinction in the "Rules" section).
- **`templates/book-processing.md`**: `BOOK MAP` block split into two variants — "with TOC pasted" (use TOC names/numbers) and "without TOC" (no Part I / Part II / chapters; only field-level thematic blocks with explicit warning).
- **`examples/external-content-roadmap.md`**: updated to use new `SOURCE COVERAGE` schema; renamed to "scoped roadmap" since source is partial; fixes the previous contradiction between `State: partial` and `Can a definitive roadmap be produced?: yes`.
- **`examples/clrs-book-roadmap.md`** and **`examples/group-package-session.md`**: added "behavioral reference, not required output length" note at the top.

### Removed

- Time-percentage tracking for collaborative dominance (replaced by visible contribution count, observable in chat).

### Migration notes (from 0.3.x)

- **No breaking trigger changes.** All existing prompts continue to activate the skill.
- **Existing packages with old level values** (`reconocer` / `explicar` / etc.) should be migrated to ASCII (`recognize` / `explain` / ...) on next edit; display can remain in Spanish.
- **Existing collaborative sessions that declared `installed`** were probably `aligned` per v0.4 semantics. Re-validate per-participant mini-rubric if you want `installed (collective)`.
- **Examples using "Part I (chs 1–4)"** style (CLRS old version) were rewritten in v0.3.5 to topic-based; v0.4 hardens the template so the pattern can't return.

---



## [0.3.7] — 2026-05-24 — Content Acquisition Gate (source safety + token economy)

Detected in real-use test: user provided a URL to a JS-rendered article. The Skill attempted fetch, got only metadata, and **automatically continued** to secondary sources to build a preliminary map. Behavior was transparent (marked as preliminary), but spent tokens on work the user didn't request and produced a map that read as if based on the primary source. Calibration patch — no architectural change.

### Changed

- `modes/ingest.md`: added "Content Acquisition Gate (runs BEFORE the Completeness Gate)" — section 3a. Hard rule: if the primary source can't be acquired (JS-rendered + metadata-only, paywall, login, 404, lazy-load failure, corrupted PDF, unreliable extraction), **stop processing**, declare the access problem, **don't search/process secondary sources automatically**, **don't reconstruct from memory**, present a 6-option menu (paste content / browser PDF / screenshots / secondary sources with consent / metadata-only preliminary / stop). Required output block `CONTENT ACQUISITION` with the failure declaration. Explicit exception: if the user's initial prompt already requested secondary sources ("search for similar sources", "compare with other articles"), the gate doesn't trigger but secondary sources must be labeled with provenance.
- `modes/ingest.md`: added "Primary Source Boundary" rule for when the user chooses option 4 (secondary sources): never attribute to the original author details that come from secondaries; tag output as `secondary-source preliminary`; keep `confidence: low/medium`; mark each package with `not verified against primary source — paste primary content to upgrade`.
- `modes/ingest.md`: updated "Blog / URL" subsection and "Content extraction" Blog/URL line to point to the Content Acquisition Gate.
- `templates/learning-roadmap.md`: `SOURCE COVERAGE` block schema upgraded with two new fields: `primary source acquired: yes / no / partial` and `source origin: primary / secondary / metadata-only / mixed`. Existing fields preserved.

### Added

- `tests/manual-evals.md`: new "Eval CC — Web Ingest: JS-Rendered Primary Source Requires User Choice". Critical red flags: continuing automatically to secondary sources / websearch, reconstructing from memory, producing a roadmap based on metadata, implying the primary source was read. Tests three paths: initial gate trigger, user choosing paste content (option 1), user choosing secondary sources (option 4).

### Migration notes (from 0.3.6)

- No behavior change for sources that ARE successfully acquired (PDFs that parse, transcripts that pass, papers fully loaded, repos accessible). The gate only triggers on acquisition failure.
- Existing flows that used WebFetch successfully are unaffected.
- The gate trades a small bit of latency (waiting for the user's choice) for source safety and token economy. Net positive expected.

---

## [0.3.6] — 2026-05-24 — Multimodal Coverage Gate (transcript ≠ full source)

Detected in real-use test: processing a ~2h technical video transcript, the Skill produced an excellent conceptual roadmap (no chronological summary, proper packages, relations, validation questions, replay fragments) but declared `State: complete (verbatim transcript of the entire ~2h video)` + `Missing: no slides or attached notebook` + `Definitive roadmap?: yes`. For technical videos, complete transcript ≠ complete source — slides, on-screen code, executed notebooks, diagrams, visual outputs, and instructor gestures aren't captured in audio. Declaring the roadmap "definitive" overstates coverage. Small calibration patch — no architectural change.

### Changed

- `modes/ingest.md`: upgraded the video subsection to a "Multimodal Coverage Gate". Distinguishes three coverage dimensions: `text coverage` (transcript), `source coverage` (multimodal: slides/notebook/visuals), `artifact coverage` (referenced repos/datasets). Rules for the common case (complete transcript, no slides/notebook): declare `text coverage: complete` + `source coverage: partial`; qualify the roadmap as "definitive of the spoken content", not "definitive of the complete resource"; recommend which visuals to review. Added transcript-claim labeling rules (`according to transcript` / `speaker claim` / `needs verification before publication`).
- `modes/ingest.md`: `SOURCE COVERAGE` block schema upgraded with the three coverage dimensions. Hard rule added: `text coverage: complete` doesn't imply `source coverage: complete`; for "definitive of the complete resource" both must be complete.
- `templates/learning-roadmap.md`: `SOURCE COVERAGE` block schema aligned with the new three-dimension format.

### Added

- `tests/manual-evals.md`: new "Eval BB — Transcript Ingest: Complete Transcript, Partial Multimodal Source". Critical red flag: declaring `State: complete` + `Definitive roadmap?: yes` without differentiating text from source coverage. Tests both the first pass (transcript only) and the extension (when slides/notebook are added later).

### Migration notes (from 0.3.5)

- No behavior change for sources that don't have a multimodal dimension (plain text PDF, blog post, paper without figures). Those continue to report a single coverage value; the three-dimension schema accepts that case (set `source coverage: complete` if there's nothing multimodal).
- Existing roadmaps that declared "definitivo" for video transcripts can be regenerated with the updated gate.

---

## [0.3.5] — 2026-05-24 — TOC Verification Gate (book reference anti-hallucination)

Detected in real-use test: processing CLRS 4e with partial source (TOC not loaded), the Skill produced a methodologically excellent roadmap but used specific chapter numbers (Ch 22 for graphs, Ch 23 for MST, Ch 24 for shortest path) that don't match CLRS 4e's actual structure (verified from MIT Press materials: Ch 20 Elementary Graph Algorithms, Ch 21 MST, Ch 22 Single-Source Shortest Paths). The output included "validate against your TOC" caveat, but specific numbers remain too actionable — users read them as truth and act before verifying.

### Changed

- `templates/book-processing.md`: added "TOC Verification Gate (hard rule — reference anti-hallucination)" section. Hard rule: without user-loaded TOC, no specific chapter/section numbers — only topic-based references. With user-loaded TOC, extract mapping directly. For famous books the model "thinks it knows" (CLRS, K&R, Knuth, DDIA, SICP, etc.), explicit rule: fame doesn't authorize numbers from memory. Required output block `TOC VERIFICATION` with the load status. Explicit anti-pattern example: "Ch 22.1–22.4 — verify with your TOC" is still wrong because the number leads action.
- `modes/ingest.md`: added "Book / chapter (additional rule — TOC Verification Gate)" inside the Source Completeness Gate section, pointing to the canonical rule in `templates/book-processing.md`.
- `examples/clrs-book-roadmap.md`: **rewrote to demonstrate the gate correctly**. The previous version contained specific chapter numbers (e.g. "Ch 22.1–22.4", "Part VI (21–25)") that were either wrong or unverifiable from model memory. The new version intentionally has no chapter numbers — only topic-based references with `[topic candidate — verify with TOC]` annotation throughout, plus a prominent `TOC VERIFICATION` block declaring `TOC pasted: no`. The conceptual scaffolding (6 phases, 14 packages, success criterion, methodology, surgical reading recommendations) is preserved intact. Includes a closing section "Why this roadmap does NOT give chapter numbers" explaining the gate behavior.

### Added

- `tests/manual-evals.md`: new "Eval AA — Book Processing: Partial Source / TOC Verification". Critical red flag: giving specific chapter/section numbers without user-loaded TOC. Tests both first-pass (no TOC) and second-pass (TOC pasted) behavior.

### Migration notes (from 0.3.4)

- No behavior change for non-book content (PDF, paper, video, blog, codebase, etc.). The gate is scoped to books and long manuals with a TOC structure.
- The previous CLRS example with specific numbers should not be used as a template — that version contained verifiable errors. The current version is the canonical demonstration of correct gate behavior.

---

## [0.3.4] — 2026-05-24 — Precision guardrail for technical corrections

Detected in real-use test: when correcting a DP misformulation, the Skill said something like "if there's no optimal substructure, it isn't DP — it's just useful memoization". Acceptable in the classic optimization framing of DP, but too rigid in the broader use (DP also appears in counting, decision, probability, and combinatorics where "optimal" doesn't directly apply). Short calibration patch — no architectural change.

### Changed

- `templates/validation.md`: added short "Precision guardrail (technical corrections)" rule. Three layers to distinguish when relevant (pedagogical/canonical, strict domain, broad practical use). Canonical example: DP — "optimal substructure" is central for optimization problems; more generally, DP requires a well-defined recurrence over reusable / overlapping subproblems.
- `modes/validate.md`: brief reference to the precision guardrail pointing to the canonical rule in `templates/validation.md`.
- `tests/manual-evals.md`: Eval Y updated. Expected behavior now explicitly applies the precision guardrail (DP framed as "well-defined recurrence over reusable / overlapping subproblems"; optimal substructure labeled "canonical for optimization", not universal). New red flag added for the specific over-narrow formulation observed in the real test.

### Migration notes (from 0.3.3)

- No behavior change. The Skill still flags missing dimensions and still mentions optimal substructure — it now does so with scope. Other technical corrections (transactions, consensus, CAP-like properties) should apply the same guardrail when relevant.

---

## [0.3.3] — 2026-05-24 — Raw intuition guardrails (external refs + compact close)

Detected in real-use test: raw intuition decompression about "small features that erode product mental model" produced a substantively excellent output (separated invariant-breakage from precedent-debt, proposed candidate names, gave examples and counter-examples). Two refinements added without changing the core decompression logic.

### Changed

- `PHILOSOPHY.md`: added "External reference labeling" section with three explicit labels (`ejemplo ilustrativo` / `possible anchor` / `verify before publication`) and rules for when caveats can be relaxed (user-loaded source / loaded resource in session / well-known abstract concept used non-load-bearingly). Examples of correct and incorrect labeling.
- `modes/decompress.md`: added "External reference labeling (mandatory)" section pointing to the PHILOSOPHY rule, since this mode often proposes literary anchors that travel to real meetings. Added "Compact closing block (mandatory when decompression was long)" — closing block with pattern / candidate name / meeting phrase / `State: draft / needs validation` / next step. Triggered when output passes ~30 lines.
- `modes/glossary.md`: added brief "External reference labeling" section pointing to the PHILOSOPHY rule, since this mode is the most direct producer of anchor words from literature.
- `templates/concept-package.md`: quality rules for `EXAMPLE`, `RELATIONS`, and `SOURCE` updated to mention the external labeling rule. Specifically: "don't invent attribution to known authors to add weight."

### Added

- `tests/manual-evals.md`: new "Eval Z — Raw intuition with external reference guardrails and compact output". Tests both guardrails together with explicit red flags including the user's listed ones (reducing to "technical debt", serializing before decompressing, declaring intuition validated, using real examples without caveats, converting the frame into an anti-change veto).

### Migration notes (from 0.3.2)

- No behavior change to the underlying decompression flow. The two additions are: (1) external references that previously appeared as confident attribution now carry labels; (2) long decompression outputs now end with a compact block for quick handle.

---

## [0.3.2] — 2026-05-24 — Validation language precision patch

Detected in real-use test: validating DP from a single short explanation ("DP is basically caching recursion"), the Skill correctly identified the gap (memoization confusion, missing optimal substructure / state / recurrence / base cases / tabulation) but used `Validated level: Superficial Explain — 4/10` as the header. The word "validated" implies the user passed control questions; from a single explanation, the Skill at best **estimates** the level — it doesn't validate it.

Scoped patch (no behavior change in the underlying assessment; only the language of the report).

### Changed

- `modes/validate.md`: added "Evidence quality" section that classifies the evidence available before writing the report (`estimated` / `partial validation` / `validated`). Hard rule: a single short explanation produces an `estimated` report, never `validated`. Three report formats added — one per evidence state — each with the appropriate header label and a "To validate fully:" block where relevant.
- `templates/validation.md`: added "Validation evidence states" section. Explicit table mapping each state to its header label and report shape. Distinguishes the validation evidence state (about the report) from the package `STATE` (about the package over time), and shows how they map.

### Added

- `tests/manual-evals.md`: new "Eval Y — Estimated vs validated (Mode 4 on DP)". Primary red flag: claiming the user understands DP. Secondary red flag: using `Validated level` without acknowledging the evidence is a single short explanation. Protects language precision without changing the underlying assessment behavior, which was already correct.

### Migration notes (from 0.3.1)

- No package format change. The `VALIDATED LEVEL` field in `templates/concept-package.md` still uses the standard level names; what changed is the **header in the validation report** (Mode 4 output), which now distinguishes `Estimated level with current evidence:` from `Partially validated level:` from `Validated level:`.

---

## [0.3.1] — 2026-05-24 — Anti-false-mastery patch

Detected in real-use test: after teaching Raft (Mode 1), the skill marked `CURRENT LEVEL: Explicar sólido` and `STATE: installed` **before** the user answered any validation questions. This contradicts the skill's own philosophy (validation requires active demonstration, not skill-side declaration). Patch:

### Changed

- `templates/concept-package.md`: deprecated `CURRENT LEVEL` field. Replaced with three explicit fields — `TARGET LEVEL` (intake), `TAUGHT LEVEL` (teaching attempted), `VALIDATED LEVEL` (defaults to `pending`, only rises after Mode 4). Added explicit state machine table for `STATE` with two new states: `ready for validation` and `partially installed`. Added "Anti-false-mastery rule" section.
- `templates/validation.md`: added "State transitions" section with mini-rubric for `installed` (own explanation + mechanism + own example + counter-example or limit + application to new case). Distinguishes `installed` (mini-rubric) from `validated` (full per-level rubric at target level).
- `templates/library-entry.md`: updated frontmatter schema (`level_objetivo` + `level_validado` instead of `level`) and maturity states list with new states.
- `modes/learn.md`: added "Anti-false-mastery rule" and "Technical simplifications (technical honesty caveat)" sections. Step 7 (package) now explicitly enforces `VALIDATED LEVEL: pending` + `STATE: ready for validation` after teaching. Mode output now mentions state explicitly.
- `modes/package.md`: optional fields list updated; anti-false-mastery rule added with translation guidance from old `CURRENT LEVEL`.
- `modes/expand.md`: updated to raise `TAUGHT LEVEL` after expanding; `VALIDATED LEVEL` waits for Mode 4.
- `modes/validate.md`: report uses `Validated level` (not `Current level`) for clarity.
- `examples/fencing-tokens.md`: migrated to new schema, keeps `validated` final state with a note explaining the initial Mode 1 output had `ready for validation`.
- `examples/invisible-product-debt.md`: changed from contradictory `STATE: installed (not validated yet)` to coherent `STATE: ready for validation`.
- `examples/raw-intuition.md`: added explicit 3-level fields + state `packaged`.

### Added

- `tests/manual-evals.md`: new "Eval X — Anti-false-mastery (Mode 1 on Raft)" with explicit red flags for the original regression. This eval is the regression guard.
- Simplification caveat pattern (`MARKED SIMPLIFICATION` block) for teaching technical concepts at lower levels than their full subtlety. Example documented: Raft's "majority replication implies commit" simplification with the Figure 8 caveat as compressed branch.

### Migration notes (from 0.3.0)

- Old packages using `CURRENT LEVEL` should be translated to the three new fields. The mode files do this automatically when they encounter the old field.
- Old library entries with `level: ...` in frontmatter should migrate to `level_objetivo` + `level_validado`. The library mode will guide this on next edit.

---

## [0.3.0] — 2026-05-24 — Reduce, sharpen, publish

Focus of this pass: clarity, consolidation, and publication readiness. No new modes added; no behavior removed.

### Added

- `PHILOSOPHY.md` — Manifesto, canonical phrases, mine/refinery metaphor, anti-behaviors, forbidden phrases, tone reference. Loaded on demand only when the user asks about the methodology itself.
- `LICENSE` — MIT.
- `templates/validation.md` — consolidated rubric + report format (replaces `validation-report.md` and `validation-rubric.md`).
- TL;DR sections (3–6 lines) at the top of the 5 long examples (CLRS, group session, duo session, repo discovery, external content roadmap) so external readers can skim without reading 300+ lines.
- README sections: "What it is in 60 seconds", "Two key ideas" (concept package + surgical reading explained in 3 sentences each), "What this is NOT", explicit "Naming" rationale.

### Changed

- `SKILL.md` condensed from 336 → ~225 lines. Manifesto, canonical phrases, anti-behaviors moved to `PHILOSOPHY.md`. Core philosophy reduced to a 5-bullet block. Operating principles tightened.
- `README.md` rewritten around a 60-second pitch. Removed the giant operational modes table; replaced with a 3-row "Three ways to use it" (Solo / Duo / Group). Limitations section trimmed (full version in `PHILOSOPHY.md`).
- `modes/serialize.md` reduced from 89 → ~40 lines. Audience matrix and per-audience rules now live exclusively in `templates/serialization-formats.md`; the mode file only handles flow decisions.
- `modes/group.md` reduced from 324 → ~150 lines. Role card details moved to `templates/collaboration-modes.md`; mode file keeps flow + decisions + escalation rules.
- `templates/serialization-formats.md` simplified from 11 audiences to 6 canonical (developer, senior engineer, PM, CEO, non-technical, meeting/Slack) with an "Extending to other audiences" note explaining how to derive new ones.

### Removed

- `templates/learning-flow.md` — duplicate of `modes/learn.md`. References updated.
- `templates/validation-report.md` — absorbed into `templates/validation.md`.
- `templates/validation-rubric.md` — absorbed into `templates/validation.md`.

### Fixed

- README's repo-structure block referenced now-deleted template files. Updated.
- A few mode files still referenced `validation-report.md` / `validation-rubric.md`. All updated to `validation.md`.

### Naming

- `mind-bridge` was kept after explicit review. Alternatives considered (`concept-forge`, `idea-refinery`, `pattern-installer`) rejected as either too narrow or too committed to a single metaphor. Rationale in README.

### Migration notes (from v0.2)

- No behavior change for existing users. All modes work identically.
- If you forked v0.2 and edited the deleted template files, port your changes into `templates/validation.md` and re-reference `modes/learn.md` for the 11-step flow.

---

## [0.2.0] — 2026-05-24 — Collaboration modes

### Added

- **Collaboration modes**:
  - `modes/duo.md` — Mode 13. Two-person mental model sync with silent intake, comparison, and dual validation.
  - `modes/group.md` — Mode 14. 3–5 people with roles, skeptic round, group validation, and pods + meta-merge for groups >5.
- **Supporting templates** (some later consolidated in v0.3):
  - `templates/collaboration-modes.md` — protocols, role cards, anti-domination tracking.
  - `templates/serialization-formats.md` — consolidated audience formats.
  - `templates/book-processing.md` — surgical reading for long books.
  - `templates/validation-rubric.md` — detailed rubric per level (later merged into `validation.md` in v0.3).
  - `templates/learning-flow.md` — compact 11-step reference (later removed as duplicate in v0.3).
- **Gold-standard examples**:
  - `examples/clrs-book-roadmap.md` — surgical roadmap for CLRS.
  - `examples/duo-sync-session.md` — synthetic Duo session.
  - `examples/group-package-session.md` — synthetic Group session.
- **Publication scaffolding**:
  - `README.md` — public-facing intro.
  - `CHANGELOG.md` — this file.
- Operational mode mapping table in `SKILL.md`.
- Router entries for Modes 13 and 14.
- Collaboration Intake as a third extension to global calibration.

### Changed

- `SKILL.md` frontmatter: removed non-standard `when_to_use:` field. All triggering info folded into `description:` per [Anthropic best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices) — third person, pushy, bilingual triggers.
- `SKILL.md` description rewritten to combat undertriggering.
- Anti-behaviors section linked to collaboration modes.

### Migration notes (from v0.1)

- No breaking changes for individual users.
- If custom prompts relied on `when_to_use:`, content is now in `description:`.

---

## [0.1.0] — 2026-05-11 — Personal baseline

### Initial release

- **12 internal modes** (`modes/`): learn, package, serialize, validate, expand, meeting, decompress, glossary, library, ingest (magnitude-aware with Source Completeness Gate), meta-review, repo-ingest (discovery-based with no hardcoded taxonomy).
- **Templates**: concept-package, learning-roadmap, meeting-prep, validation-report, library-entry.
- **Examples** (gold-standard): fencing-tokens, invisible-product-debt, raw-intuition, external-content-roadmap, repo-discovery-example.
- **Manual evals**: `tests/manual-evals.md` with ~25 prompts.
- **Global calibration**: work modes A–E (fast / precise / product / implementation / communication), 5-blocking-3-recommended intake, evidence policy with DOUBLE-CHECK, stable IDs (P1, P2, ...), success criterion.
- **Anti-patterns** explicit: anti-academic, anti-summary, anti-index, anti-hardcoded-taxonomy.
- **Library writes** require explicit per-operation confirmation.

---

## Version strategy (roadmap)

### v0.1 — personal
Validated for one user (the author) over weeks of real use. Stable.

### v0.2 — collaborative modes
Added Duo and Group facilitation. Skill becomes useful beyond solo learning. Stable.

### v0.3 — publication polish (current)
Reduce, sharpen, prepare for external readers. No new behavior, just clarity and elegance. Stable for distribution.

### v0.4 — possible productization (under consideration)

Candidate threads, *not* commitments:

- **Library automation**. Today `modes/library.md` requires explicit per-operation confirmation. Could ship a separate "trusted library" mode where the user grants standing approval for a session.
- **Web app or VS Code extension**. A non-Claude-Code surface for users who want the methodology without the CLI.
- **Pre-built skill packs**. Domain-specific variants (mind-bridge for security learning, mind-bridge for ML papers, mind-bridge for legal docs) that override defaults.
- **Cross-session memory**. Right now packages saved to library are not retrieved automatically across sessions. A retrieval layer that surfaces relevant packages mid-conversation.
- **Telemetry for meta-review**. Mode 11 (meta-review) is manual today; could be data-informed if users opt in.
- **Public template registry**. Community-contributed templates for new domains (DSLs, research methodologies, legal frameworks).
- **Bilingual parity** — *delivered in v1.1.0*. Core methodology files were authored in Spanish first; v1.1.0 translated all content to English while keeping the skill functionally bilingual (Spanish triggers + respond-in-user's-language). English is now the canonical documented language; Spanish survives as triggers, display references, and the `PHILOSOPHY.md` phrase list.

None of these are scheduled. They get prioritized only if real usage exposes specific gaps.

### Versioning principles

- **Breaking changes to the router are flagged in CHANGELOG.** Mode file paths are part of the public contract.
- **Behavior preservation across minor versions.** v0.2.x and v0.3.x users get the same outputs for the same prompts unless a CHANGELOG entry says otherwise.
- **Major versions (1.0+) only when the methodology stabilizes for an external audience.** Currently still validating across more users.
