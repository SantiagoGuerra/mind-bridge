# Canonical example — Package discovery from a repository

> Note: behavioral reference example, not required output length.

**TL;DR**: A user requests onboarding to an unfamiliar repository (FlowMint, fictional: runtime + DSL + library + CLI). The Skill **does not classify and apply a template**. Instead: it takes inventory without interpreting, tentatively classifies as "hybrid" with alternatives, finds real centers of gravity in concrete paths, lists package candidates with reasoned rejections, and produces 4 final packages (P1 DSL / P2 Engine / P3 Connectors / P4 Public interface) — each with evidence, confidence, and marked inferences. What it **does not** do: does not invent "Scheduler" / "Memory model" / "Type system" because no paths supporting them were found. If you only read one thing from this example, look at: (1) the "Tentative classification" section (how it reasons without applying a template), (2) "Package candidates with rejections" (how it justifies what was NOT included), and (3) the final note "What I did NOT do (intentional)".

Gold-standard example of Mode 12. Synthetic case (no copyright) showing how the Skill **reasons from the repository** instead of applying a template by archetype.

Important: this example is intentionally hybrid. The repository does not cleanly fit "React", "runtime", "research", "game", etc. This forces the Skill to discover, not classify and copy.

## Synthetic input

The user says:

> "I just cloned a repository called **FlowMint** (fictional project). Someone handed it to me to understand what it does and whether we can integrate it into our product. Can you help me with onboarding?"

## Global calibration (intake summary)

- Goal: understand + decide whether to integrate.
- Level: apply (Product modifier).
- Application context: concrete product (their product).
- Success criterion:
  - Decide whether FlowMint works for their case.
  - Identify 3 risks of integrating it.
  - Know which package to touch first if they integrate.
- Output: roadmap (decided by magnitude).

## Inventory without interpretation

```
FILE TREE (relevant extract):
  /                 — README.md, package.json, Cargo.toml, Makefile
  src/              — Rust code
  src/engine/       — engine.rs, runner.rs, scheduler.rs
  src/dsl/          — parser.rs, ast.rs, evaluator.rs
  src/io/           — connectors/ (5 files: http.rs, kafka.rs, pg.rs, s3.rs, fs.rs)
  src/io/sink.rs    — common interface for all connectors
  src/observability/— metrics.rs, tracing.rs
  bindings/         — auto-generated TypeScript bindings
  examples/         — 8 flow examples (.flow files)
  tests/            — integration_flow_*.rs (4 files), unit/
  docs/             — architecture.md, dsl-spec.md, connectors.md
  bench/            — benchmarks
  .github/workflows — CI with cross-compile

LANGUAGES:
  Rust (primary), TypeScript (bindings), a proprietary DSL (.flow)

CONFIGS:
  Cargo.toml: deps tokio, serde, anyhow, tracing, sqlx, rdkafka, aws-sdk-s3
  package.json: bindings only — tsup, vitest
  Makefile: build, test, bench, gen-bindings, fuzz

KEY DEPS:
  tokio (async runtime)
  serde (serialization)
  sqlx (postgres)
  rdkafka (kafka)
  aws-sdk-s3 (s3)
  tracing (observability)

SCRIPTS:
  cargo build / test / bench
  make gen-bindings → regenerates TS
  make fuzz → fuzz tests

DOCS:
  README: "FlowMint: declarative data flow runtime with pluggable sinks"
  docs/architecture.md: explains engine + scheduler
  docs/dsl-spec.md: spec for the .flow DSL
  docs/connectors.md: how to add a sink

TESTS:
  integration_flow_*.rs run end-to-end flows
  tests/unit/ per module

ENTRYPOINTS:
  src/main.rs (CLI: flowmint run <flow-file>)
  src/lib.rs (also a lib, exports public API)
```

## Tentative classification (descriptive, not prescriptive)

```
ARTIFACT CLASSIFICATION:
  Tentative type:
    Hybrid — it is a runtime with a proprietary DSL + embeddable library + CLI.
    It is not "only a runtime" nor "only a library" nor "only a framework".

  Evidence:
    - tokio + proprietary scheduler + execution loop → runtime component.
    - parser/ast/evaluator → proprietary interpreted DSL.
    - auto-generated TypeScript bindings + lib.rs → embeddable use.
    - main.rs with CLI → also standalone executable.
    - 5 connectors behind a common interface (sink.rs) → system with extension by adapters.

  Confidence: medium-high on "what it is"; low on boundaries between runtime and lib.

  Possible alternatives:
    - "Embedded runtime" (like Wasmer, V8 embeddings).
    - "Stream processor" (like Materialize, Bytewax).
    - "ETL framework with DSL" (like dbt, Airflow).
    The repository shares traits of all three.

  How this affects exploration:
    I will look for evidence of:
    - What the main runtime flow is (how a .flow file is executed).
    - How the DSL connects with the engine.
    - How connectors plug into the engine.
    - What the public interface is (lib.rs vs CLI).
    I will NOT assume "scheduler", "memory model", "type system", or "stdlib"
    exist until I find them in concrete paths.

  What I will NOT assume yet:
    - That it has a sophisticated proprietary scheduler (may just use tokio).
    - That the DSL has type checking (may be dynamic).
    - That connectors share a lifecycle (may just be a simple trait).
    - That it has explicit memory management.
    - That it has a separate "kernel" or "core" from IO.
```

## Detected centers of gravity

With evidence in paths:

1. **`src/engine/runner.rs`** — runtime entrypoint. Imported by `main.rs` and `lib.rs`. The execution center.
2. **`src/dsl/evaluator.rs`** — where the AST is converted into engine operations. Bridge between DSL and runtime.
3. **`src/io/sink.rs`** — public trait. The 5 connectors implement it. Clear extension point.
4. **`docs/architecture.md` + `docs/dsl-spec.md`** — two documents that explain distinct mental models (how it runs vs how to write a flow).
5. **`tests/integration_flow_*.rs`** — end-to-end flows. Good source for understanding real usage.
6. **`examples/*.flow`** — 8 DSL examples. Show the language in use.

Not detected:
- No apparent proprietary scheduler. `engine/scheduler.rs` exists but is 80 lines — appears to be just orchestration on top of tokio.
- No visible state management — the runtime appears stateless within a flow.
- No observability as a separate subsystem — just `metrics.rs` and `tracing.rs` used inline.

## Package candidates (with rejections)

### Considered

1. **DSL** (parser → AST → evaluator) — strong evidence: 3 files in `src/dsl/` + `docs/dsl-spec.md` + 8 `.flow` examples.
2. **Execution engine** (runner + engine + scheduler) — strong evidence: 3 files in `src/engine/` + `docs/architecture.md`.
3. **Connectors / Sinks** (trait + 5 implementations) — strong evidence: `src/io/sink.rs` + 5 files + `docs/connectors.md`.
4. **TypeScript bindings** — evidence: `bindings/` folder + `make gen-bindings` + `package.json`. But evidence of **usage** is low: no docs on how to use them. Medium-low confidence.
5. **CLI** (main.rs) — clear evidence but small in scope. Is it a package or part of "Engine"?
6. **Observability** (metrics + tracing) — rejected: not a package with its own responsibility; it is inline use.
7. **Storage layer** — rejected: does not exist. The repository does not persist state between flows; each flow is a clean execution.
8. **Scheduler** (suspected by runtime convention) — **NOT confirmed**. `scheduler.rs` exists but is 80 lines and appears to be a thin wrapper over tokio. Does not merit its own package.

### Rejected with reason

- **"Scheduler"** as a package: the file exists but does not contain a separate mental model. It is an implementation detail of the Engine.
- **"Memory model"**: not found. Not a runtime with its own allocator.
- **"Type system"**: the DSL appears dynamic. No type checking files found.
- **"DSL stdlib"**: not found. The DSL operators appear to be inline in `evaluator.rs`.

## Final packages

```
P1 — DSL: declarative flow language
  Why it exists:
    Converting .flow files into executable structures. Without this, there is no
    runtime to execute.

  Evidence:
    paths:  src/dsl/parser.rs, src/dsl/ast.rs, src/dsl/evaluator.rs
    docs:   docs/dsl-spec.md
    tests:  tests/unit/dsl_*.rs, examples/*.flow (8 language examples)

  Central pattern:
    The DSL describes pipelines as composition of operators with sinks.
    The AST captures that structure; the evaluator converts it into engine operations.

  Limits:
    Does NOT include sophisticated type checking (appears dynamic — medium confidence).
    Does NOT include execution (that is P2).
    Does NOT include connection to external systems (that is P3).

  Relations:
    - Feeds P2 (Engine): the evaluated AST produces the operations the engine runs.
    - Independent from P3 (Connectors): the DSL references sinks by name, not by implementation.

  Confidence: high.
    Clear paths, specific docs, abundant examples.

P2 — Engine: flow execution runtime
  Why it exists:
    Executing the operations the evaluator produces. It is the heart of the running system.

  Evidence:
    paths:  src/engine/runner.rs, src/engine/engine.rs, src/engine/scheduler.rs
    docs:   docs/architecture.md
    tests:  tests/integration_flow_*.rs (4 end-to-end flows)
    deps:   tokio (async runtime)

  Central pattern:
    Async execution loop on top of tokio that orchestrates DSL operations and
    channels them toward sinks. The "scheduler" here is thin — orchestration, not
    planning.

  Limits:
    Does NOT include the language (that is P1).
    Does NOT include the concrete sinks (that is P3).
    Inference: the scheduler appears to be a thin wrapper over tokio — confirm with
    deeper reading of scheduler.rs.

  Relations:
    - Depends on P1 (DSL): consumes its evaluated AST.
    - Depends on P3 (Connectors): sends data to sinks via the Sink trait.

  Confidence: high on responsibility. Medium on internal details
  of the scheduler (not read in depth).

P3 — Connectors / Sinks: integration with external systems
  Why it exists:
    This is where FlowMint connects to the world. The Sink trait is the documented
    extension point and the 5 connectors implement it.

  Evidence:
    paths:  src/io/sink.rs (trait), src/io/connectors/{http,kafka,pg,s3,fs}.rs
    docs:   docs/connectors.md (how to add a sink)
    deps:   sqlx, rdkafka, aws-sdk-s3

  Central pattern:
    Adapter pattern. A `Sink` trait that defines how to write data. The 5
    connectors implement it for different destinations. It is FlowMint's extension point.

  Limits:
    Does NOT include sources (no Source trait equivalent to Sink found — confirm).
    Does NOT include intermediate transforms (those live in the DSL/Engine).

  Relations:
    - Consumed by P2 (Engine): the engine sends data to sinks.
    - Independent from P1 (DSL): the DSL only references them by name.

  Confidence: high. Clear trait, uniform implementations, explicit doc.

P4 — Public interface: lib.rs + CLI + bindings
  Why it exists:
    FlowMint can be used in three ways: CLI (flowmint run), embedded Rust
    library (lib.rs exports), or from TypeScript (bindings). Deciding which to use
    is the first integration decision.

  Evidence:
    paths:  src/main.rs, src/lib.rs, bindings/
    configs: package.json (tsup), Makefile (gen-bindings)
    docs:   README (mentions all 3 modes)

  Central pattern:
    Same machine, three entry surfaces. The surface changes the operational shape
    (separate process vs embedded vs cross-language) but not the mental model.

  Limits:
    Does NOT include actual execution (that is P2).
    Does NOT include the sinks (that is P3).

  Relations:
    - All three surfaces ultimately invoke P2.
    - TS bindings are in evidence, but their maturity is uncertain — docs on
      usage are lacking.

  Confidence: high on the existence of the 3 surfaces. Medium on the
  TS bindings (little doc on real adoption).
```

## Suspected packages not confirmed

```
Possible package: Sources (input to the runtime).
  Suspicion: by symmetry with Sinks. A "flows" runtime usually has a data
  source in addition to a destination.
  State: not confirmed. No Source trait equivalent to Sink found.
  Possible: sources live embedded in the DSL (a `from(...)` operator
  could read from http/file/etc.). Confirm by reading evaluator.rs.
  Need: review src/dsl/evaluator.rs or ask the user if they know.

Possible package: Lifecycle / bootstrap.
  Suspicion: typical in embedded runtimes.
  State: not confirmed. main.rs and lib.rs are small — no separate
  bootstrap package.
  Probably NOT a separate package in this repository.

Possible package: Error handling.
  Suspicion: anyhow is in deps, there could be an explicit strategy.
  State: not confirmed, appears cross-cutting (anyhow + inline errors in each
  module) and does not merit its own package.
```

## Recommended order

For the user's goal (decide whether to integrate + identify risks + know what to touch first):

```
P1 (DSL) → P3 (Connectors) → P2 (Engine) → P4 (Public interface)
```

Justification:

- **P1 first**: to evaluate whether FlowMint works, you need to understand what kinds of flows it can express. The DSL is the external face of the product.
- **P3 second**: to evaluate whether it **can integrate with the user's stack**, you need to see the 5 existing connectors and know how easy it is to add one. This resolves "can it talk to our Postgres / Kafka / etc."
- **P2 third**: the engine is the heart, but the user needs to understand it after knowing what it does and what it connects to. This is also where the operational risks live (performance, observability, failure mode).
- **P4 fourth**: deciding which surface to use (CLI / embedded lib / TS) is the final integration decision, not the first.

## Core / secondary / optional packages

- **Core**: P1 (DSL), P3 (Connectors), P2 (Engine).
- **Secondary**: P4 (Public interface) — important for the final decision but not for understanding the system.
- **Optional**: confirm the suspected "Sources" package if the user decides to go deeper.

## First package to install now (P1 expanded — short format, not full)

**P1. DSL: a declarative flow language**

**The idea:** FlowMint uses a declarative DSL to describe pipelines as a composition of operators that end in one or more sinks.

**How it works:** a `.flow` file is parsed into an AST. The AST is evaluated against the engine, producing operations. Those operations run async, channeling data toward the sinks referenced by name.

**An example (from the repository),** `examples/etl_postgres_to_s3.flow`:

```
flow "daily_export" {
  from postgres("orders") where created_at > yesterday()
  transform |row| { ... }
  to s3("archive/$(date).json")
}
```

**When to use it:** any time you want to design a data flow without writing Rust. The DSL is the first thing a new user touches.

**Where it breaks:** it doesn't work for complex imperative logic or for flows that carry state across executions. For those you drop down to the Rust engine directly.

**Related:** feeds P2 (the engine); references P3 (connectors) by name.

*Confidence high. Provenance: parser/ast/evaluator + docs/dsl-spec.md + 8 examples come from the source. Inference: the DSL looks dynamic (no type checker found), confirm. Open question: how it behaves on runtime type errors.*

## How to continue from here

```
1. Install P1 (already expanded above). Review 2–3 .flow examples to see the
   language in real use.
2. Request deeper exploration of src/io/sink.rs and src/io/connectors/* to validate
   whether the 5 existing connectors cover the user's stack.
3. Confirm the suspected "Sources" package by reading src/dsl/evaluator.rs.
```

## What I did NOT do (intentional)

- **Did not** call P2 "scheduler" or "execution model" + "memory model" + "type system" as a "runtime" template would have. The apparent scheduler is a thin wrapper and does not merit its own package.
- **Did not** create packages "core" / "internals" / "extension points" as a "library" template would have. That structure does not represent how this repository is organized.
- **Did not** assume there was "state management" or a "stdlib". No evidence found.
- **Did not** force the repository into "stream processor" despite sharing traits. Left it as hybrid and reasoned from its paths.
