# Canonical example — Scoped roadmap from external input (partial source)

> **Use this as behavioral reference, not required output length.** This example is intentionally long to demonstrate every block (gates, scoped roadmap, success criterion, all 5 phases). In normal use, the Skill should produce **compact roadmaps** (3–5 phases, core packages only) unless the user explicitly asks for the full version. Compress normal outputs accordingly.

**TL;DR**: A user wants to learn an event system (EventCore, fictional — 12 sections, 80 pages) in order to **design a similar one** for a marketplace. The Skill detects Product modifier + apply level, runs the gates: acquisition ✓, completeness **partial** (8 of 12 sections read → **scoped roadmap, NOT a full-source roadmap**), multimodal partial (2 sequence diagrams not parsed), TOC N/A. Produces a scoped roadmap of 5 phases with 13 packages (P1–P13) tied to the user's success criterion. Each phase declares what is in/out. Only P1 (Append-only event log) is expanded. If you only read one thing from this example, look at: (1) the `SOURCE COVERAGE` block with its 3 coverage dimensions + the full vs scoped distinction, (2) ROADMAP METHODOLOGY, and (3) the expanded P1 with marked provenance.

> **Note v0.4**: an earlier version declared `State: partial` + `Can a definitive roadmap be produced?: yes`, which was contradictory. v0.4 distinguishes: partial source → **scoped roadmap** (bounded to the covered content), not a full-source roadmap. Details in `templates/source-coverage-gates.md`.

Gold-standard Skill example. Synthetic case (no copyright) for Mode 10 when magnitude is high and the correct output is a learning roadmap.

## Synthetic input

The user says:

> "I have this PDF of internal documentation for an event system called **EventCore** (fictional system). It has 12 sections, ~80 pages: ingest, transport, persistence, schema evolution, replay, idempotency, dead-letter, monitoring, capacity, security, ops, troubleshooting. I want to learn it to design something similar. Level: apply."

## Identified working mode

**Product modifier** — the user said "design something similar". This activates a minimum level of Apply (already given explicitly) and requires asking for APPLICATION CONTEXT.

**Double-check activated** — there are technical claims in the PDF (replication mechanisms, consistency models, consumer group patterns) and the user is going to apply the architecture. This activates websearch to verify metadata and contrast claims.

## Intake (what the user answered)

Blockers already present in the initial message:
- goal: apply (design something similar)
- level: apply
- application context: concrete product (assumed and confirmed)

Blockers that were missing:
- output: "decide by magnitude" → default
- success criterion: the Skill asks

> "Before processing: with Product modifier I need the product context and success criterion. What product/system are you going to design, and what should you be able to do by the end of this roadmap?"

User responds:

> "Order events in a marketplace, ~10k events/second at peak, several consumers deriving different views (mail, billing, inventory). By the end I want to: (1) decide the log shape and partitioning, (2) have a list of risks to prevent, (3) know what metrics to operate."

Intake resolved:
- output = decide by magnitude → high magnitude → roadmap
- success criterion = 3 concrete results (see SUCCESS CRITERION block below)

## Roadmap

```
SCOPED ROADMAP — EventCore (bounded to covered content)

SOURCE:
  Type: technical PDF documentation
  Topic: distributed event system (append-only event log)
  User's purpose: design a similar system for marketplace events, ~10k eps
  Target level: apply
  User context: concrete product (order marketplace)

SOURCE COVERAGE:
  primary source acquired:    yes
  source origin:              primary
  text coverage:              partial (8 of 12 sections read)
  source coverage:            partial (2 sequence diagrams in "replay" section not parsed)
  artifact coverage:          not applicable
  confidence:                 high for Phases 1–4; medium for Phase 5 (not covered in depth)
  Sections / elements covered: ingest, transport, persistence, schema evolution, replay,
                               idempotency, dead-letter, monitoring
  Sections / elements not covered: capacity (Section 9), security (Section 10), ops
                                   (Section 11), troubleshooting (Section 12); sequence
                                   diagrams from "replay"
  Parts at parsing risk: 2 sequence diagrams in the "replay" section
  Can a definitive roadmap of the full resource be produced?: no — 4 sections missing.
  Can a scoped roadmap (bounded to covered content) be produced?: yes — the 8 sections
                                   read cover the core concepts and mechanisms. Phase 5
                                   is explicitly marked as "operations, not covered in
                                   this pass", referenceable when the time to operate comes.
  TOC pasted by the user: N/A (not a book).

APPLICATION CONTEXT:
  Product / project: order marketplace
  Decision to be made: log shape + partitioning strategy + retention
  Audience: platform team (internal technical decision)
  Constraints: ~10k events/second at peak; multiple consumers with different purposes; no information about retention regulation (assume free for now, mark as open question)
  Key risks: event loss on hot partition; slow consumer blocking replay; schema changes breaking old consumers
  What the learning must produce: concrete design + list of prevented risks + monitoring plan

SUCCESS CRITERION:
  By the end of this roadmap you should be able to:
  - Decide the log shape for the marketplace (centralized vs per bounded context) and why.
  - Decide partitioning strategy (key, count, retention) and justify with trade-off.
  - List 5 concrete risks of the design and how they are mitigated.
  - Define the 3 minimum monitoring metrics to operate.
  Each phase of the roadmap connects to one or more of these results.

MAGNITUDE DIAGNOSIS:
  Magnitude: high
  Reason: 12 sections, clear dependencies between concepts, multiple layers of abstraction.
  Risk if packaged too early: the installation order is lost; idempotency stops making sense if "replay as first class" wasn't installed first.

CONTENT THESIS:
  EventCore is a distributed event log that prioritizes order, durability, and replay over low latency, assuming that consumers are idempotent.

GENERAL MAP:
  Kafka/Kinesis-type system: producers write events to a partitioned log, brokers persist with replication, consumers read in order and maintain their own offsets. The documentation covers design decisions at each layer plus operations.

DOUBLE-CHECK:
  What was verified:
    - That the "fencing tokens" concept mentioned in the "idempotency" section is the standard pattern (not idiosyncratic to the PDF).
    - That at-least-once + idempotent consumers is the dominant model in event-driven systems (vs exactly-once).
    - That the "log compaction" pattern (mentioned in passing in the PDF) is stable in Kafka/Pulsar.
  External sources used:
    - Official Apache Kafka documentation (design / ops sections).
    - Chapter 11 of "Designing Data-Intensive Applications" (Kleppmann) — conceptual reference.
  What was confirmed:
    - PDF model aligned with industry consensus. No contradictions detected in Phases 1–4.
  What was contradicted:
    - Nothing in the 8 sections read.
  What remains uncertain:
    - Throughput figures in the PDF (unsourced claims). Marked as "open question" in corresponding packages; do not use as benchmark.
  Impact on the roadmap:
    - No phase requires rewriting. P1–P10 remain high confidence. P11 (capacity) inherits the uncertainty about throughput figures.

ROADMAP METHODOLOGY:
  1. This roadmap is not a summary of the PDF. It is a sequence of conceptual installation.
  2. Do not open all phases at once. Phases exist to limit load.
  3. Each package is learned with: central pattern → problem → mechanism → example → limits → relations → serialization → validation.
  4. Phase 1 is installed completely first. Phases 2+ remain compressed.
  5. Within each phase, one package at a time.
  6. Secondary and optional packages stay compressed until needed.
  7. Validate each phase before advancing; if validation fails, do not advance.
  8. Since the target level is Apply to the marketplace (~10k eps), each phase closes with a decision / trade-off / risk applicable to the user's product — not with theory.
  9. Branch expansion (how N replicas are chosen, what retention to use, etc.) is done only when you ask for it.
  10. If your context changes (more events, GDPR, monolith vs microservices), we reorder the roadmap, we don't redo it.

  Stable IDs: use "open P4", "validate P2", "serialize P1 for meeting", "expand P7 to implement level", "reorder P3 for my marketplace".

PHASES:

PHASE 1 — Log foundations
  Goal: install the mental model of the append-only event log and why it replaces traditional queues.
  Why this phase goes here: without this model, any subsequent decision (replay, schema evolution, idempotency) has no frame.
  What must be installed by the end: that the log is not a queue; that consuming does not delete events; that each consumer's state is derivable.
  Packages:
  P1. Append-only event log
     - central pattern: the log is the ordered source of truth; consumers derive state.
     - why it goes here: conceptual prerequisite for everything else.
     - recommended level: explain
     - open now: yes
  P2. Key-based partitioning
     - central pattern: order is only guaranteed within a partition; the key defines the partition.
     - why it goes here: explains the limits of ordering; needed before making partitioning decisions.
     - recommended level: apply
     - open now: no
  Phase validation:
    - What is the operational difference between a traditional queue and an append-only log? Give a scenario.
    - Why is order only guaranteed within a partition?
    - What decides the routing of an event to a specific partition?
  Next action:
    Decision for your marketplace (success criterion #1): centralized log for all events or one per bounded context (orders/payments/fulfillment)? Trade-off: global order vs team autonomy.

PHASE 2 — Conceptual core
  Goal: understand the guarantees EventCore promises and why they cost what they cost.
  Why this phase goes here: guarantees (durability, order, replay) are the central design decisions.
  What must be installed by the end: explicit trade-off latency vs replicas; retention vs cost; replay as a normal operation.
  Packages:
  P3. Durability through replication
     - central pattern: an event is considered persisted when N replicas have confirmed it.
     - why it goes here: defines what "writing" means and what it costs.
     - recommended level: apply
     - open now: no
  P4. Per-consumer offset
     - central pattern: each consumer maintains its own pointer; no one deletes events by consuming.
     - why it goes here: breaks the queue intuition; enables replay and multiple consumers.
     - recommended level: apply
     - open now: no
  P5. Replay as first class
     - central pattern: recalculating state by reading the log from a previous offset is a normal operation.
     - why it goes here: justifies retention and schema evolution.
     - recommended level: apply
     - open now: no
  Phase validation:
    - What N replicas would you choose for your marketplace (~10k eps) and why?
    - What is the trade-off between long retention and cost for order events?
    - In what real situations would you do a replay?
  Next action:
    Decision (success criterion #1, #2): N=3 with quorum=2? Retention by time (14 days) or by size?

PHASE 3 — Mechanisms
  Goal: understand how the system maintains its guarantees against failures and changes.
  Why this phase goes here: these mechanisms are the inevitable consequence of Phase 2 decisions.
  What must be installed by the end: why idempotency is non-negotiable with replay; how to evolve schemas without breaking consumers.
  Packages:
  P6. Forward/backward schema evolution
     - central pattern: schema changes do not break old consumers or new producers.
     - why it goes here: replay requires reading old events with new code.
     - recommended level: apply
     - open now: no
  P7. Consumer idempotency
     - central pattern: the consumer processes the same event twice without harm.
     - why it goes here: at-least-once + replay guarantee duplicates.
     - recommended level: apply
     - open now: no
  P8. Dead-letter handling
     - central pattern: events the consumer cannot process go to a side channel.
     - why it goes here: prevents a poison event from blocking the partition.
     - recommended level: explain
     - open now: no
  Phase validation:
    - What schema policy (forward / backward / full) would you choose and why?
    - How would you make the "send confirmation email" consumer idempotent?
    - When dead-letter vs retry?
  Next action:
    Decision (success criterion #2): schema policy + idempotency strategy for your real consumers (mail, billing, inventory). Risk prevented: retroactive bug in billing from schema change without backward compatibility.

PHASE 4 — Application to your design
  Goal: ground the concepts in concrete decisions for the marketplace.
  Why this phase goes here: the target level is Apply; without grounding, the earlier phases stay inert.
  What must be installed by the end: mental schema of the system with marked decisions: partitioning, retention, consumer groups, monitoring.
  Packages:
  P9. Consumer group patterns
     - central pattern: one consumer per partition; balancing within the group.
     - why it goes here: defines how you scale readers without losing order.
     - recommended level: apply
     - open now: no
  P10. Lag monitoring
     - central pattern: the critical metric is the difference between the log's last offset and the consumer's.
     - why it goes here: the only reliable signal of consumer health in production.
     - recommended level: apply
     - open now: no
  Phase validation:
    - Design on paper the flow of an "OrderCreated" event from producer to three consumers (mail, billing, inventory). What fails if billing falls 1 day behind?
    - What metrics would you operate to detect problems before users notice them?
  Next action:
    Trade-off (success criterion #2, #3): more partitions for parallelism or fewer for cache locality / less overhead? Minimum metrics (criterion #3): lag per consumer, throughput per partition, dead-letter rate.

PHASE 5 — Optional deep-dive (not covered in depth in the PDF read)
  Goal: topics that only matter when operating in production.
  Why this phase goes here: designing well doesn't require knowing all failure modes; operating does.
  What must be installed by the end: know which topics you'll open when you get to operating.
  Packages:
  P11. Capacity planning
     - central pattern: the partition is the unit of parallelism and cost.
     - why it goes here: relevant only if you're going to operate it.
     - recommended level: apply (when you get to operating)
     - open now: no
     - open question: throughput figures in the PDF have no source; do not use as benchmark.
  P12. Security
     - central pattern: the log centralizes sensitive data; that's where you concentrate the surface.
     - why it goes here: matters when there is regulation or order PII.
     - recommended level: recognize
     - open now: no
  P13. Troubleshooting
     - central pattern: most incidents come from hot keys or slow consumers.
     - why it goes here: only if you're going to operate it.
     - recommended level: explain (when you get to operating)
     - open now: no
  Phase validation: deferred until opened.
  Next action: postpone until the base design is in place.

RECOMMENDED ORDER:
  P1 → P2 → P3 → P4 → P5 → P6 → P7 → P8 → P9 → P10 (Phase 5 optional)

CORE PACKAGES: P1, P2, P3, P4, P5, P7
SECONDARY PACKAGES: P6, P8, P9, P10
OPTIONAL PACKAGES: P11, P12, P13
```

## First package to install now (P1 expanded)

> **P1. Append-only event log**
>
> **The idea:** the log is the ordered source of truth; any consumer's state is just a derivative of the log.
>
> **The problem it solves:** with a traditional queue, an event is deleted once consumed. State ends up scattered across the queue, the database, and the consumers, with no single ordered source. Reconstructing what happened, replicating, or spinning up a new consumer from scratch is expensive or impossible.
>
> **How it works:** producers append events to the end of the log. The log persists each event with its offset (its ordered position). Events aren't deleted on consumption, only by retention policy (time or size). Each consumer keeps its own offset and reads from wherever it wants, so its state is always derivable by re-reading the log.
>
> **An example:** a billing service consumes "PaymentReceived" events. One day it finds a bug in how it calculated commissions for the past three months. Since the log keeps six months, billing deploys the fix, resets its offset three months back, reprocesses, and rebuilds its correct state. A traditional queue can't do this: the events are already gone.
>
> **Where it breaks:** it's not the right tool for request/response messaging (RPC) or for ephemeral data with no historical value (cursor positions in a collaborative UI). And it's a poor fit for sensitive events where keeping history is a regulatory risk (GDPR, where you design explicit deletion that breaks the pure append-only guarantee).
>
> **Related:** P2 (key-based partitioning: order only within a partition), P5 (replay, possible only because events survive consumption), P6 (schema evolution, needed because old events linger), P7 (consumer idempotency, needed because replay produces duplicates). Distinguish it from a traditional queue (pre-streams RabbitMQ), ephemeral pub/sub, and a database.
>
> **When to use it:** systems where history matters, where multiple consumers derive different views, and where reprocessing is legitimate. In your marketplace, mail, billing, and inventory all derive different views from the same "OrderCreated" event.
>
> **In 30 seconds:** "An append-only event log is a queue where nothing is deleted on consumption. Events stay, each consumer has its own pointer, and a consumer's state is a derivative of the log. That's why you can add new consumers, reprocess from the past, and keep several views of the same stream without coordinating them."
>
> *Provenance: log structure and offset mechanism come from the source (sections 1 and 2 of the PDF). The GDPR counter-example is inference, not in the text. The PDF says "log records"; renamed "events" here for consistency with your vocabulary. Double-check confirmed: aligned with official Kafka docs and Kleppmann ch. 11.*

## How to continue from here

```
1. Install P1 (already expanded above). After reading, answer the Phase 1 Validation.
2. Validate whether you already have Phase 1 installed (self-assessment with the 3 questions).
3. Reorder the roadmap: if your marketplace has a retention constraint (compliance >90 days impossible), move P5 (replay) to debatable and reopen APPLICATION CONTEXT.
```
