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

```
CENTRAL PATTERN: Different replicas can hold different values temporarily, but all converge to the same state if there are no new writes.

MECHANISM:
1. A write arrives at a replica (primary or any).
2. The replica accepts the write and responds to the client.
3. The write propagates to the rest in the background.
4. Until propagation completes, reads on different replicas may see different versions.
5. If no new writes arrive, all replicas eventually reach the same state.

CATALOG EXAMPLE:
A seller updates a product's price. The write goes to the EU replica. Before it propagates to US, a user in US loads the product and sees the old price. 200ms later it propagates; subsequent loads in US see the new price.
```

### Bruno's version

```
CENTRAL PATTERN: The system gives up on immediate consistency to gain availability and latency; eventually everything aligns.

MECHANISM:
1. Writes are accepted at any available node (multi-master).
2. Each node stores the version with a timestamp / vector clock.
3. Versions are synchronized asynchronously between nodes.
4. When two nodes diverge on the same record, it is resolved with a rule (last-write-wins, CRDT, custom merge).
5. After a "sufficient" amount of time with no writes, all nodes agree.

CATALOG EXAMPLE:
If a seller in EU updates the price and an admin in US updates it at the same second, the two changes arrive at different nodes. When they synchronize, the system has to decide which one wins — and that is bug-prone if we don't define it well.
```

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

```
MERGED PACKAGE — Eventual consistency in the catalog

CONCEPT: Eventual consistency applied to single-master with read replicas

CENTRAL PATTERN:
Read replicas may show stale data briefly; we accept that staleness to lower read latency and reduce load on the primary. (Provenance: agreement, fusion of both versions — Ana's behavior + Bruno's tradeoff.)

PROBLEM:
Without read replicas, all reads hit the primary → latency + saturation. With read replicas, the system scales reads but replicas are not perfectly synchronized. The question is: how much staleness is acceptable for the catalog case? (Provenance: emerged in discussion.)

MECHANISM (single-master Postgres with read replicas):
1. Write arrives at the primary, committed to main Postgres. (Provenance: Ana step 1+2.)
2. The primary responds to the client with commit. (Ana.)
3. The primary sends WAL to replicas asynchronously (logical or streaming replication). (Ana step 3.)
4. Replicas apply the WAL; lag depends on load + network. (Ana step 4, refined by Bruno.)
5. Until the WAL arrives and is applied, reads on a replica may see an old version. (Ana step 4.)
6. After the lag, the replica converges to the newest version. (Ana step 5.)

EXAMPLE (from the catalog):
Seller in EU updates a product's price at 14:00:00. Write goes to primary (EU-1), commit OK. Read replica in US-1 receives the WAL ~150ms later and applies it ~50ms after that. Total: ~200ms window in which a user in US may see the old price. (Provenance: Ana, validated by Bruno as representative of the current setup.)

COUNTER-EXAMPLE / WHERE IT DOES NOT APPLY:
- Does not apply to writes: any write must go to the primary. Eventual consistency lives only in the read path.
- Does not apply to operations requiring "read your own write" in real time (e.g. seller updates price and refreshes their own view). For that case, read is forced to primary or sticky session to primary.
- Does not apply to the multi-master model with concurrent conflicts (Bruno mentioned this; we leave it as an unopened branch — does not apply to the current catalog).

RELATIONS:
- Synchronous vs async replication: this is async; synchronous would give strong consistency but kills latency.
- CAP theorem: under network partition, AP (availability + partition tolerance), not CP.
- Read-after-write consistency: the concrete operational problem to design against.
- Multi-master / CRDTs: unopened branch for your current architecture.

USE:
- Catalog reads in the hot path (product page, search, listing): accept staleness ≤ a few seconds.
- Reads that the seller themselves makes of their just-edited product: force primary or wait for visible confirmation.
- Reads for checkout / payment: pending definition (Pending Decision below).

30-SECOND PITCH (agreed):
We have the catalog in Postgres single-master with read replicas. Reads hit replicas to lower latency, but replicas run ~200ms behind the primary. We accept that staleness in the hot path. What we cannot accept staleness for: the seller's read-your-own-write, and what we're deciding today is whether checkout can or cannot.

PROVENANCE BY FIELD:
  central pattern: agreement after discussion (fusion of the two focuses).
  problem: emerged in discussion.
  mechanism: Ana, refined with WAL detail by Bruno.
  example: Ana, validated by Bruno.
  counter-example: Bruno's multi-master branch was marked "does not apply here" — useful for the future.
  use: agreement.

PENDING DECISIONS:
  - Does checkout / payment read from replicas or from primary? — requires looking at the "add to cart" flow to decide if staleness can cause stock overbooking.
  - What is the acceptable lag SLA we monitor? — define metric.

DECLARED WEAKNESSES:
  - We don't measure the current replica lag; the "~200ms" is an estimate, not data.
```

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
