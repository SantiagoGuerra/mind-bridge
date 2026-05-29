# Mode 9 — Package library

Activation: "save to library", "list packages", "search library", "update package X" — ES: "guarda en biblioteca", "listar paquetes", "buscar en biblioteca", "actualiza el paquete X".

## Recommended location

`~/Documents/mind-bridge-library/`

This location is suggested but **not created automatically**. The user must confirm the location or propose another before any write operation. If the user prefers a different path (e.g. inside a Git repo, inside an Obsidian vault), respect it and store it in session memory.

## Golden rule

**Never write, modify, or delete files in the library without explicit confirmation from the user in the same session.**

Before any write operation, show:

- Which file will be created / modified / deleted.
- What content (complete diff, not a summary).
- Ask for literal confirmation: "Shall I proceed?"

Only proceed if the user says yes in that same session.

## v1: minimum viable scope

In v1, the flow is manual-assisted. There are no automated list/search/connect commands. The Skill helps the user to:

1. **Create** a new package file (with confirmation).
2. **Update** an existing package (with confirmation).
3. **Propose links** between packages (suggestion, not automatic writing until the user approves the diff).

Automated commands (`/library list`, `/library search`, `/library refine`, `/library connect`) and the Obsidian integration → v2.

## Create a new package

If the user wants to save a freshly packaged concept:

1. Load `templates/library-entry.md`.
2. Propose a filename in kebab-case (`fencing-tokens.md`).
3. Show the full proposed content (frontmatter + body).
4. Confirm location: "I'm going to create `~/Documents/mind-bridge-library/fencing-tokens.md`. Shall I proceed?"
5. If the user confirms, write the file.
6. If the directory doesn't exist, ask for additional confirmation before creating it.

## File frontmatter

**Canonical schema**: see `templates/library-entry.md`. This mode **does not define its own schema** — it only applies the canonical one. If this section and `templates/library-entry.md` conflict, `templates/library-entry.md` wins.

Field summary (full definitions and allowed values in the canonical template):

- `title`, `domain`, `tags`, `related`, `source`, `created`, `updated`.
- `status`: see canonical state machine in `templates/library-entry.md`.
- `target_level` and `validated_level`: canonical ASCII values (`recognize | explain | apply | implement | teach`; `validated_level` also accepts `pending`).
- `confidence`: `low | medium | high`.

Never use the legacy `level` field (it collapsed objetivo and validado). Never use Spanish values in frontmatter (values are ASCII English; human display can be translated).

## Naming convention

- kebab-case.
- Descriptive concept name, not a date (dates go in frontmatter).
- If there are homonyms, add context: `fencing-tokens-distributed.md`.

## Zettelkasten-style links

When the user wants to connect two packages:

- Propose adding the other file's name to the `related` field in the frontmatter of both.
- Show the diff before writing.
- Confirm both changes.
- Do not open more than two links simultaneously without asking for confirmation again.

## Mode exit

- If saved: confirm the path, suggest additional tags if they fit, suggest the next related package to connect.
- If not saved: leave the package ready in the conversation for the user to decide later.
