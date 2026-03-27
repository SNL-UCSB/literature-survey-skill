# Writing Craft Extraction: The Six-Move Formula and Section Analysis

This reference guides the craft extraction step during Pass 3+ in deepen mode. When a student reads a paper they admire, they should analyze HOW the authors made their argument effective — building a personal corpus of writing craft lessons.

Source: Arpit Gupta's paper-writing editorial framework, derived from analysis of TurboTest (NSDI), CAF (SIGCOMM+ANRP), Demystifying (NeurIPS), NetForge, BQT+, and NetBurst.

## Introduction: The Six-Move Formula

Every effective systems/networking introduction follows this sequence. For each paper, identify which moves are present, how effective they are, and what you'd adopt.

### Move 1: Stakes
**Function:** Establish why the domain matters.
**What to look for:** Does the opening name specific actors (users, ISPs, policymakers) or specific applications (video, gaming, cloud)? Or does it open vaguely ("ML has shown great promise")?
**Quality signal:** Specific stakes → accepted papers. Vague stakes → rejected papers.

### Move 2: Problem Gap
**Function:** Identify the specific gap between current practice and what's needed.
**What to look for:** Is the gap *structural* (fundamentally limited) or merely *quantitative* (not good enough)? Are limitations numbered and specific? Does each limitation map to a design choice?
**Quality signal:** Structural gaps motivate new approaches. Quantitative gaps motivate more experiments.

### Move 3: Key Abstraction
**Function:** Introduce the paper's defining intellectual contribution as a named concept.
**What to look for:** A coined, memorable, citable term. "Progressive disaggregation." "External termination layer." "Intrinsic evaluation framework."
**Quality signal:** Accepted papers have named abstractions. Rejected papers describe contributions generically.

### Move 4: Design Intuition
**Function:** One-paragraph mental model of how the system works.
**What to look for:** Can you understand the approach from one paragraph + one overview figure? Is it a pipeline, architecture, or conceptual model?

### Move 5: Contributions
**Function:** Enumerate what the paper delivers.
**What to look for:** Claims with evidence ("We show X reduces Y by 13x") vs. process descriptions ("We propose a system"). Numbered with bold labels?

### Move 6: Results Preview
**Function:** Anchor the introduction with concrete numbers.
**What to look for:** Headline numbers in the intro. These appear only in final versions.

## Evaluation Architecture

### Claim-Evidence Mapping
For every contribution in the introduction, trace: claim → evaluation subsection → figure/table. Missing links are structural weaknesses.

### The Evaluation Maturity Scale
| Level | Character | What to look for |
|-------|-----------|------------------|
| 1 | Lab notebook | Results without interpretation |
| 2 | Technical report | Comprehensive but unfocused (no claim structure) |
| 3 | Conference paper | Results organized by research questions |
| 4 | Systems narrative | Claim-first headings + explicit takeaways after every experiment |

### Key Elements to Assess
- **Setup compression:** Few labeled paragraphs (good) vs. 35 subsections on infrastructure (overreach)
- **Deep dive / disaggregation:** Results broken down by meaningful dimensions (speed tier, RTT, geography). Shows who benefits most AND least.
- **Takeaway paragraphs:** Explicit synthesis after every experiment cluster, tying results back to specific claims.
- **Ablation:** Shows each component contributes. Its absence is a common reviewer concern.
- **Robustness:** Tests under conditions not in the training set.

## Design Section Craft

### Opening Move
- Good: Opens with an **abstraction** (what users reason about)
- Bad: Opens with **implementation** (how the system computes)

### The "Why" Move
A justification for the design, often via negative result: "The obvious approach fails because..."
This makes the chosen design feel inevitable rather than arbitrary.

### Component Naming
Named components that reflect function become the vocabulary the evaluation reuses. If a term could describe any paper in the field, it doesn't belong.

### The Key "Knob"
Every well-designed system has at least one configurable parameter whose existence demonstrates design maturity. Naming and explaining this knob shows the system isn't one-size-fits-all.

## Related Work Positioning

### Category Clustering
Group prior work into 2-4 categories with named limitations. Never more than 4 — more signals the author hasn't found the right organizing abstraction.

### Per-Category Limitation
Must be **structural** (inherent to the approach), not **quantitative** (they didn't do enough).

### The Positioning Sentence
A single sentence that carves out architectural space: "This paper does not focus on X. Instead, it addresses the complementary problem of Y." This preempts the "incremental" criticism.

## Recording Craft Observations

For each paper analyzed, fill in:

```markdown
## [Craft] — YYYY-MM-DD

### Introduction Anatomy
Move 1 (Stakes): [Present/Absent] — [Effective/Weak] — [Notes + quotes]
Move 2 (Gap): [Structural/Quantitative] — [Notes]
Move 3 (Abstraction): [Named term or generic] — [Notes]
Move 4 (Intuition): [Clear paragraph + figure?] — [Notes]
Move 5 (Contributions): [Claims or process descriptions?] — [Notes]
Move 6 (Results Preview): [Concrete numbers?] — [Notes]

### Evaluation Architecture
Claim-evidence map: [Complete/Incomplete — list any gaps]
Maturity level: [1-4]
Takeaways: [Present after every experiment?]
Ablation: [Present? Convincing?]

### Design Craft
Opening: [Abstraction or implementation?]
"Why" move: [Present? Via negative result?]
Key knob: [Named? Exposed?]

### Peak Observation
[The single most memorable insight from this paper]

### Lessons for My Writing
- [What you want to adopt for your own papers]
```
