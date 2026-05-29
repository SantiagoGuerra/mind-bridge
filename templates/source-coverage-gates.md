# Template — Source coverage gates (canonical)

Loaded by Mode 10 (`modes/ingest.md`) and any other mode that processes an external source. This file is the **single source of truth** for the four gates: Content Acquisition, Source Completeness, Multimodal Coverage, and TOC Verification. Other files reference this template instead of duplicating rules.

## The four gates in order

When processing an external source (URL, PDF, video, book, paper, repo, doc, transcript), run these gates **in order**. Each must pass before the next applies.

```
1. Content Acquisition Gate  → could the resource be obtained at all?
2. Source Completeness Gate  → is the obtained content complete (or partial / incomplete)?
3. Multimodal Coverage Gate  → is the non-text content covered (slides, code, diagrams, etc.)?
4. TOC Verification Gate     → for books / manuals: is the actual table of contents loaded?
```

The output of all four gates feeds the single canonical block `SOURCE COVERAGE`.

---

## 1. Content Acquisition Gate

**Triggers (stop processing immediately)**:

- Fetch returned **only metadata** (title, og:image, description) — no body.
- Content is **JavaScript-rendered**; static HTML lacks the main text.
- Requires **login / paywall / captcha**.
- Returned **error** (404, 403, 500, timeout).
- **PDF is corrupted, encrypted**, or won't parse.
- **Extraction is unreliable** (fragmented text, lost layout, low-OCR-quality).

**Behavior when triggered**:

1. **Stop.** Do not advance to Source Completeness Gate. Do not build a map, do not package.
2. **Declare the problem explicitly**: what was attempted, what was obtained, why it falls short.
3. **Do not automatically search secondary sources** (websearch, similar articles, related papers).
4. **Do not reconstruct from memory** unless the user approves and the output is labeled as inference.
5. **Offer the 6-option menu** and wait for the user's choice.

**6-option menu** (present numbered):

```
1. Paste content — paste the full text of the article here.
2. Browser PDF — open the article in your browser → Print → Save as PDF → upload.
3. Screenshots / PDF — upload screenshots or PDF if the content is visual.
4. Secondary sources — I can search/process secondary sources, but the result is
   preliminary and labeled "secondary-source preliminary" (Primary Source Boundary applies).
5. Metadata-only preliminary — I can sketch a very preliminary map from metadata only,
   marked as low-confidence.
6. Stop / skip — abandon this resource for now.
```

**Primary Source Boundary** (when user picks option 4):

- Never attribute to the original author details that come from secondary sources.
- Tag the whole output as `secondary-source preliminary`.
- Keep `confidence: low` or `medium` by secondary quality.
- Each package: `not verified against primary source — paste primary content to upgrade`.

**Required output block when this gate triggers**:

```
CONTENT ACQUISITION:
  Resource requested: [URL / file / path]
  Fetch attempt: [what was attempted]
  Result: [metadata-only / JS-rendered / paywall / 404 / etc.]
  Confidence in obtained content: very low / not usable
  Processing: PAUSED — waiting for user decision.
  Options offered: 1–6 (see above)
```

**Exception — user pre-authorized secondary sources**:

If the user's initial prompt already requested "search for similar sources", "compare with other articles", or equivalent, the gate doesn't trigger. The Skill may use secondary sources without pausing, **but must label provenance clearly** (`secondary source`, `not from the primary URL`, `web search result`).

---

## 2. Source Completeness Gate

**Triggers** (after acquisition succeeded, what was acquired is partial):

- PDF only partially read (truncated, page limit hit, large doc processed in chunks).
- Paper: only abstract / introduction loaded.
- Documentation: only some sections included.
- Video transcript: incomplete or with gaps.
- Book: only some chapters or only TOC.

**Behavior when triggered**:

The Skill **can still produce useful output**, but it must distinguish between two roadmap shapes:

| Output shape | When | What it claims |
|---|---|---|
| **Full-source roadmap** | Source acquired complete (this gate passes). | Definitive roadmap of the complete resource. |
| **Scoped roadmap** | Source partial — only some sections / pages / chapters loaded. | Roadmap **of what was loaded**, with declared coverage, exclusions, and confidence per section. Useful but not a substitute for full reading. |

**Rule**: if the source is partial, do **not** produce a full-source roadmap. **Do** produce a scoped roadmap if the user wants one, with the scope, exclusions, and confidence stated up front.

A scoped roadmap is honest. A "definitive roadmap" built from a partial source is misleading.

---

## 3. Multimodal Coverage Gate

**Distinguishes three coverage dimensions**:

- **`text coverage`**: is the spoken/written text complete?
- **`source coverage`** (multimodal): are the slides, notebooks, on-screen code, diagrams, figures, visual outputs present when the original source had them?
- **`artifact coverage`**: are referenced repos, datasets, or related papers available?

**Hard rule**: `text coverage: complete` does **not** imply `source coverage: complete`. For a roadmap to be declared "definitive of the complete resource", both must be complete.

**Common case — video with complete transcript but no slides/notebook**:

- `text coverage: complete`.
- `source coverage: partial — only transcript, no slides/notebook/visuals`.
- Roadmap = "definitive **of the spoken content**", not of the whole video.
- Recommend which visuals/notebook/slides to review for precision on exact code, diagrams, demos.

**Speaker claim labeling inside transcripts**:

- `according to transcript` — reporting what the speaker said without endorsement.
- `speaker claim` — opinions, predictions, controversial assertions.
- `needs verification before publication` — for external / time-sensitive claims (versions, APIs, benchmarks, prices) or anything that will be cited externally.

---

## 4. TOC Verification Gate (books / manuals only)

**Problem prevented**: the model "thinks it knows" famous books (CLRS, K&R, Knuth, Kleppmann, SICP, DDIA, etc.) and emits chapter / section numbers from memory. Those can be from another edition, shifted, or invented.

**Rule when user did NOT load the actual TOC**:

- Do **not** produce definitive chapter/section numbers — not even with a "verify" caveat. False numbers are still more actionable than no numbers.
- Use **topic-based references**: `[topic candidate — verify with TOC]`, `"the chapter on hash tables"`, `"candidate location: [part X or topic Y] — verify with TOC"`.
- If the model uses general knowledge, mark it `unverified location`.
- Ask the user to paste the TOC.
- The conceptual roadmap (phases, packages, surgical reading recommendations, success criterion) **is** buildable without a TOC — only the numbers are withheld.

**Rule when user DID load the TOC**:

- Extract mapping topic → chapter/section directly from the pasted TOC.
- Only then emit concrete numbers.
- Subsections not listed in the pasted TOC → `unverified location`.

**Famous-book exception (none)**: fame doesn't authorize numbers from memory. Canonical sentence:

> "I can build the conceptual roadmap now; exact chapter references require TOC verification. Paste the TOC for [book] and I'll map sections precisely."

**Section-name inference from genre convention**: when the user reports section *numbers* but not *titles* (e.g. "I read §1-4 of 9 sections"), do not assert section names from genre convention (`§6 = Related Work`, `§7 = Future Work`, etc.) as if they were facts about this source. Hedge: `"typical convention for OSDI papers / manuals / textbooks — confirm with your copy"`. Same rule applies to inferring chapter titles in books and segment titles in talks/videos.

**Hedge-per-mention rule (MF-1)**: if the roadmap mentions the same unverified section/chapter/segment more than once, the hedge must repeat on every substantive mention, not only the first. A hedge at the start + multiple un-hedged mentions in the body reads as assertion and the reader internalizes the number/title as fact. Applies equally to: paper sections, book chapters, talk/video segments, manual/doc sections. Short hedge form for repeated mentions: `(§N — convention, unconfirmed)` or `(chapter X — no TOC)` or `(segment Y — no verified timestamp)`. If the user pastes the actual TOC / section, the hedge is lifted for that specific reference.

**Anti-pattern**:

❌ `"Cap 22.1–22.4 (Graph algorithms) — verify with your TOC."` — the number leads action even with caveat.

✅ `"Topic: graph algorithms (BFS/DFS) — unverified location, paste TOC for exact chapter/section."`

---

## Canonical `SOURCE COVERAGE` block

Every roadmap, package map, or analysis output for an external source includes this block. Fields below are the **canonical** definition — other templates reference this block:

```
SOURCE COVERAGE:
  primary source acquired:    yes / no / partial
                              (if "no" or "partial" → Content Acquisition Gate fired)
  source origin:              primary / secondary / metadata-only / mixed
                              (if "secondary" or "metadata-only" → Primary Source Boundary applies)
  text coverage:              complete / partial / incomplete
  source coverage:            complete / partial / incomplete
                              (multimodal: slides, notebook, on-screen code, diagrams)
  artifact coverage:          complete / partial / not applicable
                              (referenced repos, datasets, related papers)
  confidence:                 high / medium / low
  Sections / elements covered:     [list]
  Sections / elements not covered: [list]
  Parts at parsing risk:           [images, tables, OCR, etc. — empty if N/A]

  Can a definitive roadmap of the complete resource be produced?:  yes / no
  Can a scoped roadmap (limited to covered content) be produced?:  yes / no
    If scoped: declare scope, explicit exclusions, and per-section confidence.

  TOC pasted by the user (books / manuals):  yes / no / N/A
    If not: no chapter / section / page number references.
```

---

## Decision tree

```
Did the source get acquired?
├── No  → Content Acquisition Gate fires; stop and offer 6 options.
└── Yes → Is what was acquired complete?
         ├── No  → Source Completeness Gate fires; do NOT produce full-source roadmap.
         │         Offer scoped roadmap (with declared scope) or wait for more material.
         └── Yes → Is the non-text content (slides, code, diagrams) covered?
                  ├── No  → Multimodal Coverage Gate fires; calify roadmap as
                  │         "definitive of [spoken/textual] content"; mark visual gaps.
                  └── Yes → For books only: TOC Verification Gate.
                           ├── No TOC → no chapter numbers, topic-based only.
                           └── TOC pasted → extract mapping, emit numbers.
```

---

## Reference table by source type

| Source type | Gates that commonly fire | Notes |
|---|---|---|
| PDF (small, parses) | Source Completeness (if processed in chunks) | Multimodal if figures matter. |
| PDF (large) | Source Completeness; sometimes Multimodal | Chunks → scoped roadmap if partial. |
| Paper | Source Completeness (abstract-only is a common trap) | Figures often need Multimodal. |
| Blog / URL | **Content Acquisition** (JS-rendered, paywall) | Then Completeness. |
| Video | **Multimodal Coverage** (transcript ≠ source) | Plus Completeness if transcript partial. |
| Book / manual | **TOC Verification** | Plus Completeness if only some chapters. |
| Repo / codebase | Source Completeness (partial clone, large repo not fully read) | See `modes/repo-ingest.md` discovery rules. |
| Transcript pasted | Multimodal (no visuals) | text coverage often complete; source coverage partial. |

---

## Cross-references

- Detailed behavior on Content Acquisition Gate failures: this file, section 1.
- Decision tree for what to do after gates: this file, "Decision tree".
- How the gates plug into Mode 10's flow: `modes/ingest.md`.
- How book processing layers on top of these gates: `templates/book-processing.md` (the TOC Verification Gate's deeper book-specific rules live there).
- How roadmaps consume the `SOURCE COVERAGE` block: `templates/learning-roadmap.md`.
