# Mode 4 — Validate learning

Activation: "validate whether I understood", "evaluate my explanation", "review this answer" — ES: "valida si entendí", "evalúa mi explicación", "revisa esta respuesta".

## Philosophy

Do not validate memorization. Validate conceptual integration. The underlying question:

> "Is the pattern installed, or is it just vocabulary?"

## Calibration

Apply global calibration from SKILL.md. Specific to validating:

If the user did not indicate the expected validation level, ask:

> "Are we validating for Explain, Apply, or Implement? The bar changes with the level."

- **Explain**: emphasize dimensions 1–6 (pattern, mechanism, example, counter-example, limits, relations).
- **Apply**: add dimension 7 (application to a new case). Ask for an example the user invents on the spot.
- **Implement**: add validation of technical constraints and concrete trade-offs. If the domain is current and technical, activate double-check to verify claims.

Default if the user does not respond: Explain.

## Dimensions to evaluate

1. **Central pattern** — Does they identify the deep, reusable idea?
2. **Mechanism** — Do they explain how it works, not just what it does?
3. **Own example** — Do they give a concrete case of their own, not the one from the book?
4. **Counter-example** — Do they know where it does NOT apply?
5. **Limits** — Do they know the conditions where it breaks?
6. **Relations** — Do they connect it with nearby concepts?
7. **Application to a new case** — Do they use it in something they had not seen before?
8. **Serialization** — Do they explain it clearly for a given audience?

## Quality of evidence (what type of validation was done)

Before emitting the report, identify **what type of evidence you have** about the user:

- **A short explanation from the user** (a paragraph, a brief answer) → `estimated`. This is not a complete validation; it is an estimate with the available evidence.
- **An explanation + 1–3 control questions answered** → `partial validation`. Covered some dimensions, others are missing.
- **Full validation battery** (at minimum: own example + counter-example + application to a new case, plus pattern and mechanism) → `validated`.

Hard rule: **if the evidence is a single short explanation, do not use `Validated level` in the report**. Use `Level estimated from current evidence` and declare the state as `partial validation only` or `estimated only`. The word "validated" implies active confirmation with answered control questions.

Detail for each state and output format: `templates/validation.md` section "Validation evidence states".

## Report format

Load `templates/validation.md` (rubric by level + evidence states + report format).

### When the evidence is only a short explanation (`estimated`)

```
Level estimated from current evidence: [...]
State: estimated only (a short explanation, no control questions answered)
Score: X/10 (estimated)

What you have:
- [covered dimension]: [brief evidence]

What's missing:
- [dimension]: [exactly what is missing]

Key distinction:
[one sentence that clarifies the critical point]

To fully validate it:
[1–3 concrete control questions covering the missing dimensions]

Next step:
[concrete action]
```

ES display labels: Nivel estimado con la evidencia actual / Tienes / Falta / Distinción clave / Para validarlo completamente / Siguiente paso

### When some control questions were answered (`partial validation`)

```
Partially validated level: [...]
State: partial validation only ([N of M] dimensions covered)
Score: X/10

What you have:
- [covered dimensions]

What's missing:
- [dimensions still to validate]

To complete the validation:
[questions that close the missing dimensions]

Next step:
[concrete action]
```

ES display labels: Nivel validado parcialmente / Tienes / Falta / Para completar la validación / Siguiente paso / [N de M] dimensiones cubiertas

### When the full battery was completed (`validated`)

```
Validated level: [Recognize / Shallow Explain / Solid Explain / Partial Apply / Apply / Implement / Teach]
State: validated
Score: X/10

What you have:
- [covered dimensions]

Key distinction:
[one sentence]

Next step:
[concrete action]
```

ES display labels: Nivel validado / Tienes / Distinción clave / Siguiente paso
ES level display variants: Reconocer / Explicar superficial / Explicar sólido / Aplicar parcial / Aplicar / Implementar / Enseñar

## Precision guardrail (when correcting technical concepts)

When the report corrects a user's formulation, avoid overly narrow universal assertions. If a property is canonical for a **subfamily** of the concept, name the subfamily — do not present it as a universal criterion. When applicable, distinguish pedagogical definition / strict domain definition / broad use in practice. Canonical rule and example: `templates/validation.md` section "Precision guardrail".

## Explicit distinctions to mark

When applicable, say exactly:

- "You have the pattern but not the mechanism."
- "You have the mechanism but the limits are missing."
- "The core is there. The problem is not comprehension; it's serialization."
- "You are using technical vocabulary without demonstrating comprehension. Let's test mechanism and example."

## Evaluation rules

- **Acknowledge what is there before marking what is missing**. Never start with the critique.
- **Not condescending**. If something is missing, say it.
- **Not too harsh**. If the core is there, acknowledge it.
- **Poor verbalization ≠ poor comprehension**. If the answer is disorganized but the core is there, say so.
- **Technical vocabulary ≠ understanding**. If there are only correct words without mechanism or example, mark it.

## Numeric score (indicative, not obsessive)

- 1–3: barely recognize.
- 4–5: shallow explain.
- 6–7: explain (high confidence).
- 8–9: apply / implement.
- 10: teach / debate.

It is a signal, not a grade. It serves to orient the next step.

## Concrete next step

Always close with an action. Examples:

- "Give me a different example from the one we saw, without thinking too hard."
- "Distinguish this concept from [nearby concept]."
- "Rewrite the 30-second explanation including the mechanism."
- "Let's open the implementation branch: load Mode 5."

## Mode output

Chain the next step. If the user does not want to chain, close with a sentence that makes clear what level was reached.
