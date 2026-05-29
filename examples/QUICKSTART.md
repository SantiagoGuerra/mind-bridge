# Quickstart — Compact behavioral references

> These are **compact** examples of mind-bridge usage. They show the minimum useful output for each common pattern, not the maximum. Long examples in this folder are **behavioral references, not required output length** — most real outputs should look more like these.

## Index

1. Learn a new concept (Mode 1 + Fast modifier)
2. Package a known concept (Mode 2)
3. Serialize for a meeting (Mode 3, Communication modifier)
4. Validate understanding (Mode 4)
5. Ingest a partial source as a scoped roadmap (Mode 10)
6. Duo `aligned` state (Mode 13)

---

## 1. Learn a new concept (Mode 1 + Fast modifier)

**User**: "Quick teach me fencing tokens — explain level."

**Skill** (compact output):

CONCEPT: Fencing tokens
CENTRAL PATTERN: A late actor can act after losing authority and cause damage.
MECHANISM: Each lock acquisition increments a monotonic token; downstream operations reject any token lower than what they've seen.
EXAMPLE: Process A holds lock with token=7, GC-pauses; process B acquires lock with token=8 and writes; A wakes and tries to write with token=7 → storage rejects.
USE: Distributed locks where the protected resource itself can verify the token.

TAUGHT LEVEL: explain
VALIDATED LEVEL: pending
STATE: ready-for-validation

> 5 fields total. No 5-question intake. Defaults declared: `goal=understand, level=explain, success=explain in 30s`.

---

## 2. Package a known concept (Mode 2)

**User**: "Package this concept I already understand: idempotency in payment processing."

**Skill** (compact output):

CONCEPT: Idempotency in payment processing
CENTRAL PATTERN: Same request applied N times produces the same effect as applying it once.
MECHANISM: Client generates an idempotency key per intent; server records (key → result) for a TTL; duplicate keys return the cached result instead of re-executing.
EXAMPLE: Stripe's `Idempotency-Key` header on POST /charges — retrying with the same key returns the original charge object.
COUNTER-EXAMPLE: A request that mutates external state without keying (e.g., POST without an idempotency key over a flaky network) double-charges on retry.
USE: Any POST/PUT/PATCH over an unreliable channel where the client must safely retry.

STATE: packaged

> No interactive teaching happened — `packaged`, not `installed`. To promote to `installed`, run Mode 4.

---

## 3. Serialize for a meeting (Mode 3, Communication modifier)

**User**: "Turn this package into a 30s version for our staff eng meeting."

**Skill** (compact output):

> Meeting opener (30s):
> "Idempotency is the property where the same request applied N times produces the same effect as one. We need it because retries are inevitable on unreliable networks. The standard implementation is client-generated idempotency keys + server-side dedup with a TTL. The risk we should discuss is what TTL we pick — too short and replays after recovery still double-execute; too long and we burn storage."

> One slide:
> - Title: Idempotency = "safe to retry"
> - Body: client key → server dedup → cached result for TTL
> - Decision needed: TTL window (current: 24h)

STATE: unchanged (`packaged`). Serialization does not mutate package state.

---

## 4. Validate understanding (Mode 4)

**User**: "Validate that I understand idempotency at the apply level."

**Skill** runs mini-rubric:
1. Own explanation in 60s (user gives it).
2. Mechanism in own words.
3. Own example (different from the cached one).
4. Counter-example or limit.
5. Apply to a new case the Skill proposes.

If all 5 pass: STATE → `installed`, VALIDATED LEVEL → `apply`.
If 1–3 pass: STATE → `partially-installed`; Skill names which dimension failed.
If <1 pass: STATE stays `ready-for-validation`; Skill suggests Mode 5 (Expand) on the weak branch.

---

## 5. Ingest a partial source → scoped roadmap (Mode 10)

**User**: "Here are 5 of the 12 chapters of the Raft paper. Learning roadmap."

**Skill** (compact output):

SOURCE COVERAGE:
  primary source acquired:  partial (5 of 12 sections loaded)
  text coverage:            partial
  source coverage:          partial
  confidence:               medium for covered sections / unknown for missing
  definitive roadmap?       no
  scoped roadmap?           yes

SCOPED ROADMAP — Raft (sections 1–5):
- P1: Leader election (covered, high confidence)
- P2: Log replication (covered, high confidence)
- P3: Safety properties (partially covered, medium)
- [P4–P7 deferred — not in loaded sections]

SUCCESS CRITERION (from user):
- Be able to explain why Raft needs leader leases.

> Scoped, not definitive. Per-phase in/out declared. No invented chapter numbers.

---

## 6. Duo `aligned` state (Mode 13)

**User**: "A and I (B) want to sync our understanding of event sourcing."

**Skill** runs Duo flow:
1. Silent intake: each writes their version privately.
2. Compare → name the deltas.
3. Merge → one package.
4. Each gives 30s explanation of merged package, separately.

**Closing**:
> Collaborative state: `aligned` (both can give their own 30s explanation with pattern + own example).
> NOT `installed (collective)` — that would require per-participant full mini-rubric (own explanation + mechanism + own example + counter-example + apply to new case).

---

## What this file is for

These are the **defaults**. The full examples (`fencing-tokens.md`, `clrs-book-roadmap.md`, `duo-sync-session.md`, etc.) are detailed behavioral references — read them to understand edge cases, not to set output length. Most outputs should look more like the compact patterns above.

When in doubt, prefer the compact form. The user can always ask "expand" / "go deeper" — but verbosity by default is a failure mode.
