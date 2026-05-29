# Mode 12 — Software Artifact / Repo Ingest (discovery-based)

Activation: "analyze this repo", "what does this code do", "extract packages from this repository", "install this repo in my head", "explain this codebase", "onboarding for this repo", "turn this repo into packages" — ES: "analiza este repo", "qué hace este código", "extrae paquetes de este repositorio", "instálame este repo en la cabeza", "explícame este codebase", "onboarding de este repo", "convierte este repo en paquetes".

## Relationship to the global calibration

Assumes the global calibration from SKILL.md (Execution modifiers, intake, evidence policy, stable IDs, success criterion). This mode is the specialized layer for software artifacts (repos, codebases, code packages).

The **Source Completeness Gate** also applies (canonical: `templates/source-coverage-gates.md` section 2) — partially accessible repo / unread files / uninspected build artifacts → do not produce a full-source roadmap. A **scoped roadmap** bounded to what was covered may be produced.

## Central principle

Packages must **emerge from the repository's evidence**, not from a predefined taxonomy.

> **Guiding phrase**: "I am not applying a template to the repo. I am discovering what mental model this specific repo requires."

## NO hardcoded package taxonomy (hard rule)

### Forbidden

- "Since this looks like React, the packages are routing / components / state / hooks..."
- "Since this looks like a runtime, the packages are execution model / scheduler / memory / parser..."
- "Since this looks like research code, the packages are dataset / model / training / evaluation..."
- "Since this looks like a library, the packages are public API / internals / extension points..."
- "Since this looks like a game, the packages are game loop / entities / rendering / input..."

### Allowed

- Use the artifact type as an **exploration hypothesis** (what to look for).
- Confirm or discard hypotheses with **concrete paths**.
- Create packages **only when there is sufficient evidence**.
- Mark any inferred but unconfirmed package as a **hypothesis**.

### Each package must have

- Evidence in paths.
- Clear responsibility.
- Usefulness for the user's goal (from the global calibration).
- Relationship to other packages.
- Explicit confidence level.

## Package discovery flow from evidence

### 1. Inventory without interpretation

Look at the repo without labeling. Note (without opining):

- File tree (directory structure).
- Detected languages.
- Configs (package.json, pyproject.toml, Cargo.toml, Makefile, Dockerfile, etc.).
- Dependencies (manifests).
- Scripts (build / test / dev / deploy).
- Docs (README, CONTRIBUTING, ADRs, /docs).
- Tests (folders and patterns).
- Probable entrypoints (binaries, main, server, cli, index).

This is collection only. Not interpretation yet.

### 2. Tentative classification (descriptive, not prescriptive)

Mandatory block format:

```
ARTIFACT CLASSIFICATION:
  Tentative type:
  Evidence:
  Confidence: high / medium / low
  Possible alternatives:
  How this shapes exploration:
  What I will NOT assume yet:
```

Example of correct language:

> "Looks like a library because there are package exports, public API tests, and examples. But I won't assume its packages are 'public API / internals / extension points' until I review where the real responsibilities live."

**The classification does NOT generate packages**. It only guides where to look next.

### 3. Detect centers of gravity

Look for zones of the repo that concentrate meaning. Not all repos have all of them; use what applies:

- Entrypoints (main, index, cli, server, runner).
- Exported public APIs.
- Modules with many imports (imported by many others).
- Modules with domain names (not generic like `utils`).
- Main loops / execution loops (if they exist).
- Processing pipelines (if present).
- Interfaces / contracts / schemas.
- Important tests (those covering core flows, not helpers).
- Examples / demos.
- Central configs (not tooling).
- State management (if applicable).
- Integration points with external systems.
- Generated boundaries (code generated from schemas).
- Docs explaining architecture.

### 4. Form package candidates

A **package candidate** appears when multiple files or concepts share at least one of these dimensions:

- A common responsibility.
- A data or execution flow.
- A mental model.
- An interface or contract.
- An explicit boundary.
- An architectural decision.
- A specific risk.
- An extension point.
- A behavior tested together.

List candidates with evidence. Do not create packages yet — only candidates.

### 5. Validate candidates

For each candidate, ask:

- Does it have sufficient evidence in concrete paths?
- Does it serve the user's goal (from calibration)?
- Is it too large (should it be split)?
- Is it too small (should it be merged with another)?
- Does it have clear boundaries (what's in, what's not)?
- Does it have concrete associated paths?
- Does it connect to other packages (relations)?
- Is it core / secondary / optional / risky to touch without understanding?

Discard candidates that don't pass these questions. Mark the reasons for discarding (serves honesty and future reopening).

### 6. Name packages using the repo's vocabulary

Prefer names that come from the repo itself:

- First and second-level folders.
- Modules.
- Domain names.
- CLI commands.
- Concepts repeated in docs.
- Public APIs.
- Names in tests.
- Terms that appear consistently.

Avoid generic names (`Core`, `Engine`, `Manager`, `Service`) if the repo has its own language. If only generic names exist, mark it and propose better naming.

### 7. Order packages

Order by (in this priority order):

- Conceptual prerequisites (what needs to be understood before what).
- Actual system execution (what happens first when the system runs).
- User's goal (what serves them earliest).
- Risk of touching something without understanding it (if they will modify code, what is dangerous).
- Module dependency (what imports what).
- Value for onboarding / application / implementation per calibration.

### 8. Mark confidence per package

Each final package must declare:

- **Confidence**: high / medium / low.
- **Source paths**: concrete files / directories.
- **Inferences**: what is deduced from the pattern, not stated by the repo.
- **Doubts**: what could not be confirmed and why.

## Format for each discovered package

```
P1 — [Name from the repo's vocabulary]

Why it exists:
  [discovered responsibility — what this set of files does]

Evidence:
  paths:   [path1/, path2/file.ext]
  docs:    [README section X, docs/architecture.md]
  tests:   [tests/integration/flow-A.spec]
  relevant imports/configs: [...]

Central pattern:
  [what mental model this package installs — one phrase]

Boundaries:
  [what does NOT belong to this package]

Relations:
  - depends on P2 (because ...)
  - feeds P4 (because ...)
  - is prerequisite for P7 (because ...)
  - is risky to touch before P3 (because ...)

Confidence: high / medium / low
  [why: clear paths, obvious responsibility / inferred responsibility without docs / etc.]
```

## Suspected but NOT confirmed packages

If the Skill suspects a package should exist but cannot find sufficient evidence, say so explicitly:

> "Possible package, not confirmed: **[name]**. Evidence is missing in the repo. I need to review [specific paths or sections] or ask you directly."

Do not include unconfirmed packages in the main list. List them in a separate section: `Suspected packages, insufficient evidence`.

## Reinforced anti-hallucination rules

Specific to repos:

- **Do not** use generic stack knowledge to invent modules.
- **Do not** assume a React repo has routing.
- **Do not** assume a backend has a database.
- **Do not** assume a research repo has a training loop.
- **Do not** assume a game repo has ECS or a conventional game loop.
- **Do not** assume a runtime has its own scheduler.
- **Do not** assume a monorepo has shared packages.
- **Do not** assume a library has a public API clearly separated from internals.
- **Do not** assume a repo with `tests/` has tests useful for understanding the domain.
- **Do not** assume a README reflects the current state of the repo.

Canonical phrase for any detected generic assumption:

> "This would be typical in this type of repo, but I don't see it confirmed here."

## Full mode output (presentation order)

1. **ARTIFACT CLASSIFICATION** (descriptive).
2. **Relevant inventory** (3–5 findings from the file tree / dependencies / entrypoints).
3. **Detected centers of gravity**.
4. **Package candidates considered** (including discarded ones with reasons).
5. **Final packages** (P1...Pn with full format).
6. **Suspected but unconfirmed packages** (separate section).
7. **Recommended order** (for the calibration's goal).
8. **First package to install** (P1, expanded if calibration requested it).
9. **How to continue from here** (maximum 3 options — install P1 / request more exploration of [path] / reorder based on [context]).

## Chaining

- Validate understanding of a package → Mode 4 (with "validate P3").
- Package one individually to the mind-bridge standard → Mode 2.
- Save to library → Mode 9 (with confirmation).
- Deepen a package to implement level → Mode 5 + Implementation modifier activated.
- If the exploration triggers a personal intuition → Mode 7.
- If the user wants to serialize understanding for a meeting → Mode 3 + Communication modifier.

## References

- Global calibration, evidence policy, stable IDs, success criterion: `SKILL.md`.
- Source Completeness Gate (also applies to partially accessible repos): `templates/source-coverage-gates.md` section 2.
- Package template (to expand P1): `templates/concept-package.md`.
- Gold-standard discovery example: `examples/repo-discovery-example.md`.
