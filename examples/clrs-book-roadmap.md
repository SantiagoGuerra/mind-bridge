# Canonical example — Surgical roadmap for CLRS (Introduction to Algorithms)

> **Use this as behavioral reference, not required output length.** This example is intentionally long to demonstrate the TOC Verification Gate end-to-end, all 6 phases, and the P1 expansion. In normal use, the Skill should produce **compact roadmaps** (3–5 phases, core packages only) unless the user explicitly asks for the full version. Compress normal outputs accordingly.

**TL;DR**: A backend engineer wants to use CLRS (a ~1300-page book) to reason about complexity and choose data structures — not to prepare for interviews or do formal proofs. The user **did not paste the book's TOC**, so this example demonstrates the **TOC Verification Gate**: a complete conceptual roadmap with 6 phases and 14 packages (P1–P14) grouped by **cross-cutting patterns**, surgical reading recommendations, but **no concrete chapter numbers** — only topic-based references with the caveat `unverified location, paste TOC for exact chapter`. Only P1 is expanded in long form; the rest are compressed. If you only read one thing from this example, look at: (1) the `TOC VERIFICATION` block, (2) how the "SURGICAL READING RECOMMENDATIONS" use topic-based references instead of numbers, and (3) the final note "Why this roadmap gives NO chapter numbers".

> **Important note about this example (v0.3.5)**: an earlier version included specific chapter and section numbers (e.g. "Ch 22.1–22.4 for Graphs") drawn from model memory. Those numbers may come from a different edition, be offset, or be fabricated. Even though they carried the caveat "validate against your TOC", they were still too actionable. The example was redone to demonstrate the TOC Verification Gate correctly: without the user's TOC, there are no numbers — only topic-based references. Details in `templates/book-processing.md` section "TOC Verification Gate".

Gold-standard example of Mode 10 + `templates/book-processing.md`.

## Input

> "I want to learn algorithms using CLRS (4th edition). My goal: to reason well about complexity and choose data structures in real code. I'm not preparing for interviews and I don't want to do all the exercises. I work as a backend engineer."

## Identified working mode

- **Product modifier (real application)**: the goal is to reason in real code, not pure mathematical rigor.
- **Target level**: Apply (not Implement from scratch or Teach).
- **Double-check not needed**: CLRS is a stable canonical source; no websearch required.

## Intake (summarized)

Blockers already covered by the prompt:
- goal: apply.
- level: apply.
- context: backend engineering, real code.
- success criterion: reason about complexity + choose data structures.
- output: roadmap (decided by magnitude — dense book).

Recommended questions the Skill asks:
> "Three quick questions: (1) What language do you use day to day? — that shapes the examples. (2) How much do you already know? (basic O notation / recurrence analysis / nothing formal yet). (3) **Can you paste the book's TOC?** If not, I'll build the conceptual roadmap without chapter numbers — those require the TOC to avoid making things up."

User:
> "Go in production, Python for scripts. Basic O notation yes, recurrences no. I don't have the TOC handy right now — can you do it without?"

Skill:
> "Yes. I'll build the conceptual roadmap with all phases, packages, and surgical reading recommendations. References will be topic-based (e.g. 'the chapter on hash tables') rather than numbers. When you have the TOC, I can map each package to its exact section in a second pass."

## Source Completeness Gate + TOC Verification Gate

> **Note v0.4**: this block migrated from the legacy `State:`-only shape to the canonical 8-field schema (`SOURCE COVERAGE` multimodal: text / source / artifact coverage). See `templates/source-coverage-gates.md` section 2.

```
SOURCE COVERAGE:
  primary source acquired:  no — only TOC reference + general field knowledge
  source origin:            none uploaded; topic/field-level reasoning
  text coverage:            partial (TOC + general field knowledge only)
  source coverage:          partial (no chapter bodies loaded)
  artifact coverage:        not applicable (book has no companion code/notebooks the user loaded)
  confidence:               medium for conceptual structure / low for exact CLRS 4e localization
  Sections / elements covered:     conceptual structure of the field
  Sections / elements not covered: chapter bodies, exact CLRS 4e page/chapter numbers
  Can a definitive roadmap of the full resource be produced?:  no
  Can a scoped roadmap (bounded to what was covered) be produced?: yes (conceptual roadmap of the field, not of CLRS specifically)
  TOC pasted by the user:   no

TOC VERIFICATION:
  TOC pasted by the user: no.
  Chapter/section numbers in this output: none — topic-based references only.
  For exact mapping: paste the CLRS 4e TOC and I'll do a second pass with numbers.
```

## Roadmap

```
LEARNING ROADMAP — CLRS (4th edition)

SOURCE:
  Type: technical book (reference + pedagogical).
  Topic: classical algorithms and analysis.
  User's purpose: reason about complexity + choose data structures in real code.
  Target level: apply.
  User context: backend engineer (Go + Python).

SUCCESS CRITERION:
  By the end of this roadmap you should be able to:
  - Estimate the time and space complexity of a piece of your own code (O notation + why).
  - Choose between array, linked list, hash map, balanced tree, heap for a concrete case and justify.
  - Recognize classical algorithms when they appear in code (BFS, DFS, Dijkstra, DP) and know when to use them.
  - Distinguish when a problem is "easy" vs "intractable" (P/NP) without needing to prove it.

MAGNITUDE DIAGNOSIS:
  Magnitude: very high.
  Reason: 35+ chapters, ~1300 pages, deep dependencies between concepts.
  Risk if packaged too early: the foundation (asymptotic analysis) that everything else assumes gets lost.

CONTENT THESIS:
  Algorithms are tools for solving computational problems with limited resources (time,
  space); asymptotic analysis is the language for talking about their cost,
  and data structures are the decisions that move the needle most in real code.

BOOK MAP (no TOC loaded — conceptual structure of the field, not of the specific book):
  Expected thematic blocks (these are NOT the book's Part numbers):
    - Foundations: notation, recurrences, divide-and-conquer.
    - Sorting and order statistics (canonical D&C laboratory).
    - Everyday data structures (lists, hash tables, BSTs, balanced trees, heaps).
    - Advanced design techniques (DP, greedy, amortized analysis).
    - Advanced structures (B-trees, Fibonacci heaps, disjoint sets) — reference.
    - Graphs (representation, BFS/DFS, shortest paths, MST, max flow).
    - Advanced topics (multithreading, linear programming, FFT) — reference.
    - NP-completeness, approximation, parallelism, online — mental model.

  ⚠️ These are thematic blocks of the field, not the literal structure of
     CLRS 4e's Parts. Part numbers and chapter ranges require the TOC to confirm.

SURGICAL READING RECOMMENDATIONS (topic-based — verify with TOC):

READ FULL (core of the mental model):
  - Insertion sort + step-by-step analysis — installs the cycle "describe algorithm → count
    operations → derive cost". [topic candidate — verify with TOC]
  - Asymptotic notation (O, Ω, Θ) — unavoidable vocabulary. [topic candidate — verify with TOC]
  - Divide-and-conquer + recurrences + master method — you'll use this a thousand times to reason.
    [topic candidate — verify with TOC]
  - Hash tables — the data structure you use most; understand how and why it fails.
    [topic candidate — verify with TOC]
  - Graph representation + BFS + DFS — the two graph algorithms that always appear.
    [topic candidate — verify with TOC]

READ SELECTIVELY (skip formal proofs on first pass):
  - Heapsort + heap structure + basic operations; skip the priority queue API on first
    pass (come back when applicable). [topic candidate — verify with TOC]
  - Quicksort: read the mechanism; skip the formal randomized analysis.
    [topic candidate — verify with TOC]
  - Lists / stacks / queues: quick review if you already know them; skip language-specific
    implementations. [topic candidate — verify with TOC]
  - BSTs: read structure + basic operations; skip expected height.
    [topic candidate — verify with TOC]
  - Red-Black trees: read only the balancing intuition; skip the proofs.
    Knowing "what guarantees they give you" is enough — you don't need to implement one. [topic candidate — verify with TOC]
  - Dynamic programming: read intuition + 2 canonical examples (rod cutting, LCS);
    skip proofs. [topic candidate — verify with TOC]
  - Greedy: read the greedy criterion + conceptual Huffman; skip optimality proofs.
    [topic candidate — verify with TOC]
  - MST (conceptual Kruskal and Prim) + single-source shortest path (Dijkstra): read the mechanism;
    skip detailed proofs. [topic candidate — verify with TOC]
  - NP-completeness: read intuition + reductions; skip formal proofs.
    [topic candidate — verify with TOC]

USE AS REFERENCE (do not read linearly):
  - Advanced structures (B-trees, Fibonacci heaps, disjoint sets): open only when your
    work calls for it. [topic candidate — verify with TOC]
  - String matching: read only if you work with text search.
    [topic candidate — verify with TOC]
  - Computational geometry: read only if your domain needs it.
    [topic candidate — verify with TOC]
  - Approximation: open when you face an NP problem that needs a practical solution.
    [topic candidate — verify with TOC]

SKIP ON FIRST PASS:
  - Probabilistic analysis (separate chapter on randomness): not blocking for your goal.
    [topic candidate — verify with TOC]
  - Linear-time sorting (counting/radix sort): skippable unless you encounter
    counting/radix sort at work. [topic candidate — verify with TOC]
  - Medians / order statistics: skippable for Apply. [topic candidate — verify with TOC]
  - Amortized analysis: conceptually useful but formal; come back when you need to understand
    "it's O(1) amortized". [topic candidate — verify with TOC]
  - Augmented data structures: skippable. [topic candidate — verify with TOC]
  - Multithreading, online algorithms, linear programming, FFT: skippable for your goal.
    [topic candidate — verify with TOC]
  - Mathematical appendices: use on demand, do not read in order. [topic candidate — verify with TOC]

CROSS-CUTTING PATTERNS (not chapters):
  - Asymptotic analysis: appears in every chapter; the package lives in Phase 1.
  - Divide-and-conquer: appears in sorting + graphs + others; package in Phase 2.
  - Greedy choice property: appears in greedy + MST + Dijkstra; package in Phase 4.
  - Space/time trade-off: cuts across all structures; package in Phase 3.
  - Lower bounds and reductions: sorting limit chapters + NP; optional package in Phase 6.

RECOMMENDED DEPTH LEVEL BY BLOCK:
  Foundations: Apply (asymptotic notation + recurrences).
  Sorting: Explain (know when to pick which sort).
  Everyday structures: Apply (the ones you use day to day).
  Design techniques: Apply for DP; Explain for greedy and amortized.
  Advanced structures: Recognize (you know they exist).
  Graphs: Apply BFS/DFS/Dijkstra; Explain the rest.
  Advanced topics (parallelism, LP, FFT): Recognize.
  NP / approximation: Explain (P/NP mental model).

ROADMAP METHODOLOGY:
  1. This roadmap is not a summary of CLRS. It is a sequence of conceptual installation.
  2. Do not open all phases at once.
  3. Each package is installed with: pattern → problem → mechanism → example → limits → relations → validation.
  4. Complete Phase 1 first. The rest remain compressed.
  5. Reading the original book is surgical: only the recommended fragments.
  6. For each package, make your own example (not the book's). If Go: mentally implement in Go. If Python: same.
  7. Validate each phase before advancing. If validation fails, do not advance.
  8. If you encounter an algorithm in real code you don't understand, open it as an on-demand package.
  9. Each package should close with a decision or trade-off applicable to backend work.
  10. **When you paste the TOC**, I'll map each package to its exact chapter/section. Until then, references are topic-based.

PHASES:

PHASE 1 — Algorithmic thinking
  Goal: install the language. Know what an algorithm costs and how we measure it.
  Why this phase goes here: without asymptotic notation + recurrences, everything else floats.
  What must be installed by the end: reason from a piece of your own code to its asymptotic cost.
  Packages:
  P1. Asymptotic notation and algorithm analysis
     - central pattern: measure cost independent of hardware via asymptotic growth.
     - why it goes here: prerequisite for everything else.
     - recommended level: apply.
     - reading: chapters on insertion-sort-with-analysis + asymptotic notation.
       [topic candidates — verify with TOC]
     - open now: yes.
  P2. Recurrences and the master method
     - central pattern: recursive algorithms produce recurrences; the master method solves them.
     - why it goes here: impossible to analyze D&C, mergesort, quicksort without this.
     - recommended level: apply.
     - reading: chapter on divide-and-conquer + master method; skip the formal proof.
       [topic candidate — verify with TOC]
     - open now: no.
  Phase validation:
    - Take a loop from your Go code and derive its time complexity in O(...) and explain why.
    - Apply the master method to T(n) = 2T(n/2) + O(n). What's the result and why?
    - What is the operational difference between O(n log n) and O(n²) for n = 10⁶?
  Next action:
    Decision: when you receive a PR, can you give an informed opinion about its asymptotic cost
    without benchmarking? If yes, advance to Phase 2.

PHASE 2 — Sorting and divide-and-conquer
  Goal: install the D&C pattern and understand the landscape of sorting algorithms.
  Why this phase goes here: sorts are the canonical laboratory; D&C appears in graphs, search.
  What must be installed by the end: know why O(n log n) is the comparison-based limit, and choose
  between mergesort / quicksort / heapsort by context.
  Packages:
  P3. Divide-and-conquer as a pattern
     - central pattern: divide, solve recursively, combine.
     - reading: quick review of the D&C chapter + intro to quicksort as D&C.
       [topic candidates — verify with TOC]
     - open now: no.
  P4. Mergesort, Quicksort, Heapsort: when to pick each
     - central pattern: comparison sorts share the asymptotic limit; they differ in constants,
       stability, and memory.
     - reading: chapters on heapsort + quicksort + mergesort review. [topic candidates — verify with TOC]
     - open now: no.
  Phase validation:
    - When would you choose mergesort over quicksort? Give a concrete production reason.
    - What does the Ω(n log n) lower bound guarantee for comparison sorts? Without proving it.
  Next action:
    Trade-off: in Go, sort.Slice uses a hybrid; why? When would a pure quicksort betray you?

PHASE 3 — Everyday data structures
  Goal: install the structures that appear in any backend service.
  Why this phase goes here: what moves the needle most in real code are structures.
  What must be installed by the end: choose between array, hash map, BST/balanced tree, heap.
  Packages:
  P5. Hash tables: how and why they fail
     - central pattern: O(1) average, O(n) worst case; the hash function defines everything.
     - reading: chapter on hash tables — full. [topic candidate — verify with TOC]
     - open now: no.
  P6. Balanced trees: when BST vs hash
     - central pattern: trees give order + log(n) search; hash gives O(1) without order.
     - reading: chapter on BSTs (structure + basic operations); chapter on Red-Black trees (intuition without proofs).
       [topic candidates — verify with TOC]
     - open now: no.
  P7. Heaps and priority queues
     - central pattern: insert and extract-min in O(log n); supports priority-based jobs.
     - reading: chapter on heaps + priority queue API. [topic candidates — verify with TOC]
     - open now: no.
  Phase validation:
    - In an LRU cache, what structure would you use for O(1) get/put and why?
    - You want top-K by continuous score: heap or sorted array? Why?
    - Range query "users with age between X and Y": hash or balanced tree?
  Next action:
    Decision: pick 3 structures from one of your services and justify each choice.

PHASE 4 — Applicable design techniques
  Goal: install two patterns that appear in problems that aren't "purely algorithmic".
  Why this phase goes here: DP and greedy are reusable patterns in product optimizations.
  What must be installed by the end: recognize when a problem is attacked with DP vs greedy.
  Packages:
  P8. Dynamic programming (DP)
     - central pattern: well-defined recurrence over reusable / overlapping subproblems.
       For optimization problems, also requires optimal substructure (precision guardrail —
       see templates/validation.md). DP also appears in counting, decision, probability.
     - reading: intuition + 2 canonical examples (rod cutting, LCS).
       [topic candidates — verify with TOC]
     - open now: no.
  P9. Greedy and its limits
     - central pattern: make the best local decision at each step; works only when there is
       a greedy choice property.
     - reading: chapter on greedy (criterion + conceptual Huffman); skip proofs.
       [topic candidates — verify with TOC]
     - open now: no.
  Phase validation:
    - Give an example of a problem where DP works and greedy fails.
    - For coin change, does greedy work with coins {1,5,10,25}? With arbitrary coins?
  Next action:
    Trade-off: when would you accept a greedy solution even if it's not globally optimal?

PHASE 5 — Essential graphs
  Goal: install the graph mental model and the algorithms that appear in production.
  Why this phase goes here: graphs model relationships; BFS/DFS/Dijkstra always appear in backend.
  What must be installed by the end: represent a graph, mentally execute BFS/DFS,
  and choose the right algorithm for shortest path given the edge types.
  Packages:
  P10. Graph representation + BFS + DFS
     - central pattern: any structured exploration is some variant of "queue or stack
       + visited set".
     - reading: chapter on elementary graph algorithms. [topic candidate — verify with TOC]
     - open now: no.
  P11. Shortest path: Dijkstra and when it doesn't apply
     - central pattern: edge relaxation with priority by minimum known distance.
     - reading: chapter on single-source shortest paths + Dijkstra intuition.
       [topic candidate — verify with TOC]
     - open now: no.
  P12. MST: Kruskal and Prim
     - central pattern: greedy over edges / vertices producing a minimum-cost spanning tree.
     - reading: chapter on minimum spanning trees, conceptual.
       [topic candidate — verify with TOC]
     - open now: no.
  Phase validation:
    - Model one of your real systems as a graph. What are the nodes and edges?
    - Why doesn't Dijkstra work with negative edges?
  Next action:
    Decision: identify a real case where modeling as a graph gave you an advantage over your current approach.

PHASE 6 — P, NP and the boundary of tractability (optional for Apply)
  Goal: know how to say "this is probably intractable" and respond well when it is.
  Why this phase goes here: protects you from burning time on NP-complete problems.
  What must be installed by the end: recognize NP-hard + know what to do (approximation, heuristics).
  Packages:
  P13. P vs NP: intuition and consequences
     - central pattern: there are problems with no known efficient solution; recognizing them saves time.
     - reading: chapters on NP-completeness, intuition + reductions; skip formal proofs.
       [topic candidates — verify with TOC]
     - open now: no.
  P14. Approximation and heuristics
     - central pattern: when the optimum is intractable, we accept a "good" solution with a guarantee.
     - reading: chapter on approximation, intuition; rest as reference.
       [topic candidate — verify with TOC]
     - open now: no.
  Phase validation:
    - Give an example of an NP-hard problem you might encounter in backend (assignment, scheduling).
    - What would you do when you hit one? — at least 3 strategies.
  Next action:
    Roadmap close. Keep recent real cases nearby to avoid staying in theory.

RECOMMENDED ORDER:
  P1 → P2 → P3 → P4 → P5 → P6 → P7 → P8 → P9 → P10 → P11 → P12 → P13 → P14

CORE PACKAGES: P1, P2, P5, P6, P7, P8, P10, P11.
SECONDARY PACKAGES: P3, P4, P9, P12.
OPTIONAL PACKAGES: P13, P14.
```

## First package to install now (P1 expanded)

```
P1. CONCEPT: Asymptotic notation and algorithm analysis

CENTRAL PATTERN:
The cost of an algorithm is measured in how it grows with input size, not in absolute
seconds. Asymptotic notation (O, Ω, Θ) captures that growth by ignoring constants
and lower-order terms.

PROBLEM:
Without a shared language for talking about cost, discussions about "which algorithm is
better" collapse into hardware benchmarks or intuition. You can't reason a priori whether a
change will scale; you can only measure after implementing. For large n, the constants
that benchmarks do measure are irrelevant compared to the dominant growth term.

MECHANISM:
1. Identify the dominant operation of the algorithm (the one repeated most).
2. Count how many times it executes as a function of input size n.
3. Drop multiplicative constants (they depend on hardware).
4. Drop lower-order terms (for large n, higher-order terms dominate).
5. What remains is the asymptotic complexity.
   - O(f(n)): upper bound. "Grows at most as fast as f(n)."
   - Ω(f(n)): lower bound. "Grows at least as fast as f(n)."
   - Θ(f(n)): tight bound. "Grows exactly as fast as f(n)."

EXAMPLE:
```go
func hasDuplicate(xs []int) bool {
    for i := 0; i < len(xs); i++ {
        for j := i + 1; j < len(xs); j++ {
            if xs[i] == xs[j] {
                return true
            }
        }
    }
    return false
}
```
- Dominant operation: the comparison `xs[i] == xs[j]`.
- Number of times: n(n-1)/2 = (n² - n)/2.
- Drop constant (1/2) and lower-order term (-n/2): n².
- Time complexity: O(n²).
- For n = 10⁶: 10¹² operations. Infeasible.
- Alternative with hash map: O(n). For n = 10⁶: 10⁶ operations. Trivial.

COUNTER-EXAMPLE:
Asymptotic notation is NOT the best tool when:
- Input size is bounded by a small constant (n ≤ 100 always). Here constants dominate
  and a well-optimized O(n²) can beat an O(n log n) with large constants.
- The bottleneck is not CPU but I/O, network, or cache memory.
- You're doing hardware-specific benchmarks — there you measure, not derive.
- Amortized analysis matters: some structures have O(n) worst case but O(1) amortized.

RELATIONS:
- P2 (Recurrences): asymptotic analysis gets complicated when the algorithm is recursive.
- Amortized analysis: when the per-operation worst-case cost is misleading.
- Profiling: asymptotic analysis tells you what will scale; profiling tells you what hurts today.
- Data structures (Phase 3): the choice of structure determines the complexity of the
  most-used operations.

USE:
When reviewing a PR and you want an informed opinion before accepting. When designing an
endpoint that will grow 10x. When estimating whether a migration will finish in hours or days.

30-SECOND PITCH:
Asymptotic notation measures how the cost of an algorithm grows with input size,
ignoring constants and hardware. You count the dominant operation, discard what doesn't
scale, and you're left with a label like O(n²) or O(n log n). It gives you a language to
reason a priori about whether a change will scale — before measuring it. It doesn't replace
profiling when constants, I/O, or cache matter, but it saves you from implementing something
you already know won't scale.

SOURCE:
- From the source: formal definition of O, Ω, Θ and the insertion sort exercise come from CLRS
  (chapter on asymptotic notation + chapter on insertion sort —
  topic candidates, verify with TOC).
- Translation: the Go example is from the user (not from the book); CLRS uses neutral pseudocode.
- Inference: the connection to profiling is not central in CLRS but is practical for your context.

TARGET LEVEL: apply
TAUGHT LEVEL: apply
VALIDATED LEVEL: pending
STATE: ready-for-validation

RECOMMENDED READING IN THE ORIGINAL BOOK:
- Full insertion sort chapter (topic candidate — verify with TOC): introduces the cycle
  "describe algorithm → analyze cost".
- Full asymptotic notation chapter (topic candidate — verify with TOC): formally defines O, Ω, Θ.
  Read the first sections carefully; you can skim the less common notations.
- Summations appendix (topic candidate — verify with TOC): consult if you encounter a
  summation you don't know how to bound.

> To map these references to exact chapter/section numbers, paste the CLRS 4th edition TOC.
```

## How to continue from here

```
1. Install P1 with the recommended readings (topic-based). Complete Phase 1 Validation
   before advancing.
2. Paste the CLRS 4e TOC so that each package (P1–P14) can be mapped to its exact chapter/section.
   I'll do a second pass with concrete numbers.
3. If you already have solid asymptotic notation, validate with the 3 questions and skip to P2.
4. If your work puts you in front of a graph case (Phase 5) or a structure choice
   (Phase 3), open that phase before the sequence.
```

## Why this roadmap gives NO chapter numbers

This example demonstrates the **TOC Verification Gate** (see `templates/book-processing.md`).

The model "believes it knows" CLRS — it is one of the most-cited books in the field. But the 1st, 2nd, 3rd, and 4th editions have different structures; chapters have moved between editions and sections have been added. If the model generates "Ch 22.1–22.4 for BFS/DFS" from memory, the user:

1. Reads it as truth.
2. Opens the book at Ch 22.
3. Finds something else (for example, *Single-Source Shortest Paths* in CLRS 4e — Elementary Graph Algorithms comes before it).
4. Wastes time or, worse, reads the wrong chapter and believes they learned something they didn't.

Even if the output includes "validate against your TOC", the damage is measured at the moment the user acts before validating. The correct defense is **not emitting numbers from memory** — only emit them when a TOC is loaded.

The conceptual roadmap (phases, packages, success criterion, depth recommendations, validations) **is buildable without a TOC** because it lives in the field, not in a specific edition. That conceptual roadmap is what the user gets on the first pass. The second pass — with the TOC pasted — maps each package to its exact section.

## What this example does NOT do (intentional)

- **Does not give chapter or section numbers** from the specific book. Topic-based references only.
- **Does not assume the model correctly remembers the CLRS 4e structure**. The book's fame does not authorize attributions from memory.
- **Does not produce a "book index"**. Phases are grouped by field patterns, not by chapter order.
- **Does not hide the gate** — the `TOC VERIFICATION` block appears prominently in the output, not buried.
