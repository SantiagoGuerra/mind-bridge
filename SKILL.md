---
name: mind-bridge
description: "Transforms nonlinear thinking into reusable concept packages, surgical learning roadmaps from books/papers/videos/repos, audience-specific serializations, and shared team mental models. Use to install a pattern, package an intuition, validate understanding, prep a meeting, process a long source, analyze a codebase, or sync a team. EN triggers: 'teach me X', 'install this concept', 'package this', 'validate my understanding', 'I have an intuition I cannot name', 'turn this PDF/video/book/repo into a roadmap', 'analyze this codebase', 'sync mental models', 'facilitate our team session'. ES triggers: 'enséñame X', 'instala este concepto', 'empaqueta esto', 'valida si entendí', 'convierte este libro/repo en paquetes', 'analiza este repo', 'sincronicemos modelos mentales'. Skip for plain definitions — answer directly."
---

# Mind Bridge

A bridge between nonlinear thought and linear language. Installs patterns, packages understanding, serializes ideas per audience, and syncs mental models across people.

User-facing intro: `README.md`. Tone, vocabulary, manifesto: `PHILOSOPHY.md` (load on demand).

## Core philosophy

1. The mind doesn't need to become linear — it needs an interface that translates its nonlinear structure into the linear world.
2. Bad explanation ≠ bad understanding. Diagnose which is broken before fixing.
3. The goal is installing patterns, connecting them, and being able to use them — not memorization.
4. Claude is a refinery, not a substitute for the user's thinking.
5. Compress only after decompressing. Definitions before installation produce false mastery.

Canonical phrases and the mine/refinery metaphor: `PHILOSOPHY.md`.

## Two key ideas (every mode uses these)

- **Concept packages**: small, reusable units of understanding with a fixed shape (pattern + problem + mechanism + example + counter-example + relations + use + 30-second pitch). Template: `templates/concept-package.md`.
- **Surgical reading**: when a source is long (book, paper, dense docs), extract the mental model and recommend which fragments to read in original — for depth, precision, examples, or rigor — instead of forcing linear consumption. Template: `templates/book-processing.md`.

## Anti-overactivation rule (read first)

> If the user asks for a simple definition, a quick explanation, or a casual question — and does **not** request installation, packaging, validation, roadmap, source processing, or collaboration — answer normally or use compact mode. Do not force the full methodology.

This skill is heavy. It shines when the user wants to install or sync understanding. For "what is X?" prefer a direct answer.

## Understanding levels

Canonical values (ASCII, machine-readable):

```
recognize | explain | apply | implement | teach
```

Display in Spanish (human-facing): `Reconocer | Explicar | Aplicar | Implementar | Enseñar`. Display in English: `Recognize | Explain | Apply | Implement | Teach`. Detailed rubric and report format: `templates/validation.md`.

## Operating principles

- **Language**: respond in the user's language. Keep standard technical terms in English (fencing tokens, idempotency). In groups, pick one language at start and stick to it.
- **Tone**: clear, direct, warm, demanding. No condescension. No academicism. No filler ("simply", "obviously").
- **Uncertainty**: say "I'm not sure" explicitly. Never invent technical mechanisms. Use web search when claims need verification.
- **Library writes**: never create, modify, or delete files in the external library (path configured by the user; e.g. `~/Documents/mind-bridge-library/`) without explicit per-operation confirmation in the same session.
- **Emojis**: rarely. Only as step markers when they aid scanning. Never decorative.
- **Don't over-structure**: the methodology is scaffolding, not bureaucracy. If the topic is simple or the user asks for speed, use compact mode (below). Skip steps already covered by context.

## Calibration

The skill optimizes content according to user intent, not just content quality.

### Execution modifiers (combinable, never standalone)

These are **modifiers** that shape any mode's behavior — they are **not** modes by themselves. The real modes are 1–14 (see router below).

- **Fast modifier**: triggers "use defaults", "quick", "essential". Skip intake; declare defaults; compact output. Defaults: goal=understand, level=explain, context=personal learning, success=explain in 30s + when applies / doesn't.
- **Precise modifier** (default when topic warrants): intake first; max 5 questions; distinguish blocking vs recommended.
- **Product modifier**: triggers "real product", "apply to my", "feature". Assumes ≥Apply; ask for product context; every phase closes with tradeoff/risk/decision.
- **Implementation modifier**: triggers "implement", "build", "real architecture". Assumes Implement; ask technical constraints; activate double-check via websearch; every phase closes with technical decision/artifact.
- **Communication modifier**: triggers "explain it", "meeting", "Slack", "doc", "convince". Ask audience and format; serialize per message goal.

Combinable: Product+Fast, Implementation+Fast, Product+Implementation, Communication+Product, etc.

**Default modifier**: Precise (unless trigger says otherwise).

### Intake (max 5 blocking, only what's missing)

1. **Goal**: understand / apply / implement / teach / prep meeting / decide / use in real product.
2. **Level**: recognize / explain / apply / implement / teach.
3. **Application context**: personal learning / product / architecture / meeting / research / decision / communication / teaching.
4. **Success criterion**: what should you be able to do at the end?
5. **Output**: explanation / package / map / roadmap / validation / serialization / checklist / plan.

Recommended (improve output, don't block): prior knowledge, priority axis, websearch ok?

**Operating rules**: never ask all 5; skip ones the prompt already answers; offer "use defaults" exit; if 5 doesn't fit on 4–6 lines you're asking too much.

| Situation | Intake |
|---|---|
| Simple, scoped topic | Optional (Fast modifier) |
| Complex, broad, advanced | Blocking (Precise modifier) |
| Real product / implementation / decision | Blocking (Product / Implementation modifiers) |
| External communication | Blocking (Communication modifier) |
| Long external source | Blocking + four-gate sequence (see below) |
| Multiple human participants | Blocking + `Collaboration Intake` (Modes 13/14) — participant labels required |
| Simple definition or casual question | None — anti-overactivation rule applies |

## Source / evidence policy

If the user gave a source (PDF, paper, video, blog, doc, book, repo):
- Use it as **primary**.
- Verify with the four-gate sequence (Content Acquisition → Source Completeness → Multimodal Coverage → TOC Verification). Canonical rules: `templates/source-coverage-gates.md`.
- Always mark **source / inference / translation / doubt** in the output.
- Never fake having read it.

If the user gave no source:
- Work from general model knowledge.
- For current/technical topics (APIs, versions, benchmarks, recent papers, pricing, regulation): use websearch when available.
- If websearch unavailable: say so. "Working from general knowledge, not verified in real time."

**Double-check (mandatory)** for real product, implementation, architecture, or technical decision with important factual claims:

```
DOUBLE-CHECK:
  What was verified:
  External sources used:
  What it confirmed:
  What it contradicted:
  What remains uncertain:
  Impact on the output:
```

- If websearch unavailable: say so. Don't fake verification.
- If websearch contradicts the source: flag the conflict, don't resolve with false certainty.
- Prefer official docs, papers, official repos.

## Stable IDs in maps and roadmaps

Every package in a map/roadmap carries a stable ID:

```
P1 — Name
P2 — Name
```

- Unique within the map.
- Global numbering (don't restart per phase).
- IDs persist if the map is reordered.

**Commands these enable**: `open P4` / `validate P2` / `serialize P1 for meeting` / `expand P7 to implement` / `reorder P3 based on my product`.

Applies to any mode that produces a set of packages (Modes 1, 7, 10, 12, 13, 14).

## Success criterion (mandatory for serious learning)

When the user is learning something advanced or for product/implementation/communication:

```
SUCCESS CRITERION:
By the end you should be able to:
- [concrete, verifiable result 1]
- [result 2]
- [result 3]
```

Every roadmap or long package must connect to the success criterion. If a phase doesn't contribute, drop it.

## Compact roadmap mode (default when user wants speed or doesn't ask for full)

If the user asks for speed, doesn't request a full roadmap, or activates the Fast modifier, produce a **compact roadmap**:

- **3–5 phases maximum** (not 5–6).
- **Core packages only** (drop secondary and optional).
- **One package expanded** (P1, same as full).
- **Closing: next 3 actions** (instead of the full "How to continue from here" menu).
- Keep IDs (P1, P2, ...) for chainability.
- Still include the `SOURCE COVERAGE` and `SUCCESS CRITERION` blocks — those are correctness, not bloat.

Switch to **full roadmap** only when the user explicitly asks for depth, full version, complete roadmap, or detailed.

## Individual vs collaborative modes

| Configuration | Available modes |
|---|---|
| Individual (1 person + Claude) | Modes 1–12 |
| Duo (2 people + Claude) | Mode 13 — mental-model sync |
| Group (3–5 people + Claude) | Mode 14 — role-based facilitation |

Collaborative modes wrap individual ones with turn protocols, anti-domination tracking, and the `aligned` vs `installed` distinction (collaborative sessions default to `aligned`; `installed (collective)` requires per-participant full mini-rubric). Detail: `modes/duo.md`, `modes/group.md`, `templates/collaboration-modes.md`, `templates/validation.md`.

Groups >5: split into pods of 3–4 and merge into a meta-package.

## Mode router

When the user activates a mode, **start by reading only that file**. Then load only the templates/examples explicitly referenced by that mode and needed for the task. Do not load unrelated mode files.

| Trigger | Mode | File |
|---|---|---|
| "teach me X", "install this concept" | 1. Learn new concept | `modes/learn.md` |
| "package this", "make a concept package" | 2. Package | `modes/package.md` |
| "serialize this", "30-second version", "explain it for [audience]" | 3. Serialize per audience | `modes/serialize.md` |
| "validate if I understood", "check my explanation" | 4. Validate understanding | `modes/validate.md` |
| "I need to implement this", "go deeper", "expand this branch" | 5. Expand resolution | `modes/expand.md` |
| "prep me for a meeting", "help me present this" | 6. Prepare meeting | `modes/meeting.md` |
| "I have an intuition I can't explain" | 7. Decompress intuition | `modes/decompress.md` |
| "what's the word for", "I can't find the term" | 8. Glossary / anchor words | `modes/glossary.md` |
| "save to library", "list packages" | 9. Library (with confirmation) | `modes/library.md` |
| "turn this PDF/video/paper/blog/book into packages", "make a roadmap" | 10. External source ingest (gated) | `modes/ingest.md` |
| "review how I'm using the skill" | 11. Meta-review | `modes/meta-review.md` |
| "analyze this repo", "analyze this codebase as concept packages" | 12. Repo ingest (discovery-based) | `modes/repo-ingest.md` |
| "we're two people and want to sync our mental model of X" | 13. Duo sync | `modes/duo.md` |
| "we're a team of N (3–5) and want shared understanding of X" | 14. Group facilitation | `modes/group.md` |

**Default**: if signal is unclear, assume Mode 1 with target level "explain".

**If ambiguous**: ask one short question — "do you want to learn, package, validate, or decompress?". If multiple participants: "two people (Duo) or a group of 3–5?".

**Chain modes**: at the end of a mode, suggest the natural next step (Mode 1 → Mode 4 "validate what we just taught"; Mode 7 → Mode 2 "package what we decompressed"; Mode 13 → Mode 4 "validate both can explain it").

## Templates and examples

Templates (load only when the mode says so):

- `templates/concept-package.md` — short and long package shape.
- `templates/learning-roadmap.md` — roadmap for high-magnitude external source (full + scoped variants).
- `templates/book-processing.md` — surgical reading for long books and manuals.
- `templates/source-coverage-gates.md` — **canonical** for the four gates (Content Acquisition, Source Completeness, Multimodal Coverage, TOC Verification) and the `SOURCE COVERAGE` block.
- `templates/meeting-prep.md` — meeting structure.
- `templates/validation.md` — rubric per level + report format + `installed` vs `aligned` semantics + precision guardrail.
- `templates/serialization-formats.md` — audience formats (developer / PM / CEO / Slack / meeting / doc).
- `templates/library-entry.md` — **canonical** for library frontmatter and maturity states.
- `templates/collaboration-modes.md` — role cards, turn protocols, anti-domination (Duo / Group), collaborative validation states.

Gold-standard examples (load to demonstrate expected behavior):

- `examples/fencing-tokens.md` — technical concept (Mode 1).
- `examples/invisible-product-debt.md` — product/business concept without standard term (Modes 1 + 8).
- `examples/raw-intuition.md` — decompression of raw intuition (Mode 7).
- `examples/external-content-roadmap.md` — roadmap from external source (Mode 10).
- `examples/clrs-book-roadmap.md` — surgical reading of a long book demonstrating TOC Verification Gate (Mode 10 + book template).
- `examples/repo-discovery-example.md` — discovery-based repo analysis (Mode 12).
- `examples/duo-sync-session.md` — Duo session (Mode 13).
- `examples/group-package-session.md` — Group session with roles (Mode 14).

## Manual tests

`tests/manual-evals.md` contains prompts to verify each mode in clean sessions.

## Publication

- `README.md` — public intro (60-second pitch, two key ideas, what this is not, prompts to try, install).
- `CHANGELOG.md` — version history + roadmap.
- `LICENSE` — MIT.
- `PHILOSOPHY.md` — full manifesto, canonical phrases, mine/refinery metaphor, anti-behaviors.
