# Mode 8 — Glossary / anchor words

Activation: "I can't find the word for this", "what is the name of", "word to describe when X", "technical term for" — ES: "no encuentro la palabra para esto", "cuál es el nombre de", "palabra para describir cuando X", "término técnico para".

## Calibration

Apply global calibration from SKILL.md. Specific to glossary:

If the concept's domain is not clear, ask:

- technical (systems, engineering, infra)
- product / UX
- psychology / behavior
- business / strategy
- communication
- other

The domain changes what literature to search and what terms would be nearby. Do not search blindly. If the domain is current and technical and there is doubt about the term, activate Evidence Policy (websearch) — see SKILL.md.

## Expected output

When the user describes a pattern without a name:

- **5–10 candidates** ordered by proximity.
- In **Spanish and English**.
- With **field/domain** in parentheses.
- With **usage nuance**.
- With a short **example sentence**.

## Format

```
1. **[term]** (es/en) — [domain] — [nuance]
   Ex: "[example sentence]"

2. **[term]** ...
```

Close with:

- **Closest word**: [candidate]
- **Useful anchor word to search further**: [different candidate if applicable]

## Distinctions

- **Exact word**: the standard term that covers the pattern without loss.
- **Close word**: covers 80%, there are nuances.
- **Anchor word**: not the term, but it opens the search in the literature.
- **Provisional name**: when no known standard term exists, propose a descriptive working name.

Mark explicitly which category each candidate belongs to.

## No standard name

If after searching there is no recognized standard term:

> "I don't know a standard term for this. Let's call it [provisional name] for now. If the real one appears, we'll switch."

If the concept's domain suggests a term should exist (social psychology, distributed systems, behavioral economics) but you don't remember it with certainty, offer to use web search.

## Labeling external references

Each proposed term that comes from literature, authors, or external frameworks (not from the conversation with the user) carries a label per `PHILOSOPHY.md` ("External reference labeling"):

- If it is a verified standard word: mark `[standard technical term]`.
- If it is an unverified candidate: `possible anchor` and, if going to publication, `verify before publication`.
- If it is a cited author/work: `possible literary anchor — verify before publication` unless the user has loaded the source.

This protects against confidently asserted mistaken attributions, especially because the anchor words from this mode often travel to docs and meetings.

## Persistence

In v1, the glossary is conversational. If the user wants to save terms → chain Mode 9 with confirmation. The ANCHOR WORDS field in the package (Mode 2) is the natural place.

## Mode output

- If we found the exact word: close with that.
- If we only found a close word: use it with a disclaimer and chain Mode 7 (decompress further) or Mode 2 (package with provisional name).
- If there is no viable candidate: propose a provisional name and chain Mode 2.
