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

> **Fencing tokens**
>
> **The idea:** a stale actor can act late and cause damage.
>
> **The problem it solves:** a worker holding a lock can pause (GC, swap, a network partition), lose the lock without realizing it, then wake up and try to finish its operation. If the shared resource can't tell the current worker from the stale one, the stale worker overwrites the new worker's work.
>
> **How it works:** each authorization (a lock or a lease) hands out a number that only ever goes up. The shared resource remembers the highest number it has seen and rejects any operation that arrives with a lower one. So when a paused actor wakes up late carrying an old number, the resource turns it away.
>
> **An example:** Worker A gets token 41 and starts writing. A pauses for GC. The lock expires, and Worker B gets token 42 and finishes its write. A wakes up and sends its write with token 41. The resource sees 41 < 42 and rejects A.
>
> **Where it breaks:** it does nothing if the shared resource can't inspect and compare the tokens (say, a legacy filesystem with no versioning). It also won't help with coordination between two current actors. Tokens only protect against a stale actor waking up late.
>
> **Related:** distributed locks (the base problem), leases (what hands out the tokens), idempotency (a complementary approach, not the same fix), optimistic versioning (same family), stale writes (the concrete damage being prevented).
>
> **When to use it:** when actors can pause and a shared resource has to decide which operation to honor. It shows up in systems with leases (ZooKeeper, etcd), Kafka coordination, and master-replica setups.
>
> **In 30 seconds:** "A fencing token stops a stale worker from acting after it lost the lock. Every time someone gets permission they receive a rising number, and the resource only accepts operations with newer numbers. So if a paused process wakes up late, its old number is rejected."
>
> *Validated at the explain level. Confidence high. Source: Designing Data-Intensive Applications, ch. 8 (Kleppmann).*

Behind the card, the stored entry keeps the canonical values: `TARGET LEVEL: explain · TAUGHT LEVEL: explain · VALIDATED LEVEL: explain · CONFIDENCE: high · STATE: validated`. Anchor words: distributed locks, leases, stale writes, monotonic tokens. Next branch: how the monotonic token is issued safely (ZooKeeper sequential znodes, etcd revision number).

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

> **Fencing tokens:** a stale actor can act late and cause damage. Works by handing out a rising number on each authorization, with the shared resource rejecting any number lower than the highest it has seen. Reach for it when workers coordinate over a shared resource and could pause (GC, network).

## Templates

- `templates/concept-package.md` (long version)
- `templates/validation.md` (mini-rubric)
