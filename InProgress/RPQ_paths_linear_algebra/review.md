# Conference Management Toolkit — View Reviews

> Source: CMT, ADBIS 2026, printed 6/11/26, 4:32 PM (https://cmt3.research.microsoft.com/ADBIS2026/Submission/Reviews/27)
>
> Legend: ~~struck through~~ = fixed in the source (see the note under the item).
> Items without strikethrough need work by the authors; "Partially" marks items where only the mechanical part was done.
> Fixed items can be checked in the sources listed in the notes; author notes in the PDF are the teal `GB:` boxes.

**Paper ID:** 27
**Paper Title:** Semiring-Based Linear Algebra Framework for Two-Way Regular Path Queries
**Track Name:** Research Papers

---

## Reviewer #2

### Questions

#### 1. Brief summary (1 paragraph) of problem addressed and contributions of the paper.

The paper generalizes the authors' prior LARPQ algorithm, a linear-algebra method that evaluates 2-RPQs by traversing the graph and the query automaton together through Boolean matrix products, lifting it from the Boolean case to arbitrary semirings. Changing the algebra lets one algorithm solve several path problems: Boolean for reachability, and a "path semiring" (whose values are sets of vertex sequences) plus filtering operators for all-simple-paths, all-trails, and all-shortest-paths. It is implemented on SuiteSparse: GraphBLAS within LAGraph, with a workaround for GraphBLAS's requirement that values have a fixed size, and compared against MillenniumDB and FalkorDB on Wikidata, YAGO-2S, and RPQBench.

#### 2. Overall Recommendation

Weak Reject

#### 3. Strong Points (at least 3)

- **S1.** The idea of recasting LARPQ over an arbitrary semiring so that reachability, simple paths, trails, and shortest paths all come from one algorithm is elegant.
- **S2.** The implementation is open-source.
- **S3.** RPQ evaluation in the linear-algebra setting is a challenging and underexplored area.

#### 4. Weak Points (at least 3)

- **W1.** The performance claim is not well supported, and the presentation would benefit from improvement (D1, D2).
- **W2.** The evaluation has gaps that make even the split result hard to interpret (D3, D4, D5).
- **W3.** The novelty over the authors' prior work and classical semiring theory should be clarified (D6, D7, D8).

#### 5. Overall evaluation

- **D1.** ~~The abstract claims "significant performance improvements," but the tables show LARPQ is slower on the typical query everywhere; it wins on totals only because a few hard queries dominate the sum.~~
  - *Fixed:* abstract (`RPQ_paths_LA.tex`) and the third contribution bullet (`Introduction.tex`) now say the approach is competitive, slower on the typical simple query, and substantially faster on hard queries, which yields lower total and mean times. This matches the Conclusion and the tables. Wording to be checked by the authors.
- **D2.** ~~The generalized algorithm is called "Algorithm 2" in the text but appears as "Fig. 2," and there is no "Algorithm 1," which is confusing.~~ ~~The meaning of Table 3 should be provided in the main text and not just footnotes,~~ ~~and the Fig. 4 subplots are small with hard-to-read shared axes.~~ Tightening the figure/table labeling and captions would improve readability.
  - *Fixed:* the algorithm is now an `algorithm` float, numbered *Algorithm 1*, and referenced as such (`LA_RPQ_Paths_theory.tex`).
  - *Fixed:* the three result tables are merged into one full-width Table 1 without footnotes; the YAGO-2S caveats (2 of 7 queries, FalkorDB timeouts, why mean/median are omitted) are now stated in the Evaluation text and in the caption (`Evaluation.tex`).
  - *Fixed:* after the move to the two-column EDBT template, the four Wikidata violin plots span the full page width (each panel is about 40% larger than in the LNCS version); the caption now explains points, median and mean lines.
  - Captions were tightened where touched; a general pass over all captions is left to the authors.
- **D3.** The YAGO-2S results are drawn from only running 2 of 7 queries on all systems, and FalkorDB timed out on every one (Table 3), so the simple-paths and trails results on this dataset are too thin to support a conclusion.
  - *Needs authors.* The text now states explicitly that the simple/trails observation rests on two queries only, but deciding whether to drop these numbers, add queries, or raise the timeout is an experimental decision.
- **D4.** Correctness is asserted, not shown, for the new cases. The proof (Sect. 4.4) is deferred entirely to the prior Boolean-reachability paper [6]. The new content (the path semiring and the simple/trail/shortest filters) should be proved explicitly.
  - *Update 2026-09-17:* Appendix A (`Appendix_proofs.tex`) now drafts the proofs: a step lemma, an extension lemma, Theorem A.3 (simple paths and trails, with termination bounds) and Theorem A.4 (shortest paths). Theorem A.4 holds only with a pair-level operator plus a final minimum-length selection, not with the vertex-level operator of Sect. 3.4; a GB note in the appendix states the required changes to Sects. 2.4, 3.4 and Algorithm 1. Sect. 4.4 points to the appendix.
  - *Needs authors (proof).* Partially: the algorithm statement was made consistent with the path-semiring instantiation so that a proof can be written against it: (a) the initial frontier value is now an explicit parameter (`1` for Boolean, `{(v_s)}` for the path semiring); (b) the loop body was reordered to accumulate, multiply, filter. In the original order `I_Simple` would have filtered the initial frontier `{(v_s)}` (appending `v_s` to a path already containing it) and the algorithm would stop immediately. For the Boolean case the new order is exactly the original LARPQ. A `GB:` note in Sect. 4.1 flags this for verification against the implementation.
- **D5.** The parameter tuning would benefit from better explanation. In particular, L_fast=8 and C_fast=1 are "empirically chosen" and said to need per-dataset adjustment, yet no sensitivity analysis is provided. Also, FalkorDB is measured only on trails, which makes the comparison uneven.
  - *Needs authors.* Sensitivity analysis is new experimental work. The FalkorDB restriction is already explained in "Competitors" (only all-trails is expressible); the authors may want to say so again in the results discussion.
- **D6.** Generalizing Boolean matrix path computations to arbitrary semirings is a long-standing idea, so the novelty is better stated as the specific combination of the path semiring with the filtering operators inside the LARPQ skeleton.
  - *Needs authors.* Wording of the contribution statement in the Introduction.
- **D7.** The delta over the authors' own LARPQ paper [6] should be made explicit.
  - *Needs authors.* Sect. 4.1 lists the differences to the original algorithm; an explicit delta paragraph (Introduction and/or Preliminaries, see also Reviewer #4) is still to be written.
- **D8.** Minor: ~~I^P_Simple appears in Sect. 4.3 alongside I_Simple without the difference being defined;~~ ~~reference [6] lacks venue/year;~~ ~~and the abstract scopes the work to "single-source" 2-RPQs while the paper also defines single-destination variants that are never evaluated.~~
  - *Fixed:* `I^P_Simple` was a typo for `I^P_Shortest`; the bullet now describes the shortest-paths operator (`LA_RPQ_Paths_theory.tex`).
  - *Fixed:* reference [6] is now the VLDB 2025 Workshops (LSGDA) paper with year, venue and URL (`RPQ_paths_LA.bib`, key `belyanin2150single`).
  - *Fixed:* Sect. 2.4 keeps the single-destination definitions and adds the reduction to single-source queries by reversing the query (reverse words, invert labels, transpose the automaton decomposition, swap start/final states). A `GB:` note asks the authors to decide whether to keep or drop the SD definitions.

#### 6. Reviewer's Confidence

Expert Confidence

#### 9. Required revisions?

No

#### 10. Specific issues to be addressed in a revision.

A short-paper focused on the novelty with respect to the previous work and with preliminary experimental results better scoped and explained would maybe be a more suitable format for the paper.

- *Decision for the authors.* The paper is being moved to the EDBT 2027 template (12-page long paper); the current build is 8 pages, so there is room for the proofs and the delta discussion.

---

## Reviewer #3

### Questions

#### 1. Brief summary (1 paragraph) of problem addressed and contributions of the paper.

The paper presents a semiring-based generalization of the Linear Algebraic Regular Path Querying (LARPQ) algorithm for evaluating two-way regular path queries (2-RPQs), i.e., regular path queries that allow traversing graph edges in both the forward and reverse directions. The original LARPQ algorithm operates over the Boolean semiring and solves a reachability problem: given a source vertex, it determines which vertices can be reached through paths whose labels satisfy the query. The main idea of the paper is to replace the Boolean semiring with a path-valued semiring, allowing matrix entries to store paths rather than simple reachability information. To support different path semantics, such as simple paths, trails, and shortest-path variants, the authors introduce index unary operators that filter path during the fixpoint computation.

#### 2. Overall Recommendation

Weak Reject

#### 3. Strong Points (at least 3)

- The paper presents an elegant and unified framework for evaluating regular path queries using a semiring-based linear algebra formulation.
- The introduction of index unary operators, which enrich the framework by enabling the enforcement of different path semantics, such as simple paths and trails, within the same computational setting.
- The method has been implemented and evaluated experimentally. The results indicate that the approach is competitive with state-of-the-art graph database systems on several workloads, particularly for more complex query patterns.

#### 4. Weak Points (at least 3)

- The presentation makes the overall method difficult to follow and likely challenging to reproduce without significant prior expertise
  - *Needs authors.*
- Figure 3 and the associated text is not fully clear. The readers have to reconstruct the execution semantics themselves.
  - *Partially.* The text around the figure (now Fig. 2) was extended: it names the frontier contents before the step, explains the per-label products, states that the figure shows paths after the target vertex is appended (i.e. after `I_Simple`), and describes the summation into the new frontier. A full per-iteration walkthrough is left to the authors.
- Given the combination of semiring-based algebra and path-enumeration capabilities, I expected a discussion or extension toward more expressive query languages beyond regular path queries, for example context-free path queries
  - *Needs authors.* Only a one-line mention of CRPQs exists in the Conclusion.

#### 5. Overall evaluation

My main concern is the readability of the paper. The framework combines several advanced concepts, including semiring-based linear algebra, 2-NFA synchronization, and matrix-based fixpoint computation. The paper is VERY hard to read without expertise in the subjects.

- *Needs authors.*

#### 6. Reviewer's Confidence

Moderate Confidence

#### 9. Required revisions?

Yes

#### 10. Specific issues to be addressed in a revision.

- A motivating example early in the paper would significantly improve accessibility and intuition.
  - *Needs authors.*
- I understand that the figure provides an illustrative overview of the algorithm execution, but it is not sufficiently supported by a step-by-step explanation in the text. The interaction between matrix multiplication, path accumulation, and index-based filtering is difficult to reconstruct from the figure alone.
  - *Partially* (see Weak Points above).
- ~~Concerning Fig 3: it is stated that the path \pi_b is filtered out due to repeated vertices, but the same issue appears to arise in \pi_a.~~ A more detailed step-by-step explanation of the example, including explicit path states at each iteration, would help clarify the whole mechanism.
  - *Fixed:* the reviewer was right to be confused: the text was wrong. `π_b` is `((v_1, v_4), (v_4, v_1))` and is filtered because it returns to `v_1`; the text said `((v_1, v_2), (v_2, v_1))` with "repeated vertex v_2", and the matrix cell in the diagram read `{(v_1, v_2, v_1)}`. Text (`LA_RPQ_Paths_theory.tex`) and diagram cell (`Diagram.tex`) now read `(v_1, v_4, v_1)`; `π_a = ((v_1, v_2), (v_2, v_3))` is stated to be simple and kept. The matrix column header in the diagram was corrected to `(N^{⟨·⟩})^T`, and the stray `a` in the figure caption was removed. Explicit per-iteration path states: left to authors.

---

## Reviewer #4

### Questions

#### 1. Brief summary (1 paragraph) of problem addressed and contributions of the paper.

The article presents a semiring-based generalization of the linear algebra approach for evaluating two-way regular path queries (RPQ). The proposed algorithm is an extension of a previous BFS-based algorithm (LARPQ) presented by the authors at VLDB 2025; it replaces the Boolean semiring with other algebraic structures. The proposed solution is evaluates on three semantics (all-simple-paths, all-shortest-paths, and all-trails). The performance of the proposed semiring-based LARPQ algorithm is compared against state-of-the-art graph database management systems: MillenniumDB (RPQ challenge version) and FalkorDB.

#### 2. Overall Recommendation

Accept

#### 3. Strong Points (at least 3)

- The article is well written and pedagogically articulated.
- The Figure illustrating an example of the algorithm step for the all simple paths semantics.
- The discussion of the limitations of the proposed and existing solutions in terms of performance.

#### 4. Weak Points (at least 3)

- In Section 2 (Preliminaries), the authors should clearly highlight the differences with their VLDB 2025 article.
  - *Needs authors* (same as Reviewer #2, D7).
- ~~The related work section should be strengthened. The authors should specifically cite the following recent papers in the related work and position their contribution relative to them:~~
  - ~~Park, S., Kim, S., & Kim, M. S. (2026). cuRPQ: A High-Performance GPU-Based Framework for Processing Regular and Conjunctive Regular Path Queries. Proceedings of the ACM on Management of Data, 4(3 (SIGMOD), 1-28.~~
  - ~~Abo Khamis, M., Hurjui, A. M., Kara, A., Olteanu, D., & Suciu, D. (2026). Acyclic Conjunctive Regular Path Queries are no Harder than Corresponding Conjunctive Queries. Proceedings of the ACM on Management of Data, 4(2 (PODS), 1-24.~~
  - ~~Ma, M., Wang, H., Wang, X., You, Y., & Ge, J. (2025). LD-RPQB: a benchmark for regular path queries based on length distribution. World Wide Web, 28(5), 52.~~
  - *Fixed:* bib entries `park2026curpq` (doi 10.1145/3802033), `abokhamis2026acyclic` (doi 10.1145/3801891), `ma2025ldrpqb` (doi 10.1007/s11280-025-01365-9) added to `RPQ_paths_LA.bib`, metadata taken from the DOI registry; a positioning paragraph was added at the end of `Related_work.tex` (GPU traversal vs. library-based sparse LA; CRPQ theory vs. practical single-source path semantics; LD-RPQB as a complement to RPQBench). Please review the positioning sentences.

#### 5. Overall evaluation

Other details to correct:

- ~~The DOI address is repeated twice in several references.~~
  - *Fixed:* `url`/`eprint` fields that merely repeated the DOI were removed from all bib entries (the bst printed both). Verified in the built bibliography: no reference prints a DOI twice.
- ~~The year is missing in reference 6.~~
  - *Fixed:* see D8 above.

#### 6. Reviewer's Confidence

Moderate Confidence

#### 9. Required revisions?

Yes

#### 10. Specific issues to be addressed in a revision.

See Weak Points

---

## Additional defects found while addressing the reviews (all fixed)

- Fig. 3 (now Fig. 2): matrix cell `{(v_1, v_2, v_1)}` should be `{(v_1, v_4, v_1)}`; column title should be the transposed automaton matrix.
- Algorithm: initial frontier `1` undefined for the path semiring; loop order made the path-semiring instantiation terminate immediately (details under D4).
- Sect. 2.4 defined "simple path", "trail" and path length a second time (already Definitions 2.3/2.4); duplicate removed.
- Sect. 4.3: result described as "a Boolean vector" although it holds path sets; corrected.
- Sect. 3.4: `I_Simple`, `I_Trail`, `I^P_Shortest` were introduced as operators "for matrices over B"; corrected to matrices over D_Paths.

## Template migration (EDBT 2027)

- `RPQ_paths_LA.tex` now uses `acmart` (`sigconf,review`) with the EDBT A4 geometry and `edbt-macros.tex`; `llncs.cls`/`splncs04.bst` removed; `acmart.cls`, `ACM-Reference-Format.bst`, `edbt-macros.tex` added.
- Wide material (Fig. 1, Fig. 2, Table 1, Fig. 3) uses `figure*`/`table*`; long displays were re-broken for the column width.
- Build: `latexmk -lualatex -outdir=build RPQ_paths_LA.tex`; current length 8 pages (limit for long papers: 12).
