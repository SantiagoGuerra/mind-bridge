# Template — Learning roadmap

Loaded from Mode 10 when the magnitude of external content is high.

A roadmap **is not a document index**. It is an **active conceptual installation guide**. The "ROADMAP USAGE METHODOLOGY" section below is mandatory — without it the output feels like loose phases instead of a learning path.

## Full structure

```
LEARNING ROADMAP:

SOURCE:
  Type: [PDF / paper / long video / documentation / book / etc.]
  Topic:
  User purpose:
  Target level: [recognize / explain / apply / implement / teach]
  User context: [personal learning / concrete product / architecture / meeting / etc.]

SOURCE COVERAGE:  (mandatory)
  primary source acquired: yes / no / partial
    (if "no" or "partial": Content Acquisition Gate fired — see modes/ingest.md
     section 3a. If output is still produced, mark the exact origin.)
  source origin: primary / secondary / metadata-only / mixed
    (if "secondary" or "metadata-only": apply Primary Source Boundary;
     do not attribute to the original author; label as "secondary-source preliminary")
  text coverage: complete / partial / incomplete
  source coverage: complete / partial / incomplete
    (multimodal: slides, notebook, on-screen code, diagrams, figures —
     are they present when the original source had them?)
  artifact coverage: complete / partial / not applicable
    (repos, datasets, referenced papers — if applicable)
  Sections covered: [list]
  Sections / elements not covered: [list — include missing visuals/notebook]
  Parts at parsing risk: [images, tables, figures, etc. — empty if N/A]
  Confidence level: high / medium / low
  Can a definitive roadmap be produced?: yes / no
    (if source coverage is partial or source origin is secondary/metadata-only,
     qualify the scope: "definitive of the [spoken/textual] content / preliminary
     based on secondaries / preliminary based on metadata")

APPLICATION CONTEXT:  (mandatory with Product / Implementation modifier; omit with Fast modifier if the user chose personal learning)
  Product / project:
  Decision they want to make:
  Audience:
  Constraints:
  Important risks:
  What should come out of the learning:

SUCCESS CRITERION:  (always mandatory)
  By the end of this roadmap you should be able to:
  - [concrete and verifiable outcome 1]
  - [outcome 2]
  - [outcome 3]
  Every phase of the roadmap must connect to this criterion.

MAGNITUDE DIAGNOSIS:
  Magnitude: high
  Reason: [why it requires a roadmap and not a single package or map]
  Risk if packaged too soon: [what is lost if we compress]

CONTENT THESIS:
  [One sentence with the central idea the content argues.]

GENERAL MAP:
  [What system, domain, or problem the content describes as a whole, in 2–3 lines.]

DOUBLE-CHECK:  (mandatory if websearch was performed; omit if not applicable)
  What was verified:
  External sources used:
  What it confirmed:
  What it contradicted:
  What remains uncertain:
  Impact on the roadmap:

ROADMAP USAGE METHODOLOGY:
  1. This roadmap is not a summary of the content. It is a conceptual installation sequence.
  2. Do not open all phases at once. Phases exist to limit load, not to describe the document.
  3. Each package is learned with the full flow: central pattern → problem → mechanism → example → limits → relations → serialization → validation.
  4. First install Phase 1 completely. The other phases remain compressed.
  5. Within each phase, one package at a time. Do not expand several in parallel.
  6. Secondary and optional packages stay compressed until the user explicitly needs them.
  7. Validate each phase before advancing. If validation fails, do not advance; return to the weak package.
  8. If the target level is Implement, each phase must end with a practical decision or concrete tradeoff, not with theory.
  9. Branch expansion (Mode 5) happens only when the user says "I want to go deeper" or similar.
  10. If the user's context changes (their product, their specific problem), the roadmap is reordered, not rebuilt.

PHASES:

PHASE 1 — [Short descriptive name]
  Objective:
    [What this phase aims to achieve, in one sentence.]
  Why this phase goes here:
    [What dependency or conceptual prerequisite forces this phase to come before the following ones.]
  What should be installed by the end:
    [One clear sentence about the user's mental state when closing the phase.]
  Packages:
  P1. [Package name]
     - central pattern: [one sentence]
     - why it goes here: [dependency reason or immediate utility]
     - recommended level: [recognize / explain / apply / implement / teach]
     - open now: yes
  P2. [Package name]
     - central pattern:
     - why it goes here:
     - recommended level:
     - open now: no
  Phase validation:
    [2–4 concrete questions the user must be able to answer in their own words before moving to the next phase.]
  Next action:
    [What happens when the phase closes: validate, advance to Phase 2, deepen a branch, etc.]

PHASE 2 — [Name]
  Objective:
  Why this phase goes here:
  What should be installed by the end:
  Packages:
  P3. ...
  P4. ...
  Phase validation:
  Next action:

[... Phases 3–5 as content requires. "Conceptual core" must always be present; the others are optional.]

RECOMMENDED ORDER:
  P1, P2, P3, ... (global numbering across all phases)

CORE PACKAGES:
  [List of IDs: P1, P2, P5, ...] — the ones that must be installed to reach the target level.

SECONDARY PACKAGES:
  [List of IDs: P6, P7, ...] — useful but not blocking.

OPTIONAL PACKAGES:
  [List of IDs: P9, P10, ...] — only if the user wants to implement, debate, or teach.

FIRST PACKAGE TO INSTALL NOW (P1):
  [Expand ONLY this package with the long format from templates/concept-package.md.]

HOW TO CONTINUE FROM HERE:
  Maximum 3 options, expressed as a concrete action:
  1. Install the first package (expand now).
  2. Validate whether I already have the current phase installed.
  3. Reorder the roadmap according to my product / specific context.
```

**ASCII values are canonical for stored level fields** (`recognize / explain / apply / implement / teach`). Spanish display labels for human-facing output: `Reconocer / Explicar / Aplicar / Implementar / Enseñar`. Mapping is direct and stable. See `templates/library-entry.md` for the full schema.

## Rules

- **SOURCE COVERAGE is mandatory** in every roadmap. The canonical block lives in `templates/source-coverage-gates.md`. Decision on what to deliver:
  - If `Can a definitive roadmap of the complete resource be produced? = yes` → normal complete roadmap.
  - If `= no` but `Can a scoped roadmap be produced? = yes` → **scoped roadmap**: same structure (phases, packages with IDs, success criterion, methodology), but the title says `SCOPED ROADMAP (limited to [sections/part/fragment covered])`, and each phase declares what fell inside and what outside. Useful and honest. Does not replace the full roadmap of the entire resource.
  - If both `= no` (e.g. Content Acquisition Gate fired) → only preliminary diagnosis + questions to complete the source. Do not deliver any roadmap.
- **SUCCESS CRITERION is mandatory.** Defines what the user should be able to do when finished. Every phase must connect to this criterion.
- **APPLICATION CONTEXT is mandatory with the Product modifier or Implementation modifier.** If the user chose one of these modifiers without providing context, do not advance without asking.
- **DOUBLE-CHECK is mandatory if websearch was performed.** Activated by default with the Implementation modifier and for specific technical claims.
- **ROADMAP USAGE METHODOLOGY is mandatory.** Without that section, the output feels like phases without guidance and the user doesn't know how to start.
- **HOW TO CONTINUE FROM HERE is mandatory** and limited to a maximum of 3 options. More than 3 = another form of saturation.
- **Do not expand more than the first package (P1)** in the initial response. The rest stays compressed. Exception: if the user asked for "roadmap only, no expansion", expand none.
- **Stable IDs**: all packages carry IDs P1, P2, P3..., global numbering across all phases (do not restart per phase). The user can ask "open P4", "validate P2", "serialize P1 for meeting", "expand P7 to implement level", "reorder P3 by my product".
- The 5 phases **are not all mandatory**. Use only those the content requires. If there are only 3 natural phases, do not invent 2 more.
- "Conceptual core" (typically Phase 2) must always be present. The others are optional depending on content.
- Package names in the roadmap are **short and memorable**. Full expansion goes through Mode 1 or Mode 2.
- Always mark **provenance** (source / inference / translation / doubt) in each expanded package.
- The `open now: yes` flag must appear exactly once in the initial roadmap — on the first package of Phase 1 (P1). Everything else: `open now: no`.
- If the target level is low (recognize / explain), aggressively reduce optional packages.
- If the level is high (implement / teach), expand Phases 4 and 5 with more packages and end each phase with a practical decision, tradeoff, risk, or explicit technical artifact.

## Critical distinction

A roadmap **is not an index of the original document**. It is a pattern installation sequence. If Phase 1 corresponds to Section 1 of the PDF and Phase 5 to Section 12, you are probably summarizing instead of packaging. Reassess and regroup by transversal patterns, not by order of appearance in the document.
