# Template — Serialization formats by audience

Loaded from Mode 3 (serialize). The single source of truth for "who is the audience and how do I shape the message for them".

## Pre-flight (before any serialization)

If the package contains a **vendor-specific or version-specific claim** (e.g. "Stripe's TTL is 24h", "Kafka default retention is 7d", "Postgres 16 supports X"), **run a double-check via websearch BEFORE emitting the serialization** — not after. If websearch is unavailable, label the claim inline (`unverified — confirm before sending`) so the human reader can verify, and tell the user explicitly that you couldn't verify. Rationale: a polished serialization with an unverified vendor claim travels faster than the caveat that follows it.

## Canonical lengths

| Length | Form | Contains |
|---|---|---|
| **10 seconds** | 1 sentence | Pattern + consequence. No mechanism. |
| **30 seconds** | 3–4 sentences | Pattern + mechanism + example. No theory. |
| **3 minutes** | ~6–10 sentences or bullets | Complete structure, developed example, one analogy with its limit. |
| **Technical doc** | Markdown with headers | Pattern / Mechanism / Example / Trade-offs / When not to apply / References. |
| **Executive pitch** | 1 paragraph + 1 number | Consequence + explicit trade-off + 1 decision that unlocks. |

## Six canonical audiences

For audiences not listed here, derive from the closest one and adjust. The matrix at the end gives the rules.

### 1. Developer / peer engineer

Standard technical vocabulary. Explicit mechanism. Pseudocode or snippets if useful. Real operational trade-offs.

**30s example (fencing tokens)**:
> "When a worker can pause and lose a lock without knowing, fencing tokens are the guardrail: the final resource only accepts operations with a monotonic new token. The old worker wakes up with a stale token and the system rejects it without damage."

### 2. Senior / staff engineer

Architecture-level. Systemic trade-offs, failure modes, operational consequences. Mechanism assumed known; emphasis on consequence. Comparison with alternatives when relevant.

**30s example (event sourcing)**:
> "Event sourcing inverts direction: current state is derivable, not the ground truth. That pays you replay, multiple views, and audit for free. It costs: every consumer must be idempotent, schemas must evolve forward/backward, and storage grows linearly. Trade-off: upfront complexity for operational flexibility."

### 3. Product manager

Focus on value, observable behavior, product decision. Mechanism translated to feature/flow. No code. Product trade-off, not implementation.

**30s example (invisible product debt)**:
> "Every optional feature we accept today is an invisible constraint on tomorrow's roadmap. It doesn't produce bugs, only erodes product evolution velocity. When someone says 'this is almost free', ask yourself: what invisible weight will we carry afterward?"

### 4. CEO / business / founder

Start with consequence, not mechanism. Explicit trade-off in one sentence. Mechanism only if asked. Risk, opportunity, decision.

**30s example (vector databases for a CEO)**:
> "Vector databases are what make it possible to search by meaning, not by exact words — the engine behind 'recommend me something similar to this'. The decision in front of us: use a managed one (fast, recurring cost) or self-host (more control, dedicated team). The main risk is picking one whose API changes within a year and locks us in."

### 5. Non-technical stakeholder / external client

Concrete benefit. No jargon, no mechanism. Everyday analogy. One idea per message.

**10s example (passkey for a client)**:
> "Instead of passwords, you use your own device as the key. Faster to get in, harder to steal."

### 6. Meeting / Slack (oral or chat)

**Meeting (oral)**:
- A memorable **headline** in one sentence.
- 2–3 **supporting points** behind the headline.
- A **story or number** that anchors.
- Close with explicit **next step**.

```
HEADLINE (what people will remember walking out):
SUPPORT 1:
SUPPORT 2:
SUPPORT 3 (optional):
STORY / NUMBER:
NEXT STEP:
```

**Slack**:
- Bullets ok. Code fences if technical.
- Emojis only as state markers (✅ ❌ ⚠️), never decorative.
- Direct style, ≤6 lines for the main message; thread for details.

```
⚠️ Before accepting that new toggle:
- Every extra option restricts what we can change later.
- Doesn't produce bugs, erodes velocity.
- Review question: what invisible weight will we carry afterward?
```

## Quick matrix

| Audience | Start with | Mechanism | Analogy | Trade-off |
|---|---|---|---|---|
| Developer | Pattern | Yes, explicit | Optional | Yes, technical |
| Senior engineer | Trade-off | Yes, assumed | If comparative | Yes, systemic |
| PM | Observable behavior | No (unless asked) | Optional | Yes, product |
| CEO | Consequence | No | Useful | Yes, in 1 sentence |
| Non-technical | Benefit | No | Yes, everyday | Only if it matters to them |
| Meeting / Slack | Headline / key point | Summarized | One | Summarized |

## Cross-cutting quality rules

- **The 30s version must contain pattern + mechanism + example** — not just definition. If only definition, rewrite.
- **One new idea per message** for junior or non-technical audiences.
- **If an analogy appears, mark where it breaks** (except in 10-second versions).
- **Never serialize for "generic audience"**. If unclear, ask.
- **Message goal changes emphasis**: explain vs convince vs sell vs align vs inform. Ask if unclear.
- **Preserve the central pattern across all versions**. If the CEO version no longer contains the central idea, it's broken.

## Verification before delivery

- [ ] Preserves the central pattern?
- [ ] Vocabulary matches the audience?
- [ ] Fits the requested length?
- [ ] 30s version contains pattern + mechanism + example?
- [ ] If executive or meeting: clear next step or memorable headline?

## Extending to other audiences

If the user asks for an audience not listed (junior developer, designer, customer support, recruiter, etc.):

1. Identify the closest canonical audience (developer / senior / PM / CEO / non-technical / meeting-or-Slack).
2. Apply that row of the matrix.
3. Adjust 1–2 dimensions for the specific audience (e.g. junior developer = developer + more analogy + one technical idea at a time).
4. State the adjustment explicitly: "I'm treating junior developer as developer + slower + analogy-first."
