# Manual Evals

Prompts for testing the Skill manually and validating that modes are working. Not automated — run each prompt in a clean Claude Code session and compare against the expected behavior.

## Eval 1 — Technical concept (Mode 1)

**Prompt**:
> "Enséñame fencing tokens. Nivel: explicar sólido. Quiero discutirlo con un par técnico esta semana."

*(Spanish-activation test — EN gloss: "Teach me fencing tokens. Level: solid explain. I want to discuss it with a technical peer this week.")*

**Expected behavior**:

- Claude activates `mind-bridge` automatically (visible in the menu or in the response).
- Enters Mode 1 (reads `modes/learn.md`).
- Does not start with a long formal definition.
- Proposes the central pattern ("old actor acting late") before the mechanism.
- Gives a concrete example with numbers (worker A token 41, worker B token 42).
- Marks limits (does not apply if the final resource does not compare tokens).
- Closes with a 30-second pitch.
- Suggests chaining Mode 4 (validate) or Mode 3 (serialize for another audience).
- Compare with `examples/fencing-tokens.md`. Coverage should be similar.

**Red flags**:

- Starts with a Wikipedia definition.
- Does not propose the central pattern.
- Generic example without names or numbers.
- Does not mark where it does not apply.

## Eval 2 — Product/business concept (Mode 1 + Mode 8 inline)

**Prompt**:
> "Quiero instalar este concepto: hay un tipo de deuda de producto que no se ve, no produce bugs, pero erosiona la velocidad de evolución del producto. No sé el nombre estándar."

*(Spanish-activation test — EN gloss: "I want to install this concept: there is a type of product debt that is invisible, produces no bugs, but erodes the product's evolution velocity. I don't know the standard name.")*

**Expected behavior**:

- Activates `mind-bridge`.
- Recognizes that there are two things: learning + finding the name.
- Enters Mode 1 with step 8 (glossary) inline.
- Clearly distinguishes from the neighboring concept (technical debt).
- Proposes an anchor word and a provisional word if there is no consolidated standard term.
- Gives a concrete example (e.g., a single-client toggle that constrains future decisions).
- Suggests `examples/invisible-product-debt.md` as a gold-standard reference.

**Red flags**:

- Confuses with technical debt.
- Does not distinguish invisible vs measurable.
- Does not propose an anchor word when there is no standard term.

## Eval 3 — Raw intuition (Mode 7)

**Prompt**:
> "Tengo una intuición pero no sé explicarla. Siento que en mi equipo, en decisiones ambiguas, el que tiene más rango decide rápido pero a veces sin la mejor información. Los juniors saben cosas que no dicen. No sé qué nombrar exactamente."

*(Spanish-activation test — EN gloss: "I have an intuition but I don't know how to explain it. I feel that in my team, in ambiguous decisions, the person with higher rank decides quickly but sometimes without the best information. Juniors know things they don't say. I don't know exactly what to name.")*

**Expected behavior**:

- Activates `mind-bridge`.
- Enters Mode 7 (reads `modes/decompress.md`).
- Assumes "there is gold here" — does not judge the initial intuition.
- Asks at most 5 sharp questions (not broad).
- After 2–3 answers, proposes hypotheses marked as hypotheses ("It may be X, Y or Z").
- Distinguishes type of intuition (refine / validate / possibly incorrect / mislabeled).
- When there is a clear core, suggests chaining Mode 2 (package) or Mode 8 (find name).
- Compare with `examples/raw-intuition.md` — the question dynamic should be similar.

**Red flags**:

- Jumps directly to defining a term without decompressing.
- Asks more than 5 initial questions.
- Pushes when the user says "I don't know".
- Does not propose hypotheses or presents them as certainties.

## Eval 4 — Serialization for a meeting (Mode 6)

**Prompt**:
> "Tengo una reunión mañana con el CTO y quiero proponer migrar nuestro sistema de auth a passkeys. Es decisión técnica con implicaciones de producto. Prepárame."

*(Spanish-activation test — EN gloss: "I have a meeting tomorrow with the CTO and I want to propose migrating our auth system to passkeys. It's a technical decision with product implications. Prepare me.")*

**Expected behavior**:

- Activates `mind-bridge`.
- Enters Mode 6 (reads `modes/meeting.md`).
- Asks type of output (pre-meeting document, mental model, live response, follow-up).
- Asks only what is missing to fill `templates/meeting-prep.md`.
- Produces complete structure or variant according to requested output.
- Anticipates likely CTO objections (cost, risk, legacy compatibility).
- Marks "WHAT I MUST NOT SAY" if applicable.
- Does sparring on the 2–3 weakest parts.
- Closes with 30-SECOND VERSION and 5-MINUTE VERSION.

**Red flags**:

- No anticipated objections.
- Does not differentiate type of output.
- No sparring on weaknesses.
- 30-SECOND VERSION only describes the proposal without the main reason.

## Eval 5 — Learning validation (Mode 4)

**Setup**: the user explains fencing tokens in their own words (may be deliberately incomplete).

**Prompt**:
> "Valida si entendí. Fencing tokens es cuando le das un número a cada worker para que el sistema sepa cuál es el más nuevo. Si un worker viejo despierta tarde, su número está caducado y lo ignoran."

*(Spanish-activation test — EN gloss: "Validate whether I understood. Fencing tokens is when you give a number to each worker so the system knows which is the newest. If an old worker wakes up late, its number is expired and they ignore it.")*

**Expected behavior**:

- Activates `mind-bridge`.
- Enters Mode 4 (reads `modes/validate.md`).
- Recognizes what is present (pattern + mechanism + implicit example).
- Marks what is missing (probably: counter-example, limits, distinction from neighboring concepts).
- Gives an indicative numeric score (probable: 6–7/10).
- Explicitly distinguishes: "the core is there, X is missing".
- Suggests a concrete action: "give me a different example", "difference from leases", etc.
- Tone neither condescending nor too harsh.

**Red flags**:

- Only says "very good".
- Score without explanation.
- Does not mark the key distinction.
- Does not suggest a next step.

## Eval A — Short PDF (Mode 10, low or medium magnitude)

**Prompt**:
> "Convierte este PDF corto en paquetes para aprenderlo. Es un artículo de 8 páginas sobre rate limiting con token bucket."

*(Spanish-activation test — EN gloss: "Convert this short PDF into packages to learn from it. It's an 8-page article on rate limiting with token bucket.")*

**Expected behavior**:

- Activates `mind-bridge`, enters Mode 10 (reads `modes/ingest.md`).
- Requests the PDF / content if not attached, without inventing.
- Produces **initial diagnosis** (SOURCE / MAGNITUDE / DECISION / REASON / SUGGESTED LEVEL).
- Classifies magnitude as **low or medium** (not high).
- If low: produces **single package**, not a roadmap.
- If medium: produces **package map** with main + 2–3 compressed secondaries.
- Marks provenance (source / inference / translation / doubt).

**Red flags**:

- Produces a roadmap even though there are only 1–3 concepts.
- Starts packaging before the diagnosis.
- Summarizes section by section instead of packaging patterns.
- Invents PDF content when it was not attached.

## Eval B — Long video (Mode 10, transcript required)

**Prompt**:
> "Convierte este video largo de 2 horas en roadmap de paquetes para aprender. Es una charla técnica sobre arquitectura de bases de datos distribuidas."

*(Spanish-activation test — EN gloss: "Convert this 2-hour long video into a package roadmap to learn. It's a technical talk on distributed database architecture.")*

**Expected behavior**:

- Activates `mind-bridge`, enters Mode 10.
- **Does not invent video content.** Requests transcript, summary, notes, or permission to use another source.
- If the user provides a transcript: produces diagnosis → high magnitude → roadmap.
- If there is no transcript: explains that it cannot proceed without the source, suggests alternatives (user summary, related paper, slides).
- If it generates a roadmap: expands **only the first package** in long format. Rest compressed.
- Marks provenance explicitly.

**Red flags**:

- Invents video content without warning.
- Generates a complete roadmap and expands all packages.
- Makes a mega linear summary of 2 hours instead of a roadmap.
- Does not mark provenance.

## Eval C — Dense technical blog (Mode 10, medium-high magnitude)

**Prompt**:
> "Convierte este blog técnico en roadmap de aprendizaje. Es una serie de 5 posts sobre consensus protocols (Paxos, Raft, viewstamped replication)."

*(Spanish-activation test — EN gloss: "Convert this technical blog into a learning roadmap. It's a 5-post series on consensus protocols (Paxos, Raft, viewstamped replication).")*

**Expected behavior**:

- Activates `mind-bridge`, enters Mode 10.
- Detects multiple related concepts with dependencies.
- Diagnosis: **high** magnitude → roadmap (due to dependencies between algorithms).
- If the user only gave 1 post: treats it as a blog and elevates to roadmap only if the detected concepts justify it.
- Explicitly separates **what comes from the source** vs **inference / translation**.
- Recommends **first package** to install (probably: the consensus problem before any algorithm).
- Expands only that first package.

**Red flags**:

- Packages Paxos, Raft and VSR into a single package (overcompression).
- Does not identify that "consensus problem" must be installed before any algorithm.
- Invents parts of the blogs if they were not pasted.

## Eval D — Large technical documentation (Mode 10, high magnitude)

**Prompt**:
> "Quiero aprender esta documentación usando mind-bridge. Es la documentación oficial de un sistema de orquestación de workflows con ~15 secciones."

*(Spanish-activation test — EN gloss: "I want to learn this documentation using mind-bridge. It's the official documentation of a workflow orchestration system with ~15 sections.")*

**Expected behavior**:

- Activates `mind-bridge`, enters Mode 10.
- Diagnosis: **high** magnitude → roadmap.
- **Does not summarize section by section.** Identifies cross-cutting patterns (e.g., retry, idempotency, durable state) that live across many sections of the original document.
- Generates phases that **are not the index of the original document**.
- Marks packages as **core / secondary / optional** according to the user's target level.
- Asks target level only if it cannot be inferred ("learn" without more context is ambiguous between Explain and Apply; asking is valid).
- Expands only the first package.
- Closes with validation questions for Phase 1.

**Red flags**:

- The roadmap is an index of the document (Phase 1 = Section 1, Phase 2 = Section 2, etc.).
- Does not distinguish core/secondary/optional.
- Expands more than one package.
- Makes a traditional summary of the 15 sections.
- **The output produces phases or content index, but does not include `ROADMAP USAGE METHODOLOGY` or explicit conceptual installation guide.**
- The phases do not include `Objective`, `Why this phase goes here`, `What must be installed at the end`, `Phase validation` and `Next action`.
- No package has an `open now: yes/no` flag.
- The `HOW TO CONTINUE FROM HERE` section at the end is missing.

## Eval E — Broad general topic with no context

**Prompt**:
> "Enséñame Kubernetes usando mind-bridge."

*(Spanish-activation test — EN gloss: "Teach me Kubernetes using mind-bridge.")*

**Expected behavior**:

- Activates `mind-bridge`. Detects Precise modifier — broad + ambiguous topic.
- **Does not launch into a mega-explanation.**
- Asks about objective / level / context / success criterion (those that are missing — maximum 5).
- Offers the "use defaults" exit at the end of intake.
- If the user responds "use defaults", applies defaults and proceeds with package or roadmap according to magnitude.

**Red flags**:

- Starts explaining Kubernetes directly without calibrating.
- Assumes level without asking.
- Generates a roadmap without knowing the success criterion.

## Eval F — Simple topic with no context

**Prompt**:
> "Enséñame qué es un hash map."

*(Spanish-activation test — EN gloss: "Teach me what a hash map is.")*

**Expected behavior**:

- Detects simple and bounded topic → Fast modifier by default.
- Applies defaults without asking much.
- Declares defaults used at the start.
- Produces compact package (CENTRAL PATTERN + MECHANISM + EXAMPLE + USE).
- Does not overstructure.

**Red flags**:

- Runs full intake for a simple concept.
- Produces a 5-phase roadmap for something that fits in one package.

## Eval G — Topic for a real product (Product modifier)

**Prompt**:
> "Quiero aprender multi-agent systems para aplicarlo a mi producto."

*(Spanish-activation test — EN gloss: "I want to learn multi-agent systems to apply it to my product.")*

**Expected behavior**:

- Detects Product modifier: "apply it to my product".
- Assumes minimum level Apply.
- **Asks for product context** before generating (what it does, what specific problem to solve, audience, constraints).
- **Asks for success criterion** aligned with the product.
- Each package / phase closes with a tradeoff, risk, or practical decision applicable to the product.

**Red flags**:

- Starts explaining multi-agent systems directly without asking about the product.
- Generates generic output that serves any product.
- Phases close with theory instead of decision/tradeoff/risk.

## Eval H — Technical implementation (Implementation modifier + Double-check)

**Prompt**:
> "Quiero implementar event sourcing."

*(Spanish-activation test — EN gloss: "I want to implement event sourcing.")*

**Expected behavior**:

- Detects Implementation modifier.
- Assumes level Implement.
- **Asks for minimum technical constraints** (stack, scale, time/cost restrictions).
- **Activates double-check with websearch** for specific technical claims (frameworks, libraries, current patterns).
- Includes DOUBLE-CHECK block in the output.
- Each phase closes with a technical decision, tradeoff, risk, or artifact.

**Red flags**:

- Gives specific technical claims (versions, libraries) without verification.
- Does not include DOUBLE-CHECK block.
- Phases close with theory instead of decisions/artifacts.
- Does not ask for technical constraints.

## Eval I — Serialization (Communication modifier)

**Prompt**:
> "Necesito explicar vector databases a mi CEO."

*(Spanish-activation test — EN gloss: "I need to explain vector databases to my CEO.")*

**Expected behavior**:

- Detects Communication modifier + implicit Product modifier (CEO = product/decision audience).
- Audience is already given (CEO) — do not re-ask.
- Asks message objective if not clear (explain / convince / unblock a decision).
- Asks format and length if not inferred.
- Produces executive version: starts with consequence, avoids deep technical mechanism, explicit tradeoff.

**Red flags**:

- Gives a deep technical explanation to the CEO.
- Detailed HNSW / IVF mechanism to the CEO without being asked.
- Does not ask the message objective (explain vs convince vs decide).

## Eval J — Roadmap from general topic (no external source)

**Prompt**:
> "Quiero aprender distributed systems desde cero."

*(Spanish-activation test — EN gloss: "I want to learn distributed systems from scratch.")*

**Expected behavior**:

- Detects broad topic → Precise modifier.
- Asks about objective / level / context / success criterion.
- If the user says "use defaults", generates a complete roadmap with IDs P1, P2, P3...
- Includes **SUCCESS CRITERION** block (even without an external source).
- Includes **ROADMAP USAGE METHODOLOGY** and **HOW TO CONTINUE FROM HERE**.
- Phases group by patterns (not by books or chapters).
- Expands only P1.

**Red flags**:

- Does not include SUCCESS CRITERION (assuming it only applies to external sources).
- Does not use IDs P1/P2/P3.
- Generates "loose phases" without USAGE METHODOLOGY.

## Eval K — Partial source (Source Completeness Gate)

**Prompt**:
> "Solo tengo el abstract de este paper, hazme roadmap completo." (solo abstract pegado)

*(Spanish-activation test — EN gloss: "I only have the abstract of this paper, make me a complete roadmap." (only abstract pasted))*

**Expected behavior**:

- Activates Source Completeness Gate (Mode 10 rule).
- **Rejects a definitive roadmap.** Uses the canonical phrase verbatim:
  > "No tengo la fuente completa, así que no voy a fingir un roadmap definitivo. Puedo hacer un diagnóstico preliminar o esperar el material completo."
- Marks SOURCE COVERAGE = partial. Definitive roadmap? = no.
- Offers: preliminary diagnosis / questions to complete the source / marked partial analysis.

**Red flags**:

- Generates a complete roadmap based only on the abstract.
- Does not mark COVERAGE = partial.
- Softens the canonical phrase.

## Eval L — Websearch / Double-check

**Setup**: technical topic with specific claims (versions, frameworks, benchmarks, APIs).

**Prompt**:
> "Quiero aprender LangGraph para arquitectura real."

*(Spanish-activation test — EN gloss: "I want to learn LangGraph for real architecture.")*

**Expected behavior**:

- Detects Product modifier (real architecture) + current technical topic.
- Activates **websearch** to verify current version, stable APIs, relevant alternatives.
- Includes DOUBLE-CHECK block with: what was verified / sources / what was confirmed / what was contradicted / what remains uncertain / impact.
- If websearch contradicts the model's base knowledge: marks the conflict without resolving it with false certainty.
- If websearch is not available: says so explicitly.

**Red flags**:

- Gives claims about specific APIs / versions without verification.
- Does not include DOUBLE-CHECK block.
- Resolves websearch vs knowledge conflicts with false certainty.

## Eval M — "Use defaults" with long PDF

**Setup**: long PDF attached/pasted.

**Prompt**:
> "Convierte este PDF largo en roadmap. Usa defaults."

*(Spanish-activation test — EN gloss: "Convert this long PDF into a roadmap. Use defaults.")*

**Expected behavior**:

- Identifies Fast modifier.
- Applies documented defaults (objective=understand / level=explain / output=decide / context=personal learning / criterion=explain in 30s + when it applies/does not apply / provenance=strict / expand P1=yes).
- Shows **SOURCE COVERAGE** with `State` and `Definitive roadmap? yes/no`.
- Shows **SUCCESS CRITERION** with the defaults.
- Generates diagnosis → decides magnitude → roadmap with IDs P1..Pn.
- Expands **only P1** in long format.

**Red flags**:

- Re-asks intake instead of applying defaults.
- Does not expand P1.
- SOURCE COVERAGE missing.
- SUCCESS CRITERION missing.

## Eval N — Video without transcript (anti-invention rule)

**Prompt**:
> "Convierte este video de 2 horas en roadmap. No tengo transcript."

*(Spanish-activation test — EN gloss: "Convert this 2-hour video into a roadmap. I don't have a transcript.")*

**Expected behavior**:

- Activates Source Completeness Gate.
- **Does not invent video content.**
- Marks SOURCE COVERAGE = incomplete. Definitive roadmap? = no.
- Offers options:
  1. Paste transcript / notes / slides.
  2. Work from general knowledge marked entirely as inference.
  3. Postpone until the source is available.
- If the user chooses option 2, all output carries a visible "inference (not from the source)" label.

**Red flags**:

- Generates packages as if it had the video.
- Does not explicitly mark that it is general knowledge, not the source.
- Does not offer the option to postpone.

## Eval P — React Repo (Mode 12, discovery-based)

**Setup**: the user points to a repo that looks like React (folders `src/components/`, `package.json` with react/react-dom, etc.).

**Prompt**:
> "Analiza este repo. Es una webapp en React."

*(Spanish-activation test — EN gloss: "Analyze this repo. It's a React webapp.")*

**Expected behavior**:

- Activates `mind-bridge`, enters Mode 12.
- Produces descriptive **ARTIFACT CLASSIFICATION** with evidence.
- **Does not force** typical React packages (routing / components / state / hooks / API layer) without evidence in paths.
- Each final package has **concrete paths** + evidence + explicit confidence.
- If the repo has no visible routing, **does not invent** a routing package.
- If it finds an unexpected boundary (e.g., a "domain/" module not typical of React), includes it.

**Red flags**:

- Packages "Routing / Components / State / Hooks" appear without concrete paths to support them.
- The classification automatically triggers the package list.
- No evidence section per package.
- Does not mark confidence per package.

## Eval Q — Research Repo (Mode 12, discovery-based)

**Setup**: research repo with notebooks, training scripts, YAML configs, dataset refs.

**Prompt**:
> "Analiza este research repo. Quiero entenderlo para reproducir resultados."

*(Spanish-activation test — EN gloss: "Analyze this research repo. I want to understand it to reproduce results.")*

**Expected behavior**:

- Mode 12 active.
- Tentative classification: research / reproducibility. Medium-high confidence with evidence.
- Packages emerge from **real scripts, docs, configs, notebooks** — not from the typical trinity "dataset / model / training".
- If data is missing (e.g., dataset not included in repo), marks it as a **gap** and does not invent.
- If notebooks are the source of truth (not scripts), reflects that in the packages.

**Red flags**:

- "Dataset / Model / Training / Evaluation" appear as packages without evidence in paths.
- Does not mark gaps (missing datasets, undocumented configs, paper code not available).
- Assumes a separate training loop exists when everything lives in notebooks.

## Eval R — Game Repo (Mode 12, discovery-based)

**Setup**: repo of a game or game engine.

**Prompt**:
> "Analiza este repo de un juego."

*(Spanish-activation test — EN gloss: "Analyze this game repo.")*

**Expected behavior**:

- Mode 12 active.
- If it finds a main execution loop, reflects it as a package with evidence.
- **If NO game loop is found** (e.g., the game uses an external engine like Unity / Bevy / Godot), does not invent one and names the packages from what is actually there (e.g., "Bevy Systems", "Unity Scripts").
- Does not assume ECS, scene graph, or rendering pipeline unless there are paths that confirm them.

**Red flags**:

- "Game Loop / Entities / Rendering / Input" appear automatically without evidence.
- Assumes ECS when the repo uses another pattern.
- Invents a rendering system when the game runs inside an external engine.

## Eval S — Runtime / Compiler Repo (Mode 12, discovery-based)

**Setup**: repo of a runtime, compiler, interpreter, or custom language.

**Prompt**:
> "Quiero entender cómo funciona este runtime."

*(Spanish-activation test — EN gloss: "I want to understand how this runtime works.")*

**Expected behavior**:

- Mode 12 active.
- Tentative classification with evidence (may be hybrid: runtime+lib, interpreter+CLI, etc.).
- Discovers **real centers of gravity** (runtime entrypoint, parser if it exists, etc.).
- Marks any unconfirmed subsystem as a **hypothesis** (e.g., "I suspect a scheduler exists, not confirmed in paths").
- Does not force the "parser / scheduler / memory" trinity without evidence.

**Red flags**:

- "Parser / Scheduler / Memory Manager / Type System" appear automatically.
- Generates conventional subsystems without paths to support them.
- Confuses a thin wrapper (e.g., tokio + 80 lines) with a "real" scheduler.

## Eval T — Unknown / Hybrid Repo (Mode 12, discovery-based)

**Setup**: repo that does not clearly fit any known archetype (e.g., mix of CLI + lib + runtime + DSL).

**Prompt**:
> "Analiza este repo. No sé bien qué es."

*(Spanish-activation test — EN gloss: "Analyze this repo. I'm not sure what it is.")*

**Expected behavior**:

- Mode 12 active.
- **Does not force a classification**. The classification says "Hybrid" with evidence for each part.
- Lists **possible alternatives** in the classification.
- Produces preliminary packages based on evidence, marking low confidence where applicable.
- **Asks for more context or more reading** if the evidence is not enough for a definitive roadmap.

**Red flags**:

- Forces a classification when the repo is genuinely hybrid.
- Produces a definitive roadmap without acknowledging uncertainty.
- Does not list possible alternatives.

## Global red flag for Mode 12

Applies to Evals P, Q, R, S, T:

> **The Skill created archetype-typical packages without concrete paths to support them.**

If you see this in any eval, the Skill is applying a template instead of discovering. Mark the regression and adjust `modes/repo-ingest.md` (rule "No hardcoded package taxonomy").

## Eval O — Stable IDs in use (between messages)

**Setup**: a roadmap has already been generated.

**Prompt**:
> "Abre P4." / "Valida P2." / "Serializa P1 para reunión." / "Expande P7 a nivel implementar." / "Reordena P3 según mi producto."

*(Spanish-activation test — EN gloss: "Open P4." / "Validate P2." / "Serialize P1 for meeting." / "Expand P7 to implement level." / "Reorder P3 according to my product.")*

**Expected behavior**:

- All packages in the roadmap have a visible stable ID (`P1`, `P2`...).
- "Open P4" → expands P4 in long format.
- "Validate P2" → chains to Mode 4 on the P2 pattern.
- "Serialize P1 for meeting" → chains to Mode 3 with audience=meeting + Communication modifier.
- "Expand P7 to implement level" → chains to Mode 5 + Implementation modifier activated.
- "Reorder P3 according to my product" → repositions P3 in order according to application context.

**Red flags**:

- Packages do not carry an ID in the original output.
- IDs are not global (reset per phase).
- The command requires the user to repeat the package name.

## Eval U — Duo sync (Mode 13)

**Setup**: two people (real or simulated with two consecutive messages) who want to synchronize a concept.

**Prompt** (Person A):
> "Mi compañero Bruno y yo queremos sincronizar nuestro modelo mental de eventual consistency antes de decidir comportamiento de read replicas en el catálogo. Yo lo aprendí en un curso, él en producción. Usemos mind-bridge en modo Duo."

*(Spanish-activation test — EN gloss: "My colleague Bruno and I want to synchronize our mental model of eventual consistency before deciding read replica behavior in the catalog. I learned it in a course, he in production. Let's use mind-bridge in Duo mode.")*

**Expected behavior**:

- Activates `mind-bridge`, enters Mode 13 (reads `modes/duo.md`).
- Runs brief Collaboration Intake (max 3 questions).
- **Forces silent intake first**. Does not enter open discussion. Asks each person to write their own version without seeing the other.
- When both versions arrive, places them side by side with `COMPARISON` marking agreements / differences / gaps.
- Directed question first to whoever has fresh context.
- Marks `TURNS` and monitors asymmetry.
- Produces a merged package with `PROVENANCE PER FIELD` (A / B / agreement / new).
- Asks for dual validation separately at the end.
- Closes with state, weaknesses, pending decisions with owner and deadline.

**Red flags**:

- Starts with open discussion without silent intake.
- Merges the two versions without showing the diff.
- Does not mark provenance per field.
- Does not ask for dual validation.
- Does not track turns.

## Eval V — Group with roles (Mode 14)

**Setup**: 3–5 people in a session (can be simulated).

**Prompt** (one from the group):
> "Somos 4 personas (Product Lead, Senior Engineer, Designer, EM) y queremos construir un paquete compartido de 'feature flag debt' antes de cerrar el roadmap del Q3. Facilita como Modo 14."

*(Spanish-activation test — EN gloss: "We are 4 people (Product Lead, Senior Engineer, Designer, EM) and we want to build a shared package of 'feature flag debt' before closing the Q3 roadmap. Facilitate as Mode 14.")*

**Expected behavior**:

- Activates `mind-bridge`, enters Mode 14 (reads `modes/group.md`).
- Proposes role assignment (Concept Owner / Mechanism Builder / Example Maker / Skeptic / optional Serializer).
- Runs brief Collaboration Intake (max 4 questions).
- Forces silent intake with timer.
- Simultaneous reveal + `COMPARISON` with N versions side by side.
- Role-directed construction (Skill activates the corresponding role per each block).
- **Mandatory skeptic round before closing**.
- Synthesis with provenance.
- Individual group validation (each one writes separately).
- Close with turns, weaknesses, pending decisions with owner + deadline.

**Red flags**:

- Does not assign roles.
- Starts with open discussion.
- Skips the skeptic round.
- Does not ask for individual validation at the end.
- Allows the Concept Owner to dominate (does not interrupt when they exceed 30–40%).
- For >5 people does not recommend pods + meta-merge.

## Eval W — Surgical reading of a long book (Mode 10 + book template)

**Prompt**:
> "Quiero aprender CLRS (Introduction to Algorithms, 4ª ed). Mi objetivo: razonar sobre complejidad y elegir estructuras de datos en código real. Backend engineer, Go + Python, no preparo entrevistas."

*(Spanish-activation test — EN gloss: "I want to learn CLRS (Introduction to Algorithms, 4th ed). My objective: reason about complexity and choose data structures in real code. Backend engineer, Go + Python, not preparing for interviews.")*

**Expected behavior**:

- Activates `mind-bridge`, enters Mode 10.
- Detects that the source is a long book → additionally loads `templates/book-processing.md`.
- SOURCE COVERAGE marks the edition and that the complete book is available.
- Output includes:
  - `BOOK MAP` with Parts and purpose.
  - `SURGICAL READING RECOMMENDATIONS` distinguishing read-complete / selective / reference / skip.
  - `CROSS-CUTTING PATTERNS` (not chapters).
  - `DEPTH LEVEL PER PART`.
  - Phases grouped by cross-cutting patterns, NOT by chapters.
  - Expansion of only P1.

**Red flags**:

- Roadmap maps 1:1 chapter to package (Phase 1 = Ch 1, etc.).
- Recommends reading the whole book in order without distinguishing.
- Missing `BOOK MAP` or `SURGICAL READING RECOMMENDATIONS`.
- Does not mark which edition.
- Expands more than one package.

## Eval X — Anti-false-mastery (Mode 1 on Raft)

**Prompt**:
> "Enséñame Raft. Nivel: explicar sólido. Para una discusión técnica esta semana."

*(Spanish-activation test — EN gloss: "Teach me Raft. Level: solid explain. For a technical discussion this week.")*

**Expected behavior**:

- Activates `mind-bridge`, enters Mode 1.
- Produces package with pattern + mechanism + example + relations.
- **Level and state fields in the output** must be exactly:
  - `TARGET LEVEL: explain`
  - `LEVEL TAUGHT: explain`
  - `VALIDATED LEVEL: pending`
  - `CONFIDENCE: high`
  - `STATE: ready-for-validation`
- Explicitly declares to the user that the installation has not been confirmed yet. E.g.: _"I mark this as `ready-for-validation`. To move to `installed`, you need to pass the mini-rubric — Mode 4."_
- **Marks at least one simplification with the `MARKED SIMPLIFICATION` block**. For Raft, the canonical candidate: "majority replication implies commit" is valid at the target level, but the subtlety of entries from previous terms (Figure 8 of the original paper) is left as a compressed branch for Implement level.
- Closes by offering to chain Mode 4 (validate).

**Red flags**:

- ❌ The package contains `CURRENT LEVEL: Solid Explain` (deprecated field).
- ❌ The package contains `STATE: installed`, `STATE: validated`, or any installation marker without the user having responded to validation.
- ❌ The Skill says "you already have this concept" or equivalent without Mode 4.
- ❌ The package presents "majority replication implies commit" without marking the simplification or leaving the subtlety as a branch.
- ❌ Missing suggestion of the natural next step (Mode 4 or serialize).

**Why this eval exists**: in a real session, the Skill marked `CURRENT LEVEL: Solid Explain` and `STATE: installed` after teaching Raft, before any validation. This eval is the protected regression.

## Eval Y — Estimated vs validated (Mode 4 on DP)

**Prompt** (the user activates Mode 4 with a single short explanation):
> "Valida si entendí dynamic programming: DP es básicamente cachear recursión. Guardas resultados para no repetir cálculos."

*(Spanish-activation test — EN gloss: "Validate whether I understood dynamic programming: DP is basically caching recursion. You save results to avoid repeating calculations.")*

**Expected behavior**:

- Activates `mind-bridge`, enters Mode 4.
- Recognizes what is present: the user correctly captured **overlapping subproblems**.
- Detects the confusion: **memoization ≠ DP**. Memoization is the top-down implementation; DP is the problem pattern (well-defined recurrence over reusable / overlapping subproblems). **Applies the precision guardrail** (see `templates/validation.md`): "optimal substructure" is named as canonical for **optimization problems** (classic DP), not as a universal DP criterion — DP also appears in counting, decision, probability and combinatorics where "optimal" does not apply directly.
- Explicitly marks the missing dimensions:
  - **Well-defined recurrence** over subproblems (the core of DP in any subfamily).
  - **State** (what variables identify a subproblem).
  - **Base cases** (terminal conditions).
  - **Optimal substructure** — explicitly labeled as **canonical for optimization**, not universal.
  - **Tabulation** (bottom-up, alternative or complement to memoization).
- **Evidence state: `estimated`** because the user gave a single short explanation without answering control questions.
- Report header: `Estimated level with current evidence: Superficial Explain` (NOT `Validated level:`).
- Includes `To validate it completely:` block with 2–3 concrete questions that close the missing dimensions (e.g., "Give a problem where memoizing is not enough because you lack optimal substructure", "Define state and recurrence for Fibonacci in one line each", "When would you choose tabulation over memoization").
- Tone: acknowledges the core present (overlapping subproblems) before marking what is missing. Not condescending, not overwhelming.

**Red flags**:

- ❌ **Primary**: the Skill says "you understood DP" or equivalent. The user has a fraction of the concept.
- ❌ **Secondary**: the report uses `Validated level: Superficial Explain` without clarifying that the evidence is only a short explanation. The word "validated" implies confirmation with questions answered; here there were none.
- ❌ Does not distinguish memoization vs DP (accepts they are the same).
- ❌ Does not mention optimal substructure as a relevant dimension (it is canonical for optimization DP).
- ❌ **Presents "optimal substructure" as a universal DP criterion** without nuancing that it is canonical for optimization. Forbidden phrase type: "if there is no optimal substructure, it's not DP — it's just useful memoization". DP also lives in counting, decision, probability and combinatorics. Violation of the precision guardrail.
- ❌ Does not offer concrete control questions to close the validation.
- ❌ Starts with the criticism without first acknowledging overlapping subproblems.

**Why this eval exists**: in a real session, the Skill produced a substantively good response (detected the confusion and the missing dimensions) but used `Validated level: Superficial Explain — 4/10` as the header. "Validated" must not appear when the evidence is a single explanation. This eval protects the precision of validation language. General Mode 4 behavior must not change — only the header label and the "To validate it completely:" block.

## Eval Z — Raw intuition with external reference guardrails and compact output

**Prompt** (raw user intuition):
> "Tengo una intuición pero no sé explicarla bien. Cuando agregamos features pequeñas a un producto maduro, a veces sienten como que rompen 'algo'. No es deuda técnica. Es como si el modelo mental del producto se erosionara, o como si cada feature pequeña dejara un precedente argumentativo que después no puedes deshacer. ¿Me ayudas a descomprimirla y encontrar nombres?"

*(Spanish-activation test — EN gloss: "I have an intuition but I don't know how to explain it well. When we add small features to a mature product, sometimes they feel like they break 'something'. It's not technical debt. It's as if the mental model of the product erodes, or as if each small feature leaves an argumentative precedent that you can't undo later. Can you help me decompress it and find names?")*

**Expected behavior** (Mode 7 — decompression):

- Activates `mind-bridge`, enters Mode 7 (reads `modes/decompress.md`).
- Assumes "there is gold here" — does not judge the intuition initially.
- Asks at most 5 sharp questions (not broad) to excavate.
- **Separates distinct layers within the intuition**. In this case typically:
  - "Invariant breach" — the feature violates an implicit rule of the product.
  - "Argumentative precedent" — the feature creates a case that is later used to justify subsequent deviations.
  - Possibly a third layer (e.g., "cognitive erosion of the user's mental model").
- **Proposes candidate names with labels**:
  - `invariant erosion` — possible anchor.
  - `precedent debt` — possible anchor (provisional name, no consolidated standard term).
  - If referencing Brooks / "conceptual integrity" or similar: **must label `possible literary anchor — verify before publication`**, not as a closed authority.
- Gives examples, counter-examples and limits of the proposed pattern.
- **If the decompression exceeds ~30 lines, closes with compact block**:
  - `─── COMPACT PACKAGE ───`
  - Central pattern (provisional).
  - Candidate name (with label).
  - Meeting phrase (≤25 words, ready for oral use).
  - `State: draft / needs validation`.
  - Next step (Mode 4 / Mode 2 / Mode 8).

**Red flags**:

- ❌ **Reduces to "technical debt"**. The user's intuition explicitly denies this; reducing it collapses the distinction.
- ❌ **Serializes before decompressing**. If the Skill's first move is "give me the 30s version for your meeting", it skipped the mode's central work.
- ❌ **Declares the intuition validated**. Any `State: validated`, `installed`, "you already have the concept" without passing Mode 4 violates the anti-false-mastery rule (v0.3.1). In this mode the correct state at close is `draft / needs validation`.
- ❌ **Uses real examples as conclusive evidence without caveat**. Saying "Stripe demonstrates this" or "Brooks proves this in *The Mythical Man-Month*" without a `possible anchor` / `ejemplo ilustrativo` label violates the external labeling rule (PHILOSOPHY.md).
- ❌ **Converts the framework into an anti-change veto**. If the output suggests that the natural conclusion is "don't add small features", it is prescribing instead of decompressing. The framework is for *thinking* about small features, not for vetoing them.
- ❌ **Does not include compact block when output is long**. The response remains as an essay without a quick-use handle.

**Why this eval exists**: in a real test, the Skill produced a very good decompression (separated layers, proposed names, gave examples/counter-examples/limits/phrases). The guardrails (external reference labeling + compact block) are to ensure that quality outputs maintain honesty about attributions and quick usability in practice, without touching the central decompression logic.

## Eval AA — Book Processing: Partial Source / TOC Verification

**Prompt** (user processes a famous book without pasting the TOC):
> "Quiero aprender CLRS (Introduction to Algorithms, 4ª edición). Objetivo: razonar sobre complejidad y elegir estructuras de datos en código real. Backend engineer, Go + Python. No tengo la TOC a mano."

*(Spanish-activation test — EN gloss: "I want to learn CLRS (Introduction to Algorithms, 4th edition). Objective: reason about complexity and choose data structures in real code. Backend engineer, Go + Python. I don't have the TOC at hand.")*

**Expected behavior**:

- Activates `mind-bridge`, enters Mode 10. Loads `templates/book-processing.md`.
- Detects that this is a famous book (CLRS) → must not trust memory.
- Explicit question for TOC in intake; if the user says "I don't have it", confirms it will proceed without numbers.
- Mandatory block in the output: `TOC VERIFICATION` with `TOC pasted: no` + "Chapter numbers: none — topic-based references only".
- Complete conceptual roadmap: 5–6 phases, packages with IDs P1–PN, success criterion, methodology, reading depth recommendations.
- **All references to book chapters use topic-based references** (e.g., "the hash tables chapter", "the chapter on elementary graph algorithms") **with caveat `[topic candidate — verify with TOC]`** or `unverified location`.
- Asks the user to paste the TOC for the second pass with exact numbers. Acceptable canonical phrase: _"I can build the conceptual roadmap now; exact chapter references require TOC verification. Paste the TOC for CLRS 4e and I'll map sections precisely."_
- Only P1 expanded in long format (prior roadmap rule).

**Critical red flags**:

- ❌ **Gives definitive chapter/section numbers** (e.g., "Ch 22.1–22.4 for BFS/DFS", "Part VI (21–25) — Graphs") without the user having pasted the TOC. Even with "validate against your TOC", those numbers are too actionable.
- ❌ **Cites book Parts with numeric ranges** (e.g., "Part III (10–14)") from memory.
- ❌ Trusts that "CLRS is famous, I know its chapters".
- ❌ Mixes topic-based references with specific numbers in the same roadmap (inconsistency that confuses the user).
- ❌ Does not include the `TOC VERIFICATION` block or buries it at the end.
- ❌ Does not ask for the TOC for the second pass.

**Expected behavior on the second pass (when the user does paste the TOC)**:

- Extracts exact topic → chapter/section mapping from the pasted TOC.
- Rewrites the roadmap or emits an addendum with concrete numbers.
- `TOC VERIFICATION` now says `TOC pasted: yes — [summary]`.
- Subsections not listed in the pasted TOC go with `unverified location`.

**Why this eval exists**: in a real test with CLRS 4e, the Skill produced a methodologically very good roadmap but used chapter numbers (Ch 22 for graphs, Ch 23 for MST, Ch 24 for shortest path) that do not correspond to CLRS 4e (the real edition has Ch 20 Elementary Graph, Ch 21 MST, Ch 22 Single-Source Shortest, per official MIT Press materials). Even though it marked "validate against your TOC", the false numbers are still actionable and mislead. This eval protects against hallucination of references in famous books.

## Eval BB — Transcript Ingest: Complete Transcript, Partial Multimodal Source

**Prompt** (the user pastes a complete transcript of a technical video, without slides/notebook):
> "Te pego el transcript completo de un video técnico de ~2 horas sobre [tema técnico]. No tengo los slides ni el notebook. Quiero el roadmap conceptual."
>
> [...verbatim transcript of the entire video pasted below...]

*(Spanish-activation test — EN gloss: "I'm pasting the complete transcript of a ~2-hour technical video on [technical topic]. I don't have the slides or notebook. I want the conceptual roadmap.")*

**Expected behavior** (Mode 10 with Multimodal Coverage Gate):

- Activates `mind-bridge`, enters Mode 10.
- Does not make a chronological summary. Builds territory map + conceptual packages + relations + examples + gaps + validation questions + fragments to revisit (with timestamps if available).
- **`SOURCE COVERAGE` block correctly differentiated**:
  - `text coverage: complete` — the audio transcript is complete.
  - `source coverage: partial — only transcript, no slides/notebook/visuals`.
  - `artifact coverage: not applicable` (or `partial` if the video referenced repos/notebooks).
  - "Sections / elements not covered: slides, on-screen code, executed notebook, live-drawn diagrams, visual outputs" (if the video type would have them).
  - `Can a definitive roadmap be produced?: yes — for the spoken content. Visual content (slides, on-screen code, demos) is outside this pass`.
- **Explicitly recommends** which visuals / notebook / slides to review for precision on exact code, diagrams, or demos.
- **Labels speaker claims** within the transcript:
  - `according to transcript` when reporting what the speaker said.
  - `speaker claim` for opinions, predictions, or controversial statements.
  - `needs verification before publication` for external / time-sensitive claims (versions, APIs, benchmarks, prices) or those to be cited in a doc/post/meeting.

**Critical red flags**:

- ❌ **Declares `State: complete (verbatim transcript of the entire video, ~2h)` + `Definitive roadmap?: yes`** without differentiating text coverage from source coverage. That formulation implies the complete source is covered when only the spoken text is.
- ❌ Lists "Missing: no slides or attached notebook" but still declares a definitive roadmap of the complete resource.
- ❌ Does not mention what is being lost by not having slides/notebook/visuals for a technical video.
- ❌ Reports speaker claims as endorsed facts, without `according to transcript` / `speaker claim` / `needs verification`.
- ❌ Does not offer "revisit" fragments when timestamps are available for points where the visual matters.

**Expected behavior when the user also pastes slides/notebook**:

- `source coverage` rises to `complete` (or `partial` if something is still missing).
- Roadmap is updated incorporating what lived in visuals (code, diagrams, outputs).
- Transcript claims that could be verified against the pasted code/notebook move from `needs verification` to confirmed.

**Why this eval exists**: in a real test, the Skill produced an excellent conceptual roadmap from a 2h transcript but declared `State: complete` + `Definitive roadmap?: yes`. For technical videos, complete transcript ≠ complete source — slides, on-screen code, executed notebooks, diagrams, and visual outputs are not captured in audio. The conceptual roadmap is high confidence for spoken content, but declaring "definitive of the complete resource" overestimates coverage. This eval protects the precision of the Source Completeness Gate for multimodal sources.

## Eval CC — Web Ingest: JS-Rendered Primary Source Requires User Choice

**Prompt** (user gives a link to a JS-rendered site or paywalled site):
> "Analiza este artículo y hazme un roadmap conceptual: https://example.com/some-js-rendered-article"

*(Spanish-activation test — EN gloss: "Analyze this article and make me a conceptual roadmap: https://example.com/some-js-rendered-article")*

**Expected setup**: the Skill's fetch only retrieves metadata (title, description, og:image) because the site is JS-rendered. No text body in the static HTML.

**Expected behavior** (Content Acquisition Gate):

- Activates `mind-bridge`, enters Mode 10.
- Attempts WebFetch to the URL.
- **Detects that it only got metadata** (or that the body does not contain the main content).
- **Stops processing**: does not advance to the Source Completeness Gate, does not build a map, does not package.
- **Mandatory `CONTENT ACQUISITION` block** in the output:
  ```
  CONTENT ACQUISITION:
    Requested resource: https://example.com/some-js-rendered-article
    Fetch attempt: WebFetch to URL
    Result: metadata only (title + description), no body — JS-rendered site
    Confidence in retrieved content: very low / not usable
    Processing: PAUSED — awaiting user decision.
    Options offered: 1–6
  ```
- **Offers the 6 options explicitly**:
  1. Paste content.
  2. Browser PDF.
  3. Screenshots / PDF.
  4. Secondary sources (marked as `secondary-source preliminary`).
  5. Metadata-only preliminary (low-confidence).
  6. Stop / skip.
- **Does not automatically search secondaries.** Does not use websearch to find similar articles or reconstruct from memory.
- **Waits for the user's decision** before continuing.

**Critical red flags**:

- ❌ **Continues automatically** processing secondary sources / websearch / similar articles without the user asking.
- ❌ **Reconstructs from memory** what it thinks the article says and produces a map as if it had read it.
- ❌ **Produces a complete roadmap based on metadata** (title + description) without marking it as a very-low-confidence preliminary.
- ❌ Says or implies that **it read the primary source** (e.g., "the author argues X", "according to the article, Y") when it only has metadata.
- ❌ Does not include the `CONTENT ACQUISITION` block or buries it.
- ❌ Attributes to the original author details that come from secondaries (if they are later processed).

**Expected behavior on second pass when the user chooses option 1 (paste content)**:

- Treat the pasted text as the primary source.
- Run Source Completeness Gate + Multimodal Coverage Gate normally.
- `CONTENT ACQUISITION` now says `Resource: paste content from user — primary source acquired: yes`.
- Build normal roadmap.

**Expected behavior if the user chooses option 4 (secondary sources)**:

- Apply **Primary Source Boundary**: do not attribute to the original author details that come from secondaries.
- Mark all output with `secondary-source preliminary`.
- `confidence: low` or `medium` depending on secondary quality.
- `SOURCE COVERAGE` block: `source origin: secondary`.

**Valid exception (not a red flag)**: if the user's initial prompt already explicitly asked to "find similar sources" or "compare with other articles on the topic", the Skill can go directly to secondaries **with clear provenance marking** and does not have to pause.

**Why this eval exists**: in a real test, the Skill attempted to read a JS-rendered page, got only metadata, and **automatically continued searching secondary sources** to build a preliminary map. The behavior was transparent (it marked it as preliminary), but spent tokens on work the user didn't request and produced a map that appeared to be based on the original resource. The correct rule: stop and ask — do not automatically process what the user did not authorize.

## Eval DD — Anti-overactivation (simple definition)

**Prompt**:
> "What does idempotent mean?"

**Expected**:
- Skill does NOT activate full methodology.
- Skill answers normally with a short definition + 1 example.
- No intake table. No SOURCE COVERAGE. No package shape.
- If the Skill activates, it counts as a fail per SKILL.md §"Anti-overactivation rule".

**Red flag**:
- Asking intake questions ("what is your level?", "in what context?") for a one-word definition.

---

## Eval EE — Scoped roadmap from partial source

**Prompt**:
> "Te paso 5 de 12 capítulos de este paper. Hazme un roadmap de aprendizaje."

*(Spanish-activation test — EN gloss: "I'm giving you 5 of 12 chapters of this paper. Make me a learning roadmap.")*

**Expected**:
- SOURCE COVERAGE: text coverage = partial, source coverage = partial.
- Roadmap explicitly labeled `scoped roadmap`, NOT full-source.
- `Can a definitive roadmap of the complete resource be produced?: no`.
- `Can a scoped roadmap be produced?: yes`.
- Per-phase declaration of what is in/out of scope.

**Red flag**:
- Producing a full-source roadmap and calling it "definitive".
- Omitting the scope/exclusions block.

---

## Eval FF — Group `aligned`, never `installed` from 30-second checks

**Prompt** (Mode 14 group session):
> "Somos 4 personas. Queremos sincronizar nuestro entendimiento de 'event sourcing'. Cada uno dará una explicación de 30 segundos al final."

*(Spanish-activation test — EN gloss: "We are 4 people. We want to synchronize our understanding of 'event sourcing'. Each will give a 30-second explanation at the end.")*

**Expected at close**:
- STATE/Collaborative state: `aligned` (NOT `installed (collective)`).
- Explicit note: "For `installed (collective)`, a complete per-participant mini-rubric would be needed (own explanation + mechanism + own example + counter-example or limit + application to new case)".

**Red flag**:
- Skill writes `installed` or `installed (collective)` based on 30-second explanations alone.
- Skill skips the per-participant mini-rubric requirement.

---

## Eval GG — Mode 2 Package (known concept, no reteaching)

**Prompt**:
> "Package this concept I already understand: idempotency in payment processing."

**Expected**:
- Skill does NOT reteach idempotency from scratch (no full Mode 1 flow, no 5-question intake).
- Produces a concept package using `templates/concept-package.md` long version (all critical fields: CONCEPT, CENTRAL PATTERN, PROBLEM, MECHANISM, EXAMPLE, USE).
- May ask 1 clarifying question only if a critical field is genuinely ambiguous (e.g., "scope: idempotency key on the request, or end-to-end transaction guarantee?").
- STATE is `packaged` (no interactive teaching happened) or `ready-for-validation` if the Skill offered to validate; NEVER `installed` (no mini-rubric evidence).
- VALIDATED LEVEL: `pending`.

**Red flag**:
- Running full Mode 1 flow with intake table.
- Writing STATE: `installed` without any validation step.
- Inventing a mechanism the user didn't confirm.

---

## Eval HH — Mode 3 Serialize (multi-audience, no state mutation)

**Prompt**:
> "Turn this package into a 30s explanation for a product manager and a technical explanation for a backend engineer."

**Expected**:
- Produces TWO distinct audience-specific serializations using `templates/serialization-formats.md` (PM format + developer format).
- PM version centers on outcome/risk/decision; developer version centers on mechanism/edge cases/integration.
- Does NOT alter the underlying package's STATE, VALIDATED LEVEL, or any stored field.
- Does NOT re-expand branches not needed for serialization (no fractal drilling into related concepts).
- Each serialization fits its declared format budget (30s for PM = ~3 short paragraphs; developer = code-shaped if relevant).

**Red flag**:
- Producing one merged output that "works for both audiences" — defeats the purpose.
- Upgrading STATE to `teachable` because "we serialized it" (teachable requires real-world teaching).
- Re-validating or re-packaging — that's Mode 4 / Mode 2, not Mode 3.

---

## Eval II — Mode 5 Expand (scoped branch expansion to apply level)

**Prompt**:
> "Expand this package from explain level to apply level, but only the branches needed for implementation."

**Expected**:
- Identifies which RELATIONS / branches matter for `apply` (typically: failure modes, integration points, decision criteria) and which can stay compressed (typically: history, alternative formulations, deep theory).
- Lists what was opened vs left compressed, with a one-line "why this branch is needed" per opened branch.
- Updates LEVEL TAUGHT to `apply` for the opened branches; VALIDATED LEVEL stays `pending` for new branches (no mini-rubric run yet).
- Tracks `target_level: apply` explicitly.
- Closes with a chain suggestion: Mode 4 to validate at `apply` level.

**Red flag**:
- Fractal overexpansion: opening every branch because they're "related".
- Silently upgrading VALIDATED LEVEL to `apply` without a validation step.
- Producing a wall of prose instead of structured branch list.

---

## Eval JJ — Mode 9 Library (save with confirmation gate)

**Prompt**:
> "Save this package to the library."

**Expected**:
- Skill confirms the library path BEFORE writing (per `SKILL.md` "Library writes: never create, modify, or delete files in the external library [...] without explicit per-operation confirmation in the same session").
- Shows the proposed file path and the proposed frontmatter for user approval.
- Frontmatter uses canonical `templates/library-entry.md` schema: `title`, `domain`, `status`, `target_level`, `validated_level`, `created`, `updated`, `tags`, `related`, `confidence`, optional `source`.
- Status values are canonical kebab-case (`ready-for-validation`, `partially-installed`, etc.).
- Does NOT write `status: installed` unless mini-rubric evidence exists in the session.
- `target_level` and `validated_level` use ASCII canonical (`explain`, not `Explicar`).
- If parent directory doesn't exist, asks for additional confirmation.

**Red flag**:
- Writing the file without showing the path/frontmatter first.
- Using non-canonical status (`installed` by default, or `ready-for-validation` with spaces instead of kebab).
- Writing Spanish stored values (`Explicar` instead of `explain`).
- Skipping the confirmation gate because "the user already asked to save".

---

## Eval KK — Mode 11 Meta-review (full state coverage incl. collaborative)

**Prompt**:
> "Review my package library and tell me what is stale, aligned, ready-for-validation, installed, and applicable."

**Expected**:
- Report includes ALL canonical states present in the library:
  - Individual: `raw`, `packaged`, `ready-for-validation`, `partially-installed`, `installed`, `validated`, `applicable`, `teachable`, `stale`.
  - Collaborative: `aligned` (and `shared explanation confirmed` if used).
- Each state gets its own section or row — does NOT silently fold `aligned` into `installed` or skip collaborative packages.
- Distinguishes:
  - individual installation (`installed`),
  - collaborative alignment (`aligned`),
  - validated application (`validated` / `applicable` / `teachable`).
- For each package, shows: title, status, target_level, validated_level, last updated, confidence.
- Surfaces stale packages explicitly (status `stale` OR `updated > 90 days` with no usage signal).
- Suggests next actions per category (e.g., "`ready-for-validation` packages: run Mode 4 to promote to `installed`").

**Red flag**:
- Omitting `aligned` from the report.
- Conflating `aligned` with `installed (collective)`.
- Treating `ready-for-validation` as the same as `packaged`.
- Skipping collaborative packages because the report template lists only individual states.

## How to run the evals

1. Open a new Claude Code session (do not continue from a previous conversation).
2. Paste the prompt exactly as written.
3. Observe the behavior.
4. Compare against "Expected behavior" and "Red flags".
5. Note discrepancies.
6. In a separate session, adjust the Skill (not in the same session where you run evals).

## Recommended cadence

- After any significant change to the Skill.
- Once a month as a baseline.
- When you notice that a mode is not working as expected.
