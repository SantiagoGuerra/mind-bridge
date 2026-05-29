# Canonical Example — Fencing tokens

Gold-standard example of the Skill. Technical concept (distributed systems). Serves as reference for Mode 1 (learn) and Mode 2 (package).

## How we got here (flow summary)

1. **Orient**: target level = Solid Explain. To discuss consistency with a technical peer.
2. **Decompress**: the prior problem is that a worker holding a lock can pause, lose the lock without knowing it, and wake up late.
3. **Central pattern**: a stale actor can act late and cause damage.
4. **Minimal example**: two workers, one shared resource, one token per authorization.
5. **Analogy with limit**: like a ticket number in a queue — the clerk only serves the newest one. Breaks when there are multiple windows and the queue is not global.
6. **Limits**: only applies if the final resource can inspect and compare tokens.
7. **Package**: see package below.
8. **Connect**: locks, leases, idempotency, optimistic versioning, stale writes.
9. **Serialize**: 30-second explanation for different roles.
10. **Validate**: counter-example where it does NOT apply.
11. **Expand**: only if we move to Implement (e.g. how the monotonic token is issued safely).

## Long package

```
CONCEPT: Fencing tokens

CENTRAL PATTERN:
A stale actor can act late and cause damage.

PROBLEM:
A worker holding a lock can pause (GC, swap, network partition), lose the lock without realizing it, then wake up and try to continue the operation. If the shared resource cannot distinguish the current worker from the stale worker, the stale one overwrites the new worker's work.

MECHANISM:
Each authorization (lock, lease) emits a monotonically increasing token. The final resource tracks the highest token it has seen and rejects operations with lower tokens. Thus, if a paused actor wakes up late with a stale token, the final resource explicitly rejects it.

EXAMPLE:
Worker A receives token 41 and starts writing.
Worker A pauses due to GC.
The lock expires, Worker B receives token 42 and completes its write.
Worker A wakes up and sends its write with token 41.
The final resource sees 41 < 42 and rejects A's operation.

COUNTER-EXAMPLE:
Does not apply if the final resource cannot inspect and compare tokens (e.g. a legacy filesystem without versioning). Also does not apply to coordination problems between current actors — tokens only protect against stale actors waking up late.

RELATIONS:
- Distributed locks: the base problem they create.
- Leases: the abstraction that emits the tokens.
- Idempotency: complementary approach, does not solve the same thing.
- Optimistic versioning: same family of patterns.
- Stale writes: the concrete damage to prevent.

USE:
When there are actors that can pause and a shared resource that has to decide which operation to honor. Appears in systems with leases (Zookeeper, Etcd), Kafka coordination, systems with master-replica.

30-SECOND PITCH:
A fencing token prevents a stale worker from acting after losing the lock. Every time someone gets permission, they receive an increasing number; the final resource only accepts operations with newer tokens. So if a paused process wakes up late, its stale token is rejected.

TARGET LEVEL: explain
TAUGHT LEVEL: explain
VALIDATED LEVEL: explain
CONFIDENCE: high
SOURCE: Designing Data-Intensive Applications, ch. 8 (Kleppmann)
ANCHOR WORDS: distributed locks, leases, stale writes, monotonic tokens
NEXT BRANCH: how the monotonic token is issued safely (Zookeeper sequential znodes, etcd revision number).
STATE: validated
```

> **Note**: this package is shown in final `validated` state to serve as a gold-standard. The first output of Mode 1 would have had `VALIDATED LEVEL: pending` and `STATE: ready-for-validation`. These fields only advance after passing Mode 4, shown below.

## Validation (Mode 4)

- Central pattern: ✓ "stale actor acting late"
- Mechanism: ✓ "increasing token + rejection at the final resource"
- Own example: ✓ workers A/B with tokens 41/42
- Counter-example: ✓ resource without capacity to compare tokens
- Relations: ✓ family identified
- Application: partial — control question: "how would this change with multiple final resources sharing state?"
- Serialization: ✓ 30s with pattern + mechanism + example

Validated level: Solid Explain. Ready for Apply if the implementation branch is opened.

## Serializations (Mode 3)

**For senior engineer (30s)**:
"When a worker can pause and lose a lock without knowing it, fencing tokens are the guardrail: the final resource only accepts operations with a newer monotonic token. The stale worker wakes up with an expired token and the system rejects it with no damage."

**For PM (10s)**:
"It's a guardrail so that a process that fell asleep doesn't overwrite the work of the process that took its place."

**For Slack to a junior (30s)**:
"Imagine two cashiers can receive 'turn tickets'. The system only listens to the ticket with the highest number it has seen. If a cashier falls asleep and wakes up with a stale ticket, they're ignored. That's fencing tokens."

**For CEO (10s)**:
"It's the safeguard that ensures a 'forgotten' process in the system doesn't overwrite the work of the one that already took its place."

## Short version of the package

```
CONCEPT: Fencing tokens
CENTRAL PATTERN: A stale actor can act late and cause damage.
MECHANISM: Each authorization emits a monotonic token; the final resource rejects tokens lower than the highest seen.
USE: Worker coordination over shared resource when there is a risk of pauses (GC, network).
```

## Templates

- `templates/concept-package.md` (long version)
- `templates/validation.md` (mini-rubric)
