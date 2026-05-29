# Mode 11 — Skill meta-review

Activation: "review how I'm using the Skill", "methodology status", "which modes do I use most", "Skill review" — ES: "revisa cómo estoy usando el Skill", "estado de la metodología", "qué modos uso más", "review del Skill".

## Philosophy

This mode evaluates the methodology, not the specific learning. It serves to:

- Detect modes that are underused and should be used more.
- Detect modes that aren't working well.
- Detect missing canonical examples.
- Suggest refinements to the Skill.
- Audit the package inventory by state (includes collaborative and in-progress packages, not only `installed`).

In v1, this mode is **manual and declarative**: the user reports what has happened, Claude structures and suggests.

## Guided questions (those that apply, not all)

1. Which modes have you used in the last 2 weeks?
2. Which mode has given you the most real value?
3. Which one hasn't worked for you or you don't use?
4. What concepts have you learned with the Skill?
5. Have you noticed any blocking or friction in a specific mode?
6. Is there a type of problem or question the Skill doesn't cover yet?
7. Does the gold/refinery metaphor still help, or is it wearing out?
8. Does the Skill's own vocabulary come naturally, or does it feel forced?

## Inventory by state (mandatory in the report)

Packages are bucketed across **all** canonical states. Never collapse `aligned` into `installed`, and never skip collaborative packages. Canonical ASCII values; prose can be in the user's language.

**Individual trajectory** (from `templates/concept-package.md`):
`raw → packaged → ready-for-validation → partially-installed → installed → validated → applicable / teachable`

**Collaborative trajectory** (from `templates/collaboration-modes.md` and `templates/validation.md`):
`raw → packaged → aligned → shared explanation confirmed → installed (collective)`

**Decay**: any state → `stale` (no recent use, outdated source, or superseded by another package).

### States to enumerate (do not omit any)

| State | Trajectory | Typical action if stuck here |
|---|---|---|
| `raw` | individual / collaborative | Mode 2 to package. |
| `packaged` | individual / collaborative | Mode 1 (teach) or Mode 13/14 if collaborative. |
| `ready-for-validation` | individual | Mode 4 to validate. |
| `partially-installed` | individual | Mode 4 on the dimensions missing from the mini-rubric. |
| `installed` | individual | Mode 4 at `target_level` to promote to `validated`. |
| `validated` | individual | Find a real case → `applicable`; teach someone → `teachable`. |
| `applicable` | individual | Consider `teachable` or close the cycle. |
| `teachable` | individual | Closed unless decay. |
| `aligned` | collaborative | Mode 4 per-participant to move to `shared explanation confirmed` or `installed (collective)`. **Never rename to `installed`**. |
| `shared explanation confirmed` | collaborative | Full mini-rubric per-participant → `installed (collective)`. |
| `installed (collective)` | collaborative | Closed unless decay. Requires full mini-rubric per participant. |
| `stale` | decay | Re-validate source or archive. |

## Stale detection

Mark as **stale candidate** (even if `status` doesn't say so yet):

- Explicit `status: stale` in frontmatter, OR
- `updated` > 90 days with no signal of recent use (doesn't appear in notes, wasn't used in session, wasn't cited), OR
- Source superseded by a newer version the user has already consumed.

List them in their own section with a suggested action (re-validate source, archive, or promote).

## Meta-review report

```
METHODOLOGY STATUS — [date]

What's working:
- [specific observation with example]

What isn't:
- [specific observation with example]

Underused modes:
- [mode X]: possible cause, proposed adjustment

Package inventory by state:
[One section or row per state present in the library. DO NOT omit
 aligned, shared explanation confirmed, or installed (collective).]

  ## raw (N)
    - [title] | target_level: X | validated_level: pending | updated: YYYY-MM-DD | confidence: low/med/high
      → next action: [e.g. "Mode 2 to package"]

  ## ready-for-validation (N)
    - ...

  ## aligned (N)  ← collaborative, NOT installed
    - [title] (collective) | target_level | validated_level | updated | confidence
      → next action: "Mode 4 per-participant to move to installed (collective)"

  ## installed (collective) (N)
    - ...

  [... one bucket per canonical state present ...]

Stale packages or stale candidates:
- [title] | updated: YYYY-MM-DD | reason: [no use 90+ days / source superseded / status=stale]
  → action: [re-validate source / archive / promote]

Distribution by trajectory:
- Individual: N packages in {raw, packaged, ..., teachable}
- Collaborative: N packages in {aligned, shared explanation confirmed, installed (collective)}
- Stale / candidates: N

Proposed Skill adjustments:
- [concrete proposal, affected file]
```

Per package, always show: **title, status (with `(collective)` marker if applicable), target_level, validated_level, updated, confidence, one-line next action**.

## Critical rule

If the user approves Skill adjustments → mark them but **do not edit the Skill in the same session** without explicit confirmation and step-by-step review. Skill iteration happens in a dedicated session, not as a meta-review follow-up.

## Canonical references

- `templates/concept-package.md` — individual state machine and anti-false-mastery rules.
- `templates/library-entry.md` — canonical frontmatter schema (status, target_level, validated_level, updated, confidence).
- `templates/collaboration-modes.md` — collaborative states (`aligned`, `shared explanation confirmed`, `installed (collective)`) and why they don't collapse to `installed`.

## Recommended cadence

Every 2–4 weeks or whenever the user requests it.

## Mode exit

- Full report with inventory by state (all canonical buckets present).
- List of stale / stale candidates.
- List of proposed adjustments (not applied).
- Recommendation for when to iterate the Skill (if it's coming up soon, suggest opening a dedicated session).
