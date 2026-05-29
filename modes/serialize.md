# Mode 3 — Serialize

Activation: "help me serialize this", "give me a 30-second explanation", "explain it for [audience]", "version for [context]" — ES: "ayúdame a serializar", "dame una explicación de 30 segundos", "explícalo para [audiencia]", "versión para [contexto]".

## Calibration

Apply global calibration from SKILL.md. Specific to serializing:

- **Audience is blocking**: if it is not clear, ask before generating. Do not serialize for a "generic audience".
- **Format** (oral / Slack / doc / meeting) can be inferred from context or asked.
- **Length** is inferred from the trigger ("30 seconds", "3 minutes") or asked.
- **Message goal** (explain / convince / sell / align): ask if not clear — it changes the emphasis.

Communication modifier active by default. If the user wants to "serialize for CEO with focus on decision", also activate the Product modifier.

## Template (matrix of audiences, lengths, and rules)

Load `templates/serialization-formats.md`. That is where the canonical audiences live (developer / senior engineer / junior dev / PM / CEO / client / non-technical stakeholder / meeting / technical doc / Slack), the lengths (10s / 30s / 3 min / doc / executive pitch), and the matrix by audience. This mode only decides *which version to generate*; the "how" lives in the template.

## If the concept is not well packaged

Say:

> "There's gold here, but the package still needs refining before it can be serialized well."

Then:

- Ask 2–3 key questions (mechanism, example, limit), or
- Take the user to Mode 7 (decompress) if the intuition is very raw, or
- Take them to Mode 2 (package) if they have the pieces scattered.

## Variants

By default, offer **one single** proposed version. If the user asks for options, give 2–3 labeled variants (more technical / more narrative / shorter).

## Verification before delivering

- Does the version preserve the central pattern?
- Is it appropriate to the audience's vocabulary?
- Does it fit within the requested length?
- Does the 30-second version contain pattern + mechanism + example (not just a definition)?
- **Did I invent absolute numbers?** If the user gave ratios or percentages (`>80% vs <20%`, `4x`, `3 out of 10`) but did NOT give absolute totals (`412 users`, `89 crossed the threshold`, `$50k MRR`), **do not invent the absolutes**. If an illustrative absolute number clarifies the serialization, prefix it with `illustrative — replace with your real data before sending`. Applies especially to executive pitch / CEO where a single number does half the work.

## Mode output

Offer another audience or length. If the user wants to save the version in the package → chain Mode 2 to update the 30-SECOND PITCH field.

## Reference

`examples/fencing-tokens.md` and `examples/invisible-product-debt.md` include serialization examples for various audiences.
