# Canonical Example — Group session with roles (Mode 14)

> **Use this as behavioral reference, not required output length.** This example shows a full 4-person session end-to-end (silent intake, comparison, role-driven build, skeptic round, group validation, close). In normal use, the Skill should compress turns and outputs to fit the actual session length. **Aligned vs installed (v0.4)**: this example reaches `aligned` after the 4-participant 30-second validations. To declare `installed (collective)`, each participant would need to pass the full mini-rubric individually — not collected in this session.

**TL;DR**: 4 people (Product Lead, Senior Engineer, Designer, EM) build a shared package of "feature flag debt" before closing the Q3 roadmap. The Skill assigns roles (Concept Owner / Mechanism Builder / Example Maker / Skeptic), forces silent intake before discussion, which reveals that all 4 people had complementary visions of the same elephant. The Skeptic round generates 3 attacks that refine the package (distinguishes flags-that-are-debt vs flags-alive-by-design; clarifies that the solution is process not cleanup). Final validation: all 4 people explain the package in their own words, no one dominates. If you only read this example once, look at: (1) the comparison after silent intake (Step 2), (2) the Skeptic round (Step 4), and (3) the final observation on why Mode 14 ≠ 4 individual sessions.

Gold-standard example of Mode 14. Synthetic case: a 4-person team (eng + product + design) builds a shared package of "feature flag debt" as preparation for a roadmap decision.

## Setup

Initial message:

> **Lucía (Product Lead)**: "Team, before closing the Q3 roadmap I want us to align on what we call 'feature flag debt' and how we measure it. Everyone has a different idea and we've been discussing without making progress. Let's use mind-bridge in group mode."

Participants:

- **Lucía** — Product Lead (proposes the topic).
- **Marco** — Senior Engineer (works with flags day to day).
- **Sara** — Product Designer (suffers through flags in UX flows).
- **Diego** — Engineering Manager (decides prioritization).

## Role setup

> Skill: "I'll facilitate this as Mode 14 (Group, 4 people). Before we start, role assignment:
>
> - **Concept Owner**: Lucía (proposed the topic).
> - **Mechanism Builder**: Marco (closest to the flags code).
> - **Example Maker**: Sara (sees the flags in real flows).
> - **Skeptic**: Diego (decision-maker — must attack before accepting).
>
> OK? If anyone wants to switch roles, now is the time."

> All: "OK."

> Skill: "Total time: ~45 minutes. We'll do silent intake first (7 min), comparison + synthesis (20 min), skeptic round (10 min), group validation (8 min). If you have less time, let me know and I'll adjust."

> Lucía: "45 minutes is fine."

## Step 1 — Silent intake (7 min)

Skill (common instruction, each writes privately):

> "Without seeing each other, write in 7 minutes:
> 1. CENTRAL PATTERN in one sentence.
> 2. MECHANISM in 3–5 steps.
> 3. ONE concrete example from the product.
> 4. A question or doubt you have.
>
> When the timer ends, everyone pastes in the channel at the same time."

### Lucía's version (Concept Owner)

```
CENTRAL PATTERN: When we accumulate flags that no one cleans up, we lose the ability to know what our product does at any given moment.

MECHANISM:
1. We launch a feature with a flag for gradual rollout.
2. After a successful rollout, "rollout 100%" but the flag is not removed from the code.
3. Time passes, the flag is still there, other features assume it is ON.
4. When we want to modify the original feature, we don't know which flows are still conditioned by the flag.
5. Every new product decision costs more to analyze.

EXAMPLE:
We launched "checkout v2" with a flag 8 months ago. It's been at 100% for 6, but the old "checkout v1" code is still compiling inside the else. Yesterday Sara proposed a UX change to checkout and we had to spend 2 hours analyzing whether it affected the dead v1 path.

QUESTION: Is "feature flag debt" the same as "dead code"? I feel like it's not, but I can't articulate the difference.
```

### Marco's version (Mechanism Builder)

```
CENTRAL PATTERN: Flags are state — and like any state, they accumulate, contradict each other, and eventually no one can reason about them.

MECHANISM:
1. Each flag adds a logical branch in the code (if flag.X) or configuration (variant).
2. When 2 flags interact, there are 2² = 4 possible combinations.
3. When there are N flags, there are 2^N combinations. The vast majority are never tested.
4. When someone makes a change in code touched by a flag, they can't test all the combinations — they just assume which one is active.
5. Bugs appear in production that only occur with a specific combination no one considered.

EXAMPLE:
We have ~80 active flags in backend today. Last week a bug reached production because the combination "flag_pricing_v2=on + flag_legacy_currency=on" generated a NaN price. No one tested that combination because it was "obvious they aren't used together" — and it turned out a customer activated it by accident.

QUESTION: How do we measure this without simply counting "number of active flags"? Because the real damage is the interactions, not the count.
```

### Sara's version (Example Maker)

```
CENTRAL PATTERN: The visual and behavioral inconsistency our users experience comes largely from flags that change UX by segment without coordination.

MECHANISM:
1. Each experiment or rollout introduces a flag that changes visible behavior.
2. Different segments end up with different combinations of behaviors.
3. When a user calls support, support can't reproduce the bug because it's in a combination that isn't documented.
4. When I design a new flow, I can't assume all users see the same thing in the previous flow — I have to design for N variants.
5. I lose control of how the product feels end-to-end.

EXAMPLE:
I designed a new flow for subscriptions last week. The first step of the flow assumed the user saw the "Change plan" button in the header. But there's a "header_v3=off" flag for 12% of users where that button is somewhere else. I had to redesign the first step to cover both variants. Multiplied by all active flags in the product, designing coherently is almost impossible.

QUESTION: Does flag debt apply only to code, or also to the "UX debt" generated by live flags?
```

### Diego's version (Skeptic)

```
CENTRAL PATTERN: Feature flag debt is the maintenance cost we take on by delegating product decisions to runtime conditionals.

MECHANISM:
1. Each flag shifts a decision that could have been in code to a configuration decision.
2. That pays you flexibility (gradual rollout, kill switch, experimentation).
3. But it costs you: each flag is a live surface that must be known and monitored.
4. When flags accumulate without cleanup, the cost exceeds the original benefit.
5. The team ends up spending more time understanding the system than evolving it.

EXAMPLE:
The last pricing incident (NaN in production, Marco described it). But MORE important to me as EM: the last retro showed the team spends ~15% of time "reasoning about flag state before making changes". That is feature flag debt measured in team velocity, not in bugs.

QUESTIONS / SKEPTICISM:
- What is the difference between "feature flag debt" and "accidental complexity in general"? I suspect we're mixing two things.
- Is the solution eliminating flags? Or is it process/ownership/expiration? My intuition is that "fewer flags" doesn't fix it if new flags also accumulate.
- Is it debt or is it the legitimate cost of the control that flags give us? This concerns me because it may be that we're over-romanticizing a world "without flags" that would be worse.
```

## Step 2 — Reveal and comparison

Skill, in the channel:

```
COMPARISON — 4 versions:

CENTRAL PATTERN:
  Lucía: loss of ability to know what the product does.
  Marco: flags as state that accumulates and becomes unreasonable.
  Sara: visual/behavioral inconsistency for users.
  Diego: maintenance cost of delegating decisions to runtime conditionals.

  Agreements:
  - All 4 touch "accumulation / accumulation produces problem".
  - All 4 imply the problem grows over time if there is no cleanup.

  Differences of FOCUS:
  - Lucía: focus on "knowing what the product does" (team's cognitive clarity).
  - Marco: focus on "state and combinations" (code's combinatorial complexity).
  - Sara: focus on "inconsistent experience" (impact on users).
  - Diego: focus on "organizational cost" (% of team time + legitimate tradeoff).

  These are NOT contradictions — they are 4 views of the same elephant.

MECHANISM:
  Lucía: temporal linearity (launch → 100% → not removed → other features assume ON → blockage).
  Marco: combinatorics (2^N) — different axis (combinations, not time).
  Sara: effect on segments (different users experience different versions of the product).
  Diego: explicit tradeoff (flexibility vs maintenance cost).

  These 4 mechanisms are COMPLEMENTARY, not mutually exclusive. The complete package needs all 4 axes
  to avoid being partial.

EXAMPLE:
  Lucía: checkout v2 / v1 dead code.
  Marco: combination flag_pricing + flag_currency → NaN.
  Sara: header_v3 forcing a redesign of the first step.
  Diego: 15% of team time (quote from retro).

  All 4 are real examples from the product itself. Different domains (dead code, combinatorics,
  inconsistent UX, organizational cost). Keeping all 4 in the package enriches the example instead
  of choosing one.

QUESTIONS RAISED:
  - Lucía: is it the same as "dead code"?
  - Marco: how do we measure without simply counting active flags?
  - Sara: does it apply to code or also to the resulting "UX debt"?
  - Diego: difference from accidental complexity? Is the solution fewer flags or better process? Is it debt or legitimate cost?

SKILL'S HYPOTHESES (flagged):
  - The difference from "dead code": dead code is just one manifestation of feature flag debt. Feature flag debt is broader.
  - Metric that focuses on the real damage (Marco): probably something like "flags > X months without cleanup" or "untested flag combinations".
  - Sara and Lucía describe different effects of the same phenomenon. They don't require separate packages.
  - Diego marks the tradeoff well. That must be explicit in the final package.

TURNS:
  Lucía: 1 input.
  Marco: 1.
  Sara: 1.
  Diego: 1.
  Asymmetry: none in silent intake (by construction).
```

## Step 3 — Role-driven build

> Skill: "Mechanism Builder, first of all — Diego raised an important question: is there a difference between feature flag debt and accidental complexity in general? You're closest to the code. What do you think?"

> Marco: "Yes, there's a difference. Accidental complexity is 'the code ended up more complicated than the domain requires'. Feature flag debt is 'the complexity comes specifically from runtime configurability that might not have existed if the path had been committed'. It's a subset."

> Skill: "Sara, does that distinction match what you see in UX?"

> Sara: "Yes — the UX debt in my flows comes from flags, not from general complexity. If we had all committed the path, my designs would have fewer variants."

> Skill: "Concept Owner Lucía, do you agree? We are defining 'feature flag debt' as a subset of accidental complexity, specifically the kind that comes from not having committed runtime decisions."

> Lucía: "Yes. And that answers my question 'is it the same as dead code?' — no, it's broader."

> Skill: "Good. Moving to the mechanism. **Mechanism Builder Marco**: given the 4 views, what is the deep mechanism that unites them?"

> Marco: "The mechanism is: each uncommitted flag is state that (1) occupies code, (2) multiplies combinations, (3) generates UX variants, (4) demands cognitive attention. Accumulation without cleanup raises all 4 costs in parallel."

> Skill: "**Example Maker Sara**, is the best-coverage example a single one or do we need to preserve several?"

> Sara: "I'd keep all 4 examples but labeled by axis. Showing all 4 teaches better than one large example."

> Skill: "Agreed. **Skeptic Diego**, your turn before the formal Skeptic round. To build well we need to define a metric. Marco asked how to measure without just counting active flags. What do you propose?"

> Diego: "I propose two metrics:
> 1. **% of active flags > 90 days** since rollout 100%. This captures accumulation.
> 2. **% of team time spent 'reasoning about flag state'**. This captures the cognitive cost."

> Marco: "+1. The second is hard to measure but it's what matters most."

> Sara: "I'd add a third: **% of support incidents we trace to undocumented flag combinations**. This captures the user cost."

> Skill: "We have 3 metrics. We put them in the package as 'three measurement angles'. **Lucía**, does this serve your roadmap decision?"

> Lucía: "Yes, especially the second. If we see we're at 15%, that justifies prioritizing a cleanup sprint."

## Step 4 — Skeptic round

> Skill: "**Skeptic Diego**: attack the package we're building. Your job is to break the model before we accept it."

> Diego: "OK, 3 attacks:
>
> 1. **When flags are NOT debt**: active kill switches, compliance flags (geo, age verification), flags we actually want to keep alive. If we lump them all into 'debt', we'll clean up what we shouldn't.
>
> 2. **'Cleanup sprint' as the solution is naive**: if the flag creation process doesn't change, we'll regenerate the same debt in 3 months. The root solution is process + ownership + default expiration.
>
> 3. **The % of team time is hard to isolate**: the team also loses time to general complexity, to poorly coupled deps, to slow tests. Attributing all of it to flags is confirmation bias."

> Skill: "Team: respond to each attack."

> Marco (on attack 1): "True. The package has to distinguish 'control flags' (kill switches, compliance, runtime config) from 'delivery flags' (rollout, experimentation). Only the latter generate debt if not removed."

> Lucía (on attack 2): "Diego is right. The solution is not just a sprint — it's defining TTL by flag type and a review ritual. We add it to the package as part of 'how to prevent'."

> Sara (on attack 3): "I take that. My proposal: the 15% metric is indicative but not determinative. Better to use metric 1 (% flags > 90 days) as a leading indicator because it's objective."

> Skill: "Good. The 3 attacks generated refinements. Attack 1 → distinction between control flags vs delivery flags. Attack 2 → the solution is process, not just cleanup. Attack 3 → the % of time metric is indicative; the objective metric is % of flags > 90 days."

> Skill: "Does any of the 3 attacks remain as a declared weakness (without a solid answer)?"

> Diego: "None. All 3 were incorporated."

## Step 5 — Synthesis

```
SHARED PACKAGE — Feature Flag Debt

CONCEPT: Feature flag debt

CENTRAL PATTERN:
Specific subset of accidental complexity that appears when delivery flags (rollout / experimentation) are not removed after serving their purpose, accumulating as state that multiplies combinations, demands cognitive attention, and generates visible inconsistency for the user.
(Provenance: fusion of all 4 versions + agreement that it is a subset of accidental complexity, not equivalent.)

PROBLEM:
Delivery flags are useful for gradual rollout, experimentation, and fast rollback. But if they are not removed post-rollout, they generate 4 parallel costs: (1) dead code in unused branches, (2) combinatorial explosion with neighboring flags, (3) inconsistent UX by segment, (4) cognitive load on the team that must reason about state before any change.
(Provenance: emerged in discussion, all 4 axes contributed by all 4 participants.)

CRITICAL DISTINCTION — flags that ARE debt vs flags that are NOT:
- Generate debt if not cleaned up: delivery flags (rollout, experiments).
- Do NOT generate debt (alive by design): kill switches, compliance flags (geo/age), legitimate runtime config.
The rule: does this flag have a "served its purpose" date? If yes and it wasn't removed, it's debt.
(Provenance: Skeptic attack 1, incorporated.)

MECHANISM (how it accumulates and causes damage):
1. A feature is launched with a delivery flag for gradual rollout.
2. Rollout reaches 100% but the flag is not removed from the code.
3. The old branch remains "alive" in code even though it is functionally unreachable.
4. Other features are built assuming the flag is ON, but the old code keeps compiling.
5. Implicit untested combinations appear (2^N total).
6. The team dedicates a growing % of time to "reasoning about flag state" before changes.
7. Bugs appear in production due to unconsidered combinations; inconsistent UX across segments.
(Provenance: Lucía steps 1-4, Marco step 5, Diego step 6, Sara step 7.)

EXAMPLES (4 axes):
- DEAD CODE (Lucía): checkout v2 at 100% for 6 months; v1 code still compiling inside the else; UX change costs 2h of analysis.
- COMBINATORICS (Marco): flag_pricing_v2=on + flag_legacy_currency=on → NaN in production.
- INCONSISTENT UX (Sara): header_v3=off for 12% forces a redesign of the first step of the new flow.
- ORGANIZATIONAL COST (Diego): ~15% of team time on "reasoning about flag state" (from recent retro).
(Provenance: each contributed their axis; all 4 preserved because they cover different domains.)

WHERE IT DOES NOT APPLY:
- Active kill switches and compliance flags: alive by design, not debt.
- Legitimate runtime config (limits, customer-facing feature toggles).
- Actively running A/B test flags with a defined horizon.
- Accidental complexity not derived from flags (poorly coupled deps, slow tests, etc.) — do not attribute to feature flag debt.
(Provenance: Skeptic attack 1 + Skeptic attack 3.)

METRICS TO MEASURE (3 angles, not 1):
1. **% of active flags > 90 days since rollout 100%**. Objective metric, leading indicator. (Proposed by Diego.)
2. **% of team time reasoning about flag state**. Subjective metric, captures the real cognitive cost. Indicative, not determinative. (Refined in response to Skeptic attack 3.)
3. **% of support incidents traced to undocumented flag combinations**. Captures user cost. (Proposed by Sara.)
(Provenance: built collectively in Step 3.)

HOW TO PREVENT (the solution is NOT just cleanup):
- **TTL by flag type**: delivery → 30 days from rollout 100% → review; experiment → closing date defined from day 1.
- **Explicit ownership**: each flag has an owner responsible for removing it.
- **Review ritual**: once a month, sweep of expired flags.
- **Cleanup sprint**: only if there's already an accumulated backlog; not as a permanent solution.
(Provenance: Skeptic attack 2, incorporated.)

USE:
When discussing whether to prioritize a cleanup sprint, whether to create a new flag for a feature, or whether to review the flag process. Also useful for defending a proposal to "reduce the % of team time on debt" in front of stakeholders.

30-SECOND PITCH:
Feature flag debt is the accumulation of delivery flags that are not removed after serving their purpose. It generates 4 parallel costs: dead code, combinatorial explosion, inconsistent UX by segment, and cognitive load on the team. The solution is not to eliminate flags or run a cleanup sprint — it's process: TTL by flag type, explicit ownership, and a monthly review ritual. We measure it with three angles: % flags > 90 days, % of team time reasoning about flags, and incidents traced to undocumented combinations.

DECLARED WEAKNESSES:
- None from the Skeptic round (all 3 attacks were incorporated).

PENDING DECISIONS (linked to the package):
- Define specific TTL by flag type (delivery / experiment / kill switch / compliance). Owner: Marco. Deadline: next Monday.
- Produce the first report with the 3 metrics for the current state. Owner: Diego. Deadline: 2 weeks.
- Decide in Q3 roadmap whether to run a cleanup sprint + process change or only a process change. Owner: Lucía. Deadline: after Diego's report.
```

## Step 6 — Group validation

Skill (private to each):

> "Without seeing each other or the merged package, write in 30 seconds how you would explain to a new team joiner what 'feature flag debt' is in our product."

### Validations (summarized)

- **Lucía**: contains pattern + mechanism + distinction control vs delivery flags + example (checkout v2) + idea of process as solution ✓
- **Marco**: contains pattern + mechanism (with emphasis on combinatorics) + example (NaN pricing) + metrics (all 3) ✓
- **Sara**: contains pattern + mechanism (with emphasis on UX) + example (header_v3) + idea of process ✓
- **Diego**: contains pattern + legitimate tradeoff + mechanism (accumulation) + distinction flags that are vs are not debt + all 3 metrics ✓

```
COLLABORATIVE VALIDATION:
  Lucía: pattern ✓ / mechanism ✓ / own example ✓ / critical distinction ✓
  Marco: pattern ✓ / mechanism ✓ / own example ✓ / metrics ✓
  Sara: pattern ✓ / mechanism ✓ / own example ✓ / solution ✓
  Diego: pattern ✓ / tradeoff ✓ / mechanism ✓ / distinction ✓ / metrics ✓

Distribution: 4 of 4 → state `aligned`.

Observation: each person emphasized the axis corresponding to their role (Lucía → distinction + clarity example, Marco → combinatorics + metrics, Sara → UX, Diego → tradeoff + metrics). This is NOT a problem — it indicates that each integrated the complete package from their own angle. If they had to replace each other, they could.
```

## Step 7 — Close

```
SESSION STATE:
  Shared package: created.
  Collaborative state: aligned
  State: `aligned` — 4 of 4 with own explanation (not `installed (collective)`; that would require a full mini-rubric per-participant).
  Declared weaknesses: none.
  Pending decisions:
    1. TTL by flag type. Owner: Marco. Deadline: next Monday.
    2. Report of the 3 metrics with current state. Owner: Diego. Deadline: 2 weeks.
    3. Q3 decision: cleanup sprint + process or process only. Owner: Lucía. Deadline: post Diego's report.
  Next step: execute the 3 decisions; short meeting when Diego's report is ready to close the Q3 decision.

TURNS — FINAL DISTRIBUTION:
  Lucía: 4 substantive inputs (~25%).
  Marco: 5 (~28%).
  Sara: 4 (~22%).
  Diego: 5 (~28%).
  Asymmetry: none. Concept Owner did NOT dominate (did not exceed 30%).

Total time: 42 min (estimated 45 min).
```

## Notes on what the Skill did NOT do

- **Did not start with open discussion**. Forced silent intake; without it, Lucía and Marco would likely have dominated (Owner + most senior technical) and Sara/Diego would have gone along.
- **Did not merge the 4 versions prematurely**. It placed them side by side and named the differences in focus before discussing.
- **Did not take sides** among the 4 views. It treated them as complementary views of the same elephant.
- **Forced the Skeptic to attack before closing**. Diego's 3 attacks refined the package (distinction control vs delivery flags; process vs cleanup; objective vs subjective metric). Without that round, the package would have come out fragile.
- **Declared `aligned`, not `installed (collective)`** — the latter would require a full mini-rubric per-participant.
- **Did not let pending decisions get buried**. It left them with concrete owner and deadline.
- **Tracked turns**. If Lucía as Owner had dominated, the Skill would have intervened. It wasn't necessary here.

## Why this case warranted Mode 14 and not 4 individual sessions

If all 4 had done Mode 1 individually, each would have produced a package consistent from their own angle — but the team's group package would not have had all 4 axes integrated, nor the distinction "flags that are debt vs not", nor the 3 metrics, nor the agreement that the solution is process, not cleanup.

Collaborative construction with roles + skeptic round added what no individual would have had on their own.
