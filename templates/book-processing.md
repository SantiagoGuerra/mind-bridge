# Template — Processing books and long manuals

Loaded from Mode 10 when the source is a complete book, an extensive manual, or a series of documents that together form a book (several chained PDFs, a collection of papers from a course, etc.).

## When to load this template

- Source is a complete book or an extensive chapter (>50 pages) with dense internal structure.
- The user wants to install the mental model, not summarize.
- There is a clear risk of treating the roadmap as a book index (phase 1 = chapter 1, etc.).
- The book has parts the user does NOT need to read entirely (surgical reading).

If the source is a short PDF or a blog post, use `templates/learning-roadmap.md` directly without this layer.

## Central principle — Surgical reading

> "The book was written to teach you everything. You don't need everything. We are going to extract the mental model and recommend which fragments to read in the original for depth, precision, examples, or rigor — and which ones can be skipped on a first pass."

This principle is what distinguishes Mode 10 on books from traditional summarization.

## Pre-conditions

Before generating the roadmap:

- **Identify the book's parts** (complete table of contents).
- **Source Completeness Gate**: is the complete book available? Only some chapters? Only TOC + some fragments? If only the TOC is available, declare it and produce a preliminary diagnosis — not a definitive roadmap, but a scoped roadmap (limited to the covered fragment) can be produced. See `templates/source-coverage-gates.md`.
- **TOC Verification Gate** (see the following section).
- **Confirm the user's success criterion.** Without this, it is impossible to decide what is core / secondary / optional.

## TOC Verification Gate (hard rule — anti-hallucination of references)

**Problem this rule prevents**: the model "thinks it knows" famous books (CLRS, K&R, Knuth, Kleppmann, etc.) and generates chapter and section numbers from memory. Those numbers may be from another edition, shifted, or invented. Even if marked "validate against your TOC", they remain too actionable — the user reads them as truth and acts on them.

### Rules by TOC presence

**If the user did NOT paste/load the actual book TOC:**

- **Do not produce definitive chapter or section numbers.** Not even with a "verify" caveat — false numbers are still more actionable than the absence of a number.
- Use **topic-based** references:
  - "[topic candidate — verify with TOC]"
  - "the chapter on [topic]"
  - "candidate location: [part X or topic Y] — verify with TOC"
- If the model uses general knowledge, mark it as explicit **`unverified location`**.
- Ask explicitly: "To map exact sections, paste the TOC (Table of Contents) of the book. Without that, the numbers may be from another edition or invented."
- The conceptual roadmap (phases, packages, transversal patterns, success criterion, reading depth recommendations) **is built** without a TOC — only the numbers are withheld.

**If the user DID paste/load the TOC:**

- Extract the exact **topic → chapter/section mapping from the pasted TOC**.
- Only then produce surgical reading with concrete chapters/sections.
- Maintain `SOURCE COVERAGE` blocks and `Confidence` (the TOC alone is not the whole book — gaps remain).
- Any section not explicitly listed in the pasted TOC goes with `unverified location`.

**For famous books the model "thinks it knows"** (CLRS, SICP, K&R, Knuth, DDIA, Kleppmann, etc.):

- **Do not trust memory.** A book's fame does not authorize numbers from memory.
- Canonical sentence: _"I can build the conceptual roadmap now; exact chapter references require TOC verification. Paste the TOC for [book] and I'll map sections precisely."_
- Exception: if the repo / example includes an explicitly verified source (not "I think I remember"), those numbers — and only those — may be used.

### Required block in the output

When processing a book without a loaded TOC:

```
TOC VERIFICATION:
  TOC pasted by the user: no
  Chapter numbers in this output: none (topic-based references only)
  For exact mapping: paste the book's TOC
```

When processing with a TOC:

```
TOC VERIFICATION:
  TOC pasted by the user: yes — [brief summary]
  Chapter numbers in this output: derived directly from the pasted TOC
  Confidence: high for listed chapters; unverified for subsections not included
```

### Explicit anti-pattern

❌ **Wrong**: "Cap 22.1–22.4 (Graph representation + BFS + DFS) — verify with your TOC."

Even with the caveat, "Cap 22.1–22.4" is actionable and, if incorrect, misdirects the user. Better:

✅ **Right**: "Topic: graph representation + BFS + DFS — *unverified location, paste CLRS TOC for exact chapter/section*."

The second formulation forces the user to paste the TOC before acting.

## Critical distinctions for books

| Distinction | Why it matters |
|---|---|
| **Parts vs chapters** | Dense books usually have "Parts" that group chapters. The roadmap is built on Parts and transversal patterns, not chapter by chapter. |
| **Concepts vs exercises** | Many technical books have entire chapters of exercises. The conceptual roadmap marks them as "optional for Apply/Implement; not for Explain". |
| **Canonical algorithms vs complete algorithms** | A book like CLRS has 100+ algorithms. The roadmap selects the core ones for the mental model; the rest stays as reference. |
| **In-order reading vs surgical reading** | The book proposes a reading order. The roadmap proposes one oriented to the user's success criterion, which sometimes differs from the book's order. |
| **Main text vs appendices** | Appendices are usually reference, not installation. Mark it. |

## Extended roadmap format (on top of `templates/learning-roadmap.md`)

Add the following book-specific fields to the roadmap:

### BOOK MAP block — two versions depending on TOC

**If the user pasted the book's TOC**:

```
BOOK MAP (derived from pasted TOC):
  Edition used: [edition / year — confirmed by TOC]
  Structure: [N parts, M chapters — derived from TOC]
  Book type: [reference / pedagogical / monograph / handbook / mixed]
  Parts and purpose:
    Part I — [name derived from TOC] — [purpose]
    Part II — [name derived from TOC] — [purpose]
    ...
  Appendices: [list derived from TOC]
```

**If the user did NOT paste the TOC** (hard rule — do not invent parts or chapters):

```
BOOK MAP (without loaded TOC — conceptual blocks of the field, not of the book):
  Edition declared by the user: [edition — not verified against TOC]
  Structure of the specific book: unknown — TOC not loaded.
  Book type (inferred from title/domain): [reference / pedagogical / etc.]
  Expected thematic blocks (these are not the book's literal Parts):
    - [Field topic 1] — [purpose]
    - [Field topic 2] — [purpose]
    ...
  ⚠️ These are thematic blocks of the field. Part numbers, chapters,
     and ranges require a TOC to be confirmed. For exact mapping, paste the TOC.
```

**Rule**: never fill in "Part I", "Part II", "Structure: N parts, M chapters", or chapter ranges without a pasted TOC. If the model writes "Part I (chaps 1–4)" without a TOC, it is violating the gate. Full detail: `templates/source-coverage-gates.md` section "TOC Verification Gate".

### SURGICAL READING RECOMMENDATIONS block

```
SURGICAL READING RECOMMENDATIONS:

READ COMPLETELY (core of the mental model):
  - [chapter X, sections Y.1–Y.3] — why: installs the fundamental pattern the rest assumes.
  - ...

READ SELECTIVELY (skip exercises or detailed proofs):
  - [chapter Z] — read sections Z.1, Z.4; skip Z.2 (formal proofs) and Z.3 (exercises) on first pass.
  - ...

USE AS REFERENCE (do not read linearly):
  - [chapter N] — open it only when the specific case applies. Directed consultation.
  - ...

SKIP ON FIRST PASS:
  - [chapter W] — its content is covered sufficiently in package P_W. If you want to go deeper, open it as a branch (Mode 5).
  - ...
```

Each recommendation carries a concrete reason tied to the success criterion.

### TRANSVERSAL PATTERNS block

```
TRANSVERSAL PATTERNS (these are not book chapters):

Some packages group ideas that appear in multiple chapters. We list them here to avoid the "package = chapter" trap:

- [Pattern X] — appears in chapters 3, 7, 11, and 19. The package lives in Phase Y of the roadmap, not in a specific book section.
- ...
```

### DEPTH LEVEL BY PART block

```
RECOMMENDED DEPTH LEVEL BY PART:
  Part I: Apply (fundamental mental model).
  Part II: Apply (core mechanisms).
  Part III: Explain (families, recognize when they apply).
  Part IV: Recognize (reference, open only when applicable).

This gradation changes with the success criterion. If the user wants to Implement, Parts II and III rise to Implement; the rest stays the same.
```

## Anti-trap rules

- **Do not map 1:1 chapter to package**. If Phase 1 has P1 for chapter 1, P2 for chapter 2, etc., the roadmap is mirroring the book. Regroup by patterns.
- **Do not propose reading the entire book in order** unless the user explicitly asks for that.
- **Exercises are optional for Explain**. Mark it. For Apply/Implement, select 2–5 canonical exercises per chapter, not all of them.
- **If the book has formal proofs and the user is not pursuing mathematical rigor**, mark them as skippable.
- **If the book has different editions**, anchor the roadmap to one edition. Note important differences with other editions if known (without inventing — use websearch if in doubt).

## When the book is "too large for a single roadmap"

Some books (CLRS, Knuth TAOCP, manuals hundreds of pages long) require multiple roadmaps:

- **Meta-roadmap**: divides the book into large thematic blocks (3–5 blocks).
- **Sub-roadmaps**: one per block, with its own phases and packages.

The meta-roadmap lives in the main output; sub-roadmaps are generated on demand when the user moves to a specific block.

Example meta-division for a book like CLRS:
- Block 1: Algorithmic foundations (Parts I–II).
- Block 2: Data structures (Part III).
- Block 3: Advanced design (Part IV).
- Block 4: Graphs (Part VI).
- Block 5: Selection of advanced topics (Parts V, VII, VIII).

Each block becomes its own roadmap when addressed.

## Chaining

- Once the book roadmap is generated: install Phase 1 → chain Mode 1 on P1 with its reading fragment.
- If the user wants canonical exercises per package → Mode 5 (expand to Apply).
- To save the book roadmap as a library entry: Mode 9 with confirmation.

## Verification before delivering the book roadmap

- [ ] Does BOOK MAP include parts and the purpose of each?
- [ ] Do the phases group by transversal patterns, not by chapters?
- [ ] Do SURGICAL READING RECOMMENDATIONS distinguish read-completely / selective / reference / skip?
- [ ] Is DEPTH LEVEL BY PART tied to the success criterion?
- [ ] Is it marked which edition was used?
- [ ] Does SOURCE COVERAGE distinguish chapters read vs TOC-only vs appendices?
- [ ] Is only P1 expanded in long form?
- [ ] If the book is "too large", was a block division with meta-roadmap offered?

## References

- Base roadmap: `templates/learning-roadmap.md`.
- External input mode: `modes/ingest.md`.
- Gold-standard example: `examples/clrs-book-roadmap.md`.
