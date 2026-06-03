# Canonical Example — Duo sync session

> Note: this example is a behavioral reference, not required output length. The state reached is `shared explanation confirmed`; for `installed (collective)` a full mini-rubric per-participant would be required.

**TL;DR**: Two engineers (Ana and Bruno) believe they share the same mental model of "eventual consistency" before deciding on read replicas. The silent intake reveals they were talking about different architectures (single-master vs multi-master) using the same name. The Skill places both versions side by side without merging them prematurely, directs questions to whoever has the freshest context, and produces a merged package with explicit provenance per field. Dual validation confirms installation in both. If you only read this example once, look at: (1) the two initial versions contrasted (Step 2), (2) the directed question that resolves the root difference (Step 3), and (3) the final note on why this case warranted Mode 13 and not two individual sessions.

Gold-standard example of Mode 13. Synthetic case: two engineers (Ana and Bruno) believe they understand the same thing about "eventual consistency" and need to sync before making a technical decision.

## Setup

Initial message (in a shared channel):

> **Ana**: "Bruno, before finalizing the replica design for the catalog module, we need to make sure we have the same mental model of eventual consistency. I learned it in a course, you learned it in production. Let's use mind-bridge."

## Collaboration Intake (Skill asks the minimum)

> Skill: "I'll facilitate this as Mode 13 (Duo). Before we start, three things: (1) Is the topic 'eventual consistency' in the abstract, or applied to your catalog module? (2) What is the upcoming decision? — to understand the useful output. (3) Can both of you write in silence for 5 minutes without seeing each other?"

> **Ana**: "Applied to the catalog. Decision: whether catalog reads can be stale or not, and how much. Yes, we can write separately."
> **Bruno**: "+1."

## Step 1 — Silent intake

Skill (private message to each, in parallel):

> "Without seeing the other person, write now:
> - CENTRAL PATTERN in one sentence.
> - MECHANISM in 3–5 steps.
> - ONE concrete example from the catalog.
>
> When you're done, paste your full version in the channel. Do NOT read the other person's until both have pasted."

### Ana's version

**The idea:** different replicas can hold different values temporarily, but they all converge to the same state if no new writes arrive.

**How it works:**
1. A write arrives at a replica (the primary, or any).
2. The replica accepts the write and responds to the client.
3. The write propagates to the rest in the background.
4. Until propagation finishes, reads on different replicas can see different versions.
5. If no new writes arrive, all replicas eventually reach the same state.

**An example (catalog):** a seller updates a product price. The write goes to the EU replica. Before it propagates to the US, a user in the US loads the product and sees the old price. About 200ms later it propagates, and later loads in the US see the new price.

### Bruno's version

**The idea:** the system gives up immediate consistency to gain availability and latency; eventually everything lines up.

**How it works:**
1. Writes are accepted at any available node (multi-master).
2. Each node stores the version with a timestamp or vector clock.
3. Versions sync asynchronously between nodes.
4. When two nodes diverge on the same record, a rule resolves it (last-write-wins, CRDT, custom merge).
5. After "enough" time with no writes, all nodes agree.

**An example (catalog):** if a seller in the EU updates the price and an admin in the US updates it in the same second, the two changes land on different nodes. When they sync, the system has to decide which one wins, and that's bug-prone if we haven't defined it well.

## Step 2 — Reveal and comparison

Skill, in the shared channel:

```
COMPARISON — 2 versions:

CENTRAL PATTERN:
  Ana: "Different replicas can hold different values temporarily, but all converge."
  Bruno: "The system gives up on immediate consistency to gain availability and latency."
  Diff:
    Agreement: both describe eventual convergence.
    Difference of focus: Ana describes the BEHAVIOR (different replicas, they converge).
                        Bruno describes the TRADEOFF (gives up consistency for availability/latency).
    These are NOT contradictions — they are two views. The important thing is that Ana's version
    doesn't mention the tradeoff and Bruno's doesn't mention the "same state" explicitly.

MECHANISM:
  Ana assumes single-master with propagation to secondary replicas.
  Bruno describes multi-master with explicit conflict resolution.
  ⚠️ Fundamental difference, NOT vocabulary: they are thinking about different architectures.
  - In single-master with replicas (Ana): there are no conflicts by construction — the primary orders.
  - In multi-master (Bruno): conflicts are inevitable and require a strategy (LWW, CRDT, merge).

EXAMPLE:
  Ana: EU price change → US, 200ms propagation, user briefly sees old price. No conflict.
  Bruno: two concurrent changes in EU and US, conflict, explicit resolution.
  ⚠️ The examples match the architecture difference: Ana's has no conflict because she assumes
  single-master; Bruno's does because he assumes multi-master.

QUESTIONS RAISED BY THE SKILL:
  1. What is the actual architecture of your catalog? — this resolves the root difference.
  2. Are there actors writing concurrently (seller + admin + integration)? — this decides whether
     Bruno's difference matters for your decision.

TURNS:
  Ana: 1 input (silent intake).
  Bruno: 1 input.
  Asymmetry: none yet.
```

## Step 3 — Guided discussion

Skill:

> "Before merging, let's resolve the fundamental difference. **Bruno**, you work closest to the catalog infra — is it single-master with replicas or multi-master?"

> **Bruno**: "Single-master in Postgres with read replicas. We don't have multi-master."

> Skill: "Then Ana's model correctly describes your current architecture. **Ana**, do you agree that your example (briefly stale read, no conflict) is the real catalog case?"

> **Ana**: "Yes, that's our case."

> Skill: "Good. The difference Bruno introduced (multi-master + conflicts) is NOT relevant to your current architecture, but it would be if the catalog grew to multi-region with local writes. **Bruno**, confirm?"

> **Bruno**: "Confirmed. I mentioned it because I've seen that other mode in other systems, but it doesn't apply here today."

> Skill: "I'll mark 'multi-master architecture + conflict resolution' as an **unopened branch** for your current decision. If it evolves in the future, it gets reopened. Let's continue with single-master + read replicas."

Skill continues:

> "The tradeoff Bruno introduced (consistency vs availability/latency) — **Ana**, do you have that clearly in your version? It's what you didn't mention."

> **Ana**: "Yes, I have it, I just didn't write it. The reason for having replicas is to lower read latency without saturating the primary, and we accept staleness for that."

> Skill: "Good. We add it to the merged package."

## Step 4 — Synthesis

Skill produces the final package:

**Merged package: eventual consistency in the catalog**

*Concept: eventual consistency applied to a single-master setup with read replicas.*

**The idea:** read replicas may show stale data briefly; we accept that staleness to lower read latency and ease load on the primary. *(Provenance: agreement, a fusion of both versions, Ana's behavior view plus Bruno's tradeoff view.)*

**The problem it solves:** without read replicas every read hits the primary, which means latency and saturation. With read replicas the system scales reads, but the replicas aren't perfectly in sync. The real question for the catalog: how much staleness is acceptable? *(Provenance: emerged in discussion.)*

**How it works** (single-master Postgres with read replicas):

- A write reaches the primary and commits to main Postgres. *(Ana, steps 1-2.)*
- The primary responds to the client with the commit. *(Ana.)*
- The primary ships WAL to the replicas asynchronously, logical or streaming replication. *(Ana, step 3.)*
- Replicas apply the WAL; the lag depends on load and network. *(Ana step 4, refined by Bruno.)*
- Until the WAL arrives and is applied, a read on a replica can see an old version. *(Ana, step 4.)*
- After the lag, the replica converges to the newest version. *(Ana, step 5.)*

**An example (from the catalog):** a seller in the EU updates a product price at 14:00:00. The write goes to the primary (EU-1), commit OK. A read replica in US-1 receives the WAL about 150ms later and applies it about 50ms after that, so there's a roughly 200ms window where a user in the US can still see the old price. *(Provenance: Ana, validated by Bruno as representative of the current setup.)*

**Where it breaks:**

- Not for writes: every write must go to the primary. Eventual consistency lives only in the read path.
- Not for operations that need read-your-own-write in real time (a seller updates a price, then refreshes their own view). There the read is forced to the primary, or pinned with a sticky session.
- Not for the multi-master model with concurrent conflicts (Bruno raised it; left as an unopened branch, it doesn't apply to the current catalog).

**Related:** synchronous vs async replication (this is async; synchronous would give strong consistency but kill latency), the CAP theorem (under a partition this is AP, not CP), read-after-write consistency (the concrete operational problem to design against), and multi-master / CRDTs (an unopened branch for the current architecture).

**When to use it:**

- Catalog reads in the hot path (product page, search, listing): accept staleness of up to a few seconds.
- A seller's read of the product they just edited: force the primary, or wait for a visible confirmation.
- Reads for checkout / payment: still to be decided (see pending decisions).

**In 30 seconds (agreed):** "We run the catalog on single-master Postgres with read replicas. Reads hit the replicas to lower latency, but the replicas run about 200ms behind the primary. We accept that staleness in the hot path. What we can't accept staleness for is the seller's read-your-own-write, and what we're deciding today is whether checkout can."

*Provenance by field: central pattern from agreement after discussion (a fusion of the two focuses); problem emerged in discussion; mechanism from Ana, refined with WAL detail by Bruno; example from Ana, validated by Bruno; counter-example from Bruno's multi-master branch, marked "doesn't apply here" but useful later; use from agreement.*

*Pending decisions: does checkout/payment read from replicas or from the primary? (Needs a look at the add-to-cart flow to see if staleness can cause stock overbooking.) And what acceptable lag SLA do we monitor? (Define the metric.)*

*Declared weaknesses: we don't currently measure replica lag; the "~200ms" is an estimate, not data.*

## Step 5 — Dual validation

Skill (private to each):

> "Without seeing the other person or the merged package, write in 30 seconds how you would explain to a new team joiner what eventual consistency means in our catalog."

### Ana's version (30s)

> "We have Postgres with read replicas. Replicas run a bit behind (lag of hundreds of milliseconds) relative to the primary. For catalog reads that don't need to see the very latest, that's fine and saves us latency. For the seller's read-your-own-write, we read from the primary. What to do about checkout we still need to decide."

### Bruno's version (30s)

> "The catalog accepts that reads may be stale a little — ~200ms — to scale reads with read replicas. The primary is still the source of truth and all writes go there. We accept that staleness in the product path but not in flows where the actor just wrote or where the difference between 'old' and 'new' causes real errors, like checkout — which is what we're defining today."

### Comparison of the two validations

```
COLLABORATIVE VALIDATION:
  Ana: contains pattern ✓ / mechanism ✓ (summarized) / example ✓ (read-your-own-write) ✓
  Bruno: contains pattern ✓ / mechanism ✓ / example ✓ + explicit tradeoff ✓

Distribution: 2 of 2 → state `shared explanation confirmed` (own explanation + own example, without full mini-rubric).

Both mention the pending decision about checkout. Without coordinating with each other. That indicates the package reached `shared explanation confirmed` (not `installed (collective)` — that requires a full mini-rubric per-participant) and the pending point was clear to both.
```

## Step 6 — Close

```
SYNC STATE:
  Ana can explain: yes.
  Bruno can explain: yes.
  Collaborative state: shared explanation confirmed (not installed — mini-rubric per-participant not collected)
  Resolved differences:
    - Architecture (single-master vs multi-master): confirmed single-master, multi-master stays as unopened branch.
    - Focus (behavior vs tradeoff): merged — the package covers both.
  Unresolved differences:
    - None at the mental model level.
  Pending decisions (linked to the package):
    1. Checkout / payment: read from replica or primary? Owner: Bruno (closer to the flow). Deadline: this week.
    2. Lag SLA: what number do we accept before alerting? Owner: Ana. Deadline: this week.
  Declared weaknesses:
    - We don't measure current lag; the estimated "~200ms" is not validated with real data. Owner: Bruno. Deadline: before closing SLA.

NEXT STEP:
  - Bruno looks at the checkout flow and proposes whether it needs primary.
  - Ana defines the lag metric + alert.
  - Short 15-min meeting tomorrow to close the 2 pending decisions.

TURNS — FINAL DISTRIBUTION:
  Ana: 4 substantive inputs.
  Bruno: 5 substantive inputs.
  Asymmetry: none.
```

## Notes on what the Skill did NOT do

- **Did not merge versions prematurely**. It placed them side by side and flagged the differences before discussing.
- **Did not take sides** on single-master vs multi-master. It asked the person with fresh context (Bruno) rather than deciding.
- **Did not declare `installed (collective)`** — only `shared explanation confirmed`; installation would require a full mini-rubric per-participant.
- **Did not let the focus asymmetry pass** (Ana = behavior, Bruno = tradeoff). It named it and included it in the merged package.
- **Did not let pending decisions get buried**. It left them as explicit items with owner and deadline.

## Why this case warranted Mode 13 and not individual Mode 1 with each person

If each had done Mode 1 separately, **neither would have detected that they had a different mental model than the other**. The real sync is what avoided: "we thought the same thing" → "no, we were assuming different architectures". That friction only emerges in a compared silent intake.
