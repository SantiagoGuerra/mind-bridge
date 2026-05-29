# Mode 10 — External input to packages (operative router, magnitude-aware)

Activation: "turn this PDF/paper/video/blog/book/repo into packages", "build me a roadmap of this content", "I want to learn this material", "extract packages from this documentation", "analyze this PDF" — ES: "convierte este PDF/paper/video/blog/libro/repo en paquetes", "hazme un roadmap de este contenido", "quiero aprender este material", "extrae paquetes de esta documentación", "analiza este PDF".

## What this mode does

It is an **operative router** over 5 steps:

```
1. Identify source type
2. Acquisition gate     → could the resource be obtained?
3. Coverage gate        → is the obtained content complete? (text / source / artifact / TOC)
4. Magnitude estimate   → single package / map / roadmap?
5. Output shape         → load the needed template, produce the output
```

The detailed rules for the gates **do not live here**. They live in `templates/source-coverage-gates.md` (canonical). This file only invokes and orchestrates.

## Relationship to the global calibration

This mode assumes the global calibration from SKILL.md:

- Execution modifiers (Fast / Precise / Product / Implementation / Communication).
- Blocking + recommended intake.
- Evidence Policy + DOUBLE-CHECK with websearch.
- Stable IDs (P1, P2, ...).
- Mandatory success criterion for serious learning.
- Compact roadmap mode by default if the user doesn't ask for depth.

## 1. Identify source type

Categorize at the start. Each type triggers specific gates:

| Source type | Gates typically triggered |
|---|---|
| PDF (short, parses) | Source Completeness (if chunked) |
| PDF (long) | Source Completeness + Multimodal if figures matter |
| Academic paper | Source Completeness (trap: abstract only) + Multimodal if figures |
| Short / long video | **Multimodal Coverage** (transcript ≠ source) + Completeness if partial transcript |
| Blog / public URL | **Content Acquisition** (JS-rendered, paywall) + Completeness |
| Book / chapter | **TOC Verification** + Completeness if only some chapters |
| Technical documentation | Source Completeness + versioning (DOUBLE-CHECK) |
| Pasted transcript | Multimodal (no visuals) |
| Repo / codebase | Source Completeness + see `modes/repo-ingest.md` |
| Mixed content | Multiple gates per component |

## 2. Acquisition gate

Before any extraction, verify acquisition. If it fails: **stop processing**, declare the problem, offer the 6 options (paste / browser PDF / screenshots / secondary sources / metadata-only / stop), and wait for a decision.

Full rules: `templates/source-coverage-gates.md` section 1.

Mandatory block if triggered: `CONTENT ACQUISITION` (format in the canonical file).

## 3. Coverage gates

If acquisition passed, run in order:

- **Source Completeness Gate** — is what was obtained complete? If not, offer a **scoped roadmap** (not a full-source roadmap). Rules: `templates/source-coverage-gates.md` section 2.
- **Multimodal Coverage Gate** — for videos / content with visuals: distinguish text coverage / source coverage / artifact coverage. Rules and claim labeling (`according to transcript` / `speaker claim` / `needs verification before publication`): `templates/source-coverage-gates.md` section 3.
- **TOC Verification Gate** — for books/manuals: without a pasted TOC, do not emit chapter/section numbers. Rules: `templates/source-coverage-gates.md` section 4 + `templates/book-processing.md`.

Unified output: the canonical `SOURCE COVERAGE` block (defined in `templates/source-coverage-gates.md`).

## 4. Magnitude estimate

Criteria to evaluate:

- Content length.
- Number of detected concepts.
- Conceptual density.
- Number of domains involved.
- Dependencies between concepts.
- User's target level.
- Existence of a natural learning sequence.

### Classification

**A. Low magnitude / Atomic** — 1 main concept, short content, installable in one session. **Output**: single package + 30s pitch + short validation.

**B. Medium magnitude / Cluster** — 2–7 related concepts. **Output**: package map + relations + expanded main package + compressed secondary ones.

**C. High magnitude / Roadmap** — 8+ concepts, long content, dependencies, multiple abstraction layers. **Output**: roadmap by phases (`templates/learning-roadmap.md`). Expand only P1.

### Quick heuristic

| Signal | Output |
|---|---|
| 1 main concept | single package |
| 2–7 concepts | package map |
| 8+ concepts, dependencies, multiple sections, video > 30 min | roadmap |
| User asks for "accelerated learning" or "I want to learn this material" | prefer roadmap if in doubt |
| User asks for "give me the main concept" | single package (warn about compressed branches) |
| User asks for "explain everything" | roadmap, never mega-summary |
| Fast modifier or user not asking for depth | **compact roadmap** (3–5 phases, core only, P1 expanded) |

## 5. Output shape

Before producing the final output, show a diagnostic:

```
SOURCE:
  Type:

GATES:
  acquisition: [pass / fail with detail]
  completeness: [complete / partial / incomplete]
  multimodal: [N/A / complete / partial]
  TOC verification: [N/A / TOC loaded / no TOC]

MAGNITUDE: Low / Medium / High

DECISION:
  [Single package / Map / Full roadmap / Scoped roadmap / Compact roadmap]

REASON:
  [why this output]

SUGGESTED LEVEL:
  [from intake]
```

The user can ask to change the decision.

### Produce the output

- **Single package** (low magnitude): use the long format from `templates/concept-package.md`. Close with short validation. ID: P1.
- **Package map** (medium magnitude): expand P1 short, secondary ones compressed (1 line), explicit relations, learning order. IDs P1..Pn.
- **Full roadmap** (high magnitude + acquisition + completeness OK): load `templates/learning-roadmap.md`. Only P1 expanded. Compact mode by default if the user doesn't ask for depth.
- **Scoped roadmap** (high magnitude + completeness partial): same structure, title says `SCOPED ROADMAP`, each phase declares what's in/out. See `templates/learning-roadmap.md` "Rules".
- **Diagnostic only** (acquisition fail OR completeness incomplete + scoped not applicable): questions to complete the source, no roadmap.

## Critical rules (anti-patterns)

### Anti-overwhelm

> "Do not try to install all the long content in a single response. For large content, first create the roadmap and only expand the first package or the most important one. Leave the rest compressed."

### Anti-summary

> "Do not turn a PDF/video/blog into a traditional linear summary. The goal is not to summarize; it is to convert the content into learnable concept packages, relations, and an installation roadmap."

Sign of a summary: the output reproduces the structure of the original document.

### Anti-index

A roadmap is not an index of the document. If Phase 1 = Section 1 of the PDF and Phase 5 = Section 12, you are summarizing. Regroup by cross-cutting patterns.

### Provenance marking

Global rule (see Evidence Policy in SKILL.md). In each package, distinguish: **From the source / Translation / Inference / Doubt**. Inline mark or footnote.

### Errors or claims without evidence in the source

Mark them. Do not filter silently:

> "⚠️ The source claims X without evidence. I leave it marked but won't incorporate it into the package without validation."

## Chaining

- Validate understanding of the input → Mode 4.
- Formally package one by one → Mode 2.
- Save to library → Mode 9 (with confirmation).
- Find a name for a pattern without a term → Mode 8.
- If the input triggers a personal intuition → Mode 7.
- Expand the next package from the roadmap → continue here or move to Mode 1.
- "Expand P7 to implement level" → Mode 5 + Implementation modifier.
- "Serialize P1 for a meeting" → Mode 3 + Communication modifier.

## References

- **Canonical gates**: `templates/source-coverage-gates.md`.
- Package: `templates/concept-package.md`.
- Roadmap (full + scoped): `templates/learning-roadmap.md`.
- Books (TOC discipline): `templates/book-processing.md`.
- Gold-standard examples:
  - `examples/external-content-roadmap.md` — roadmap from an external source.
  - `examples/clrs-book-roadmap.md` — TOC Verification Gate in action.
- Global calibration, modifiers, intake, evidence policy, IDs, success criterion, compact mode, anti-overactivation: `SKILL.md`.
