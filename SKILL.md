---
name: survey
description: "Literature survey assistant with four modes: /survey intent (capture student goals, expertise, and success criteria), /survey triage (landscape mapping via NotebookLM), /survey deepen (structured reading with craft and visualization extraction), /survey synthesize (cross-paper analysis for related work, area exams, gap identification). Also: /survey expand (corpus growth proposals). Use when students mention reading papers, literature review, related work, area exam prep, paper corpus, or any systematic reading task."
---

# Literature Survey Skill — Intent → Triage → Deepen → Synthesize

This skill helps PhD students build a deep, synthesized corpus of research insights through a structured, cognitively-aware workflow. It combines Kahneman's dual-process theory, Keshav's three-pass reading method, first-principles analysis, and NotebookLM as a backend query engine.

**Architecture:** All student work lives locally (Obsidian/filesystem). NotebookLM is a query backend only — papers go in, grounded answers come out.

**Modes:**
- `/survey intent` — Capture what you're trying to learn and where you're starting from
- `/survey triage` — Map the landscape, prioritize reading depth
- `/survey deepen` — Structured reading with craft and visualization extraction
- `/survey synthesize` — Cross-paper analysis for deliverables
- `/survey expand` — Structured corpus growth proposals

If the student invokes `/survey` without a mode, ask which mode they want. If they seem unsure or are starting a new survey, begin with intent.

**Prerequisites:** NotebookLM MCP CLI must be configured. See `reference/notebooklm_tools.md` for setup.

---

## Mode 1: Intent — "What are you trying to learn?"

**Purpose:** Capture the student's survey goals, expertise level, and success criteria BEFORE any paper is read. This shapes all subsequent modes.

**Do NOT create any NotebookLM notebooks in this mode. Do NOT ingest any papers. The goal is purely clarifying intent.**

### Step 1: Identify the survey archetype

Ask the student which best describes their situation:

> Before we look at any papers, I need to understand what kind of survey this is. Which best describes you?
>
> **A. Explorer** — "I'm entering a new area and need to understand the landscape."
> **B. Investigator** — "I have specific questions I need answered from the literature."
> **C. Validator** — "I think I've found a gap/idea and want to confirm it's novel."
> **D. Examiner** — "I need to demonstrate comprehensive mastery for an exam or survey paper."

Each archetype has different defaults:

| Archetype | Triage scope | Deepen targets | Pass 3 count | Synthesize output |
|-----------|-------------|----------------|-------------|-------------------|
| Explorer | 50-100+ papers | 8-15 at Pass 2 | 2-3 | Landscape overview |
| Investigator | 10-25 papers | 5-10 at Pass 2 | 3-5 | Technique comparison |
| Validator | 15-30 papers | 3-5 closest at Pass 2+3 | 3-5 | Positioning argument |
| Examiner | 80-150+ papers | 15-25 at Pass 2 | 5-8 | Full narrative survey |

### Step 2: Assess expertise level

Ask calibration questions for the chosen topic:

> 1. **Vocabulary check:** Can you name 3 key technical terms in this area and define each in one sentence?
> 2. **Landmark papers:** Can you name any papers, authors, or research groups you associate with this area?
> 3. **Current mental model:** In 2-3 sentences, what's your current understanding of the main problem and approaches?
> 4. **Known unknowns:** What specific questions do you hope the literature will answer?

**Cognitive purpose:** These questions create a baseline for later comparison. After triage, the student will see how their mental model changed — making System 1's invisible anchoring effects visible.

### Step 3: Define success criteria

> 1. **Deliverable:** Related work section? Area exam presentation? Gap analysis? Idea validation?
> 2. **Scope:** Approximately how many papers do you expect to cover?
> 3. **Timeline:** When do you need the output?
> 4. **Time budget:** How many hours per week can you invest?

### Step 4: Check for advisor input

> Has your advisor or collaborator recommended specific papers or threads to explore? Any "must-read" papers with suggested reading depth?

### Step 5: Generate the intent profile

Write a `survey_intent.md` file using the template from `templates/survey_intent_template.md`. Save it to the student's survey directory:

```
literature-survey/surveys/<topic-slug>/survey_intent.md
```

Also create the directory structure:
```
surveys/<topic-slug>/
├── survey_intent.md
├── pdfs/
├── papers/
│   └── figures/
├── synthesis/
├── corpus_log.md
├── backlog.md
└── nlm_config.md
```

Tell the student: "Your survey intent is captured. Run `/survey triage` when you're ready to start mapping the landscape."

---

## Mode 2: Triage — "What's in this pile?"

**Purpose:** Rapid Pass 1 over a corpus of papers using NotebookLM. Map the landscape and decide where to invest deeper reading. The archetype from intent mode shapes scope and clustering.

### Step 1: Set up NotebookLM backend

Read the student's `survey_intent.md` and `nlm_config.md`. If no notebook exists yet:

```
notebook_create(title="survey-<topic-slug>")
chat_configure(notebook_id=<id>, goal="custom",
    custom_prompt="You are a research corpus query engine for a PhD student
        surveying [topic]. The student is an [archetype] with goals: [from intent].
        Always cite specific papers and quote relevant passages.",
    response_length="longer")
tag(action="add", notebook_id=<id>, tags=["survey", "<topic>", "<term>"])
```

Save the notebook_id to `nlm_config.md`.

### Step 2: Seed the corpus

Ask the student for their initial papers (PDFs, URLs, BibTeX). For each paper:

1. **Acquire the PDF locally** using the priority chain:
   - Student already has the file → copy to `pdfs/YYYY_author_shorttitle.pdf`
   - Open-access URL (Arxiv, university repo) → download via `wget`
   - Semantic Scholar API → query for open-access PDF URL
   - Prompt the student for upload or URL

2. **Ingest into NotebookLM** (async for large batches):
   ```
   source_add(notebook_id=<id>, source_type="file", file=<path>, wait=False)
   ```

3. **Log in `corpus_log.md`** with status "ingesting".

While papers load (3-5 min for 15+ papers), use the time productively — refine intent, discuss the topic, let the student start reading local PDFs if they want.

### Step 3: Generate Pass 1 summaries

Once sources are ready, for each paper query NLM:

```
notebook_query(notebook_id=<id>,
    query="For [title] by [author]: provide CATEGORY (measurement/systems-building/theory/survey),
    PROBLEM (one sentence), CONTRIBUTION (exact quote of main claim), EVALUATION (system/dataset/testbed),
    KEY REFERENCES (3-5 most cited references), RELEVANCE to survey goals (high/medium/low)")
```

Write each response to a local file: `papers/YYYY_author_shorttitle.md` with a `[Pass 1]` header.

### Step 4: Generate landscape map

Query NLM for a cross-corpus landscape:

```
notebook_query(notebook_id=<id>,
    query="Group all papers by PROBLEM addressed (3-5 major threads). For each thread, list papers
    and methodology. Identify chronological patterns. WYSIATI CHECK: What problem areas or
    methodologies are absent? What would a skeptical reviewer say is missing?")
```

Write to `survey_triage.md`.

### Step 5: WYSIATI check and intent comparison

**This is a System 2 checkpoint.** Show the student their initial mental model (from `survey_intent.md`) alongside the landscape map:

> "Here's what you thought the area looked like when you started. Here's what the corpus actually shows. What's different? What surprised you?"

### Step 6: Prioritize reading depth

Help the student categorize each paper against their time budget:
- **Pass 1 only** — background knowledge
- **Pass 2 recommended** — relevant to core thread
- **Pass 3 required** — foundational, must deeply understand

Update `survey_triage.md` with the prioritized reading list.

### Step 7: Surface expansion candidates

```
notebook_query(notebook_id=<id>,
    query="Which references appear in 3+ papers but are NOT sources in this notebook?
    For each, explain why it might be important to add.")
```

Append candidates to `corpus_log.md` with reason=FOUNDATIONAL. Present to student for Add/Bookmark/Skip decision (see `/survey expand` protocol).

---

## Mode 3: Deepen — "What does this paper really say?"

**Purpose:** Structured Pass 2 and Pass 3 reading for individual papers. Forces System 2 engagement, captures insights locally, uses NLM for grounded extraction and calibration.

### Step 1: Select a paper

Ask which paper from the triage reading list. Read their existing paper note if one exists.

### Step 2: Pass 2 protocol

Run four NLM queries and write results to the local paper note:

**a. Claim extraction:**
```
notebook_query: "For [title]: Quote the 3 most important claims with section/page references."
```

**b. Evidence audit:**
```
notebook_query: "For [title]: For each claim, what evidence is provided? Rate as strong/moderate/weak."
```

**c. Methodology probe:**
```
notebook_query: "For [title]: Describe evaluation setup. What explicit and implicit assumptions?
What would break if workload/scale/topology changed?"
```

**d. Dependency extraction:**
```
notebook_query: "For [title]: What results from other papers does this depend on?
Which dependencies might not hold in other contexts?"
```

Write all responses to the paper's local note as a `[Pass 2]` section.

### Step 3: Calibration check (System 2 prosthetic)

After the student has read the paper themselves, compare their understanding with NLM's grounded extraction:

1. Ask the student: "In one sentence, what is this paper's main contribution?"
2. Query NLM: "Quote the exact main contribution claim from the abstract or introduction."
3. Show both side by side in a `[Calibration]` section. Highlight the specificity gap.

### Step 4: First-principles decomposition

```
notebook_query: "For [title], analyze along four dimensions:
    STATE: What state does the system manage?
    TIME: What timescales matter?
    COORDINATION: How do components coordinate?
    INTERFACE: What are the boundaries between components?
    Quote specific passages as evidence."
```

Write to the paper note as `[First-Principles]` section.

### Step 5: Pass 3 — Virtual re-implementation (foundational papers only)

Ask the student:
- "If you had to build this system from scratch with the same goals, what would your design look like?"
- "What assumptions are never explicitly stated?"
- "Write three critical questions a skeptical PC member would ask."

### Step 6: Writing craft extraction (Pass 3+ papers the student admires)

Read `reference/writing_craft_moves.md` for the full framework. Query NLM and guide the student through:

**a. Introduction anatomy — the six-move formula:**
```
notebook_query: "For [title], analyze the INTRODUCTION:
    MOVE 1 (Stakes): How does it open? Specific actors/applications/dollar amounts?
    MOVE 2 (Problem Gap): Structural or quantitative? Numbered limitations?
    MOVE 3 (Key Abstraction): Does it coin a memorable, citable term?
    MOVE 4 (Design Intuition): One-paragraph mental model? Overview figure?
    MOVE 5 (Contributions): Claims with evidence, or process descriptions? Numbered?
    MOVE 6 (Results Preview): Concrete headline numbers?
    Quote specific passages."
```

**b. Evaluation architecture:**
```
notebook_query: "For [title], analyze the EVALUATION:
    CLAIM-EVIDENCE MAP: List every intro claim → evaluation subsection → figure/table.
    SETUP: Compressed or technical report?
    DEEP DIVE: Results disaggregated by meaningful dimensions?
    TAKEAWAYS: Explicit takeaway after every experiment cluster?
    ABLATION: Shows each component contributes?"
```

**c. Design section craft:**
```
notebook_query: "For [title], analyze the DESIGN:
    Opens with abstraction or implementation?
    'Why' move — justification via negative result?
    Named components? Key configurable 'knob'?"
```

**d. Related work positioning:**
Ask the student: How many categories? Structural or quantitative limitations? Explicit positioning sentence?

**e. Peak observation:** What is the single most memorable insight — the thing you'd cite 10 years from now?

**f. Lessons for my writing:** The student captures what they want to adopt for their own papers.

Write to paper note as `[Craft]` section. Also append key lessons to `synthesis/writing_craft_corpus.md`.

### Step 7: Visualization extraction (all Pass 2+ papers)

Read `reference/viz_analysis_guide.md`. Query NLM and guide the student through:

**a. Figure inventory:**
```
notebook_query: "For [title]: List every figure and table. For each: caption, role
    (overview/comparison/deep-dive/ablation/case-study), claim it supports, encoding used.
    Which is the headline figure?"
```

**b. Visual argument analysis (2-3 key figures):**
```
notebook_query: "For [title], for the 2-3 most important figures:
    What claim does each support? Describe encoding choices (axes, scale, color, faceting).
    WHY those choices — does the encoding serve the argument?
    What does the figure NOT show that would be useful?"
```

**c. Figure extraction from local PDF:** If the student wants key figures extracted, use PyMuPDF on the local PDF in `pdfs/`, or prompt for manual screenshots. Save to `papers/figures/`.

Write to paper note as `[Visualization]` section. Append best-practice examples to `synthesis/viz_patterns.md`.

### Output

The local paper note (`papers/YYYY_author_shorttitle.md`) grows through the mode:
`[Pass 1]` → `[Pass 2]` → `[Calibration]` → `[First-Principles]` → `[Craft]` → `[Visualization]` → `[My Notes]`

---

## Mode 4: Synthesize — "What connects all of this?"

**Purpose:** Cross-paper synthesis for a specific deliverable. Uses NLM cross-corpus queries, writes all results locally.

### Step 1: Select synthesis goal

The student chooses (informed by their intent profile):
- **Related work section** — organized thematic narrative
- **Area exam presentation** — breadth + depth + frontier identification
- **Research gap identification** — systematic analysis of what's missing
- **New idea synthesis** — creative recombination of insights

### Step 2: Invariant matrix

```
notebook_query: "For every paper, build a comparison matrix:
    State management | Primary timescale | Coordination model | Interface design.
    Highlight where papers make fundamentally different choices."
```

Write to `synthesis/invariant_matrix.md`. Student annotates locally.

### Step 3: Dependency graph

```
notebook_query: "Identify cases where one paper's design DEPENDS ON an assumption
    another paper challenges. Quote the assumption and the challenging evidence."
```

Write to `synthesis/dependency_graph.md`.

### Step 4: Gap identification

```
notebook_query: "If [bandwidth/latency/scale] changed by 10x, which solutions still work?
    Which break? What new problems emerge that no paper addresses?"
```

Also ask: "Looking at the invariant matrix — are there combinations no paper explores? Missing methodologies?"

Write to `synthesis/gap_analysis.md`.

### Step 5: Cross-survey synthesis (if multiple survey notebooks exist)

```
cross_notebook_query(query="How do approaches to [dimension] differ between
    [survey A] and [survey B]?", tags=["survey"])
```

### Step 6: Narrative construction

Based on the synthesis goal, generate the deliverable draft:

- **Related work:** Thematic threads with intellectual arcs, not chronological lists. Each thread: "These papers address X by solving Y, but none handle Z — our contribution."
- **Area exam:** Breadth across subfield + depth on 2-3 foundational papers + frontier identification + student's own position.
- **Gap analysis:** Constraint-change analysis → candidate problems with first-principles justification.
- **New ideas:** "Paper A solves X under constraint C1. C1 is changing because of [trend]. Under C2, Paper A breaks because [dependency]. New approach needs [design principle]."

### Step 7: WYSIATI final audit

Before finalizing:
> "What perspectives are missing? What would someone from [adjacent field] say? Am I over-indexing on [one group/venue/methodology]?"

### Step 8: Generate artifacts from NLM Studio (optional)

```
studio_create(notebook_id=<id>, artifact_type="report")  # or "slide_deck"
download_artifact(notebook_id=<id>, artifact_type="report", output_path="synthesis/nlm_report.md")
```

These are starting points — the student edits locally.

---

## Cross-Cutting: Expand — "Should this corpus grow?"

**Purpose:** Structured, student-in-the-loop corpus expansion. Triggers at transition points between modes, not mid-reading.

### When candidates emerge

- **During triage:** Frequently-cited references not in corpus → reason=FOUNDATIONAL
- **During deepen:** Dependencies the student hasn't read → reason=DEPENDENCY
- **During synthesize:** Entire sub-areas missing → reason=GAP_FILL
- Papers that challenge existing corpus → reason=COUNTER
- Adjacent community working on same problem → reason=ADJACENT

### The proposal workflow

Batch candidates and present at transition points with:

| Paper | Source of discovery | Reason | Relevance to intent | Suggested pass | Time cost |
|-------|-------------------|--------|---------------------|---------------|-----------|

For each, the student chooses:
- **Add** → `source_add` to NLM notebook, download PDF locally, create paper note with Pass 1, update `corpus_log.md`
- **Bookmark** → save to `backlog.md` for future surveys
- **Skip** → log the reason (especially important for COUNTER papers)

### Budget guard

Track expansion against the intent profile's scope and time budget. If corpus outgrows the plan:

> "You started targeting ~30 papers. You're at 42. Your remaining time budget supports deepening ~5 more. Adjust scope or be more selective?"

For Validators: conservative expansion. For Examiners: more permissive with diminishing-returns reasoning.

### Discovery via NLM research

For Explorers and Examiners:
```
research_start(query="[topic-specific search]", source="web", mode="deep", title="<topic>-expansion")
research_status(notebook_id=<research_id>, max_wait=300)
# Present discovered papers through the expand proposal workflow
research_import(notebook_id=<survey_id>, task_id=<task_id>, source_indices=[student-approved])
```

---

## Session Continuity

When a student returns after time away:

1. Read their local files: `survey_intent.md` (why), `survey_triage.md` (landscape), `corpus_log.md` (what's in the corpus), `papers/*.md` (what's been read).
2. Read `nlm_config.md` to reconnect to the NLM notebook.
3. Check which papers need deeper reading (marked Pass 2/3 in triage but no `[Pass 2]` section in paper note).
4. Resume from where they left off.

The student's state is reconstructed from local files, not from NLM. If the NLM notebook were deleted, only query capability is lost — not the knowledge base.

---

## Reference Files

Read these when deeper guidance is needed:

| When you need... | Read this file |
|---|---|
| Keshav's three-pass method details | `reference/keshav_three_pass.md` |
| Kahneman biases relevant to surveys | `reference/kahneman_biases.md` |
| First-principles invariant questions | `reference/first_principles.md` |
| NotebookLM MCP tool reference | `reference/notebooklm_tools.md` |
| Six-move intro formula + craft questions | `reference/writing_craft_moves.md` |
| Figure analysis guide + quality checklist | `reference/viz_analysis_guide.md` |
| Survey intent template | `templates/survey_intent_template.md` |
| Paper note template | `templates/paper_note_template.md` |
| Triage template | `templates/survey_triage_template.md` |
| Synthesis template | `templates/synthesis_template.md` |
