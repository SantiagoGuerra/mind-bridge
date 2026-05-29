# Mode 5 — Expand resolution

Activation: "I need to implement this", "take it up a level", "open this branch", "go deeper on X" — ES: "necesito implementar esto", "súbele un nivel", "abre esta rama", "profundizar en X".

## Resolution levels

1. Recognize
2. Explain
3. Apply
4. Implement
5. Teach / debate

## Calibration

Apply global calibration from SKILL.md. Specific to expanding:

Before opening branches, ask **why we are expanding** if it is not clear from context:

- **curiosity** → Fast modifier (defaults). Brief expansion, no double-check.
- **apply** → Product modifier. Ask for the case context. Expansion oriented toward real applications.
- **implement** → Implementation modifier. Ask for technical constraints. Activate double-check if there are technical claims. Expansion with concrete artifacts.
- **meeting** → Communication modifier. Ask for audience. Expansion only of what will be communicated.
- **technical decision** → Product + Implementation modifiers. Activate double-check. Expansion with explicit trade-offs and risks.

The reason changes which branches are opened and to what depth.

## Negotiated decision

Claude recommends, the user decides. Format:

> "To move from [current level] to [target level], you need to open these branches: A, B, C.
> I recommend opening A first because [reason]. B and C we leave compressed until you need them."

The user approves what to open.

**Inference-with-acknowledgment** (shortcut when the prompt already implicitly authorizes): if the user's prompt explicitly names the scope (e.g. "expand only what is needed to implement", "don't go into theory", "only failure modes") and that resolves which branches to open vs. compress, the mode can skip the approval pause **as long as it states the inference out loud** before expanding:

> "I read your prompt as authorization to open A, B(light), C, D and keep E, F, G compressed. Correct me if not — if you don't answer, I'll continue."

This avoids unnecessary ceremony when the user was already clear, without losing the transparency contract.

## Branch tree

When the topic is fractal, show an explicit tree:

```
Root concept
├── Branch A: [topic] — [state: open / compressed / pending / not needed]
├── Branch B: [topic] — [state]
└── Branch C: [topic] — [state]
```

States:

- **open**: we already worked on it.
- **compressed**: it exists, we are not opening it today.
- **pending**: we will open it soon.
- **not needed**: discarded for this goal.

Keep the tree visible while the mode is running. Update it when a branch changes state.

## How to expand by level

**To Apply**: give 1–2 new cases where the user has to apply the concept. Validate result with Mode 4.

**To Implement**: pseudocode, real code, flow diagrams, or concrete steps depending on the domain. Mark trade-offs and dependencies. If the domain is not code, give the operational equivalent (process, template, checklist).

**To Teach**: force counter-examples, neighboring concepts, defense against objections, connections with other patterns. Do active sparring.

## Depth limit

If an expansion will require a lot of external context (paper, weeks of practice, unavailable tools):

> "This requires [resource/time]. Should we continue with an overview or stop here and pick it up later?"

Do not open branches the user cannot close in the session.

## Mode output

After expanding:

- Chain Mode 4 (validate at the new level).
- Update the package (Mode 2): raise `TAUGHT LEVEL` to the new level; keep `VALIDATED LEVEL` at `pending` until Mode 4 confirms.
- If branches remain pending, leave them noted as "NEXT BRANCH" in the package.
