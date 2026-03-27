# literature-survey-skill

PhD students spend weeks on literature surveys. Most of that time is plumbing — finding papers, extracting claims, cross-referencing terminology, building comparison tables, chasing citation chains. The intellectual work that matters — spotting shared assumptions, finding where they break, recognizing the gap nobody has exploited — takes a fraction of the effort but only happens after the student is already exhausted from logistics.

This skill offloads the plumbing to the machine. NotebookLM ingests your papers and returns grounded extractions with exact quotes. Claude Code manages the workflow — structured queries, template population, reading-depth tracking. You focus on forming hypotheses, deciding what matters, and building the narrative. The skill doesn't just save time; it makes you sharper. Every checkpoint — calibration protocols, WYSIATI checks, first-principles decomposition — forces you to articulate your understanding and confront where it falls short.

**Who this is for:** PhD students and researchers running literature surveys of 10-150+ papers. Tuned for systems and networking (SIGCOMM, NSDI, CoNEXT, IMC) but adaptable to any field — see [Customize for Your Field](#customize-for-your-field).

Built on [Claude Code](https://docs.anthropic.com/en/docs/claude-code).

## Quick Start

```bash
git clone https://github.com/SNL-UCSB/literature-survey-skill.git
cd literature-survey-skill
./setup.sh
```

This installs the skill to `~/.claude/skills/survey/`. Four commands become available:

```
/survey intent     — Capture your goals, expertise, and survey archetype
/survey triage     — Map the landscape, prioritize reading depth
/survey deepen     — Structured deep reading with craft and visualization extraction
/survey synthesize — Cross-paper analysis for your deliverable
/survey expand     — Propose and evaluate corpus growth
```

Start with `/survey intent`. The skill guides you from there.

### Prerequisites

The [NotebookLM MCP CLI](https://github.com/jacob-bd/notebooklm-mcp-cli) must be configured as an MCP server in your Claude Code setup. **[Follow the setup guide](NOTEBOOKLM_SETUP.md)** — it covers installation, Google authentication, and MCP registration in ~5 minutes.

### Manual Install

Copy `SKILL.md` to `~/.claude/skills/survey/SKILL.md`. Copy `reference/` and `templates/` alongside it.

## How Each Mode Works

### Intent — "What are you trying to learn?"

The skill captures your goals, expertise level, and success criteria before any paper is read. It assigns one of four survey archetypes with calibrated defaults:

| Archetype | When to use | Corpus | Pass 3 papers | Output |
|-----------|------------|--------|---------------|--------|
| Explorer | Entering a new area | 50-100+ | 2-3 | Landscape overview |
| Investigator | Specific questions to answer | 10-25 | 3-5 | Technique comparison |
| Validator | Confirming a gap or idea | 15-30 | 3-5 | Positioning argument |
| Examiner | Exam or survey paper | 80-150+ | 5-8 | Full narrative survey |

Your initial mental model is recorded verbatim. After triage, you compare it against what the corpus actually shows. The delta is where learning happens.

### Triage — "What's in this pile?"

Triage builds the landscape map. The skill ingests papers into NotebookLM and generates per-paper summaries: category, problem, quoted contribution, evaluation, key references. It groups papers by thread and methodology, then runs a WYSIATI check — "what problem areas have zero papers?" It compares the landscape against your initial mental model from Intent, making anchoring effects visible. Finally, it prioritizes reading depth against your time budget.

### Deepen — "What does this paper really say?"

Structured Pass 2 and Pass 3 for individual papers. Each pass adds layers to a growing paper note:

- **Pass 2**: Claim extraction with exact quotes, evidence audit with strength ratings, methodology probing ("what breaks if the workload changes?"), dependency mapping.
- **Calibration**: You write your one-sentence summary *before* seeing NLM's grounded extraction. The specificity gap between the two is the learning signal.
- **First-principles**: State, Time, Coordination, Interface decomposition — forcing cross-paper comparability on fundamental dimensions.
- **Pass 3**: Virtual re-implementation. "If you built this from scratch with the same goals, what would your design look like?"
- **Writing craft extraction** (Pass 3+): Introduction anatomy using the six-move formula (Stakes → Problem Gap → Key Abstraction → Design Intuition → Contributions → Results Preview), evaluation architecture, design section craft, related work positioning.
- **Visualization extraction** (Pass 2+): Figure inventory, visual argument analysis using WALTER, best-practice capture.

A paper at Pass 1 produces a one-paragraph note. The same paper at Pass 3+ produces claims, evidence audits, first-principles decomposition, writing craft patterns, and visualization analysis — all in one file.

### Synthesize — "What connects all of this?"

Synthesize produces cross-paper analysis for a specific deliverable. The skill builds three structures: an invariant matrix (papers compared on fundamental dimensions), a dependency graph (where one paper's design depends on an assumption another paper challenges), and a gap analysis (constraint-change reasoning, missing quadrants, methodology gaps). Output depends on the goal — related work sections with thematic arcs, area exam presentations, gap analyses, or new research directions.

### Expand — "Should this corpus grow?"

Structured corpus growth with student-in-the-loop approval. Candidates surface during triage (foundational references cited in 3+ papers), deepen (dependencies the student hasn't read), and synthesize (entire sub-areas missing from the corpus). Each candidate comes with justification and time cost. A budget guard alerts when expansion outgrows the plan.

## What's in This Repo

```
literature-survey-skill/
├── SKILL.md                              # The skill definition (install this)
├── README.md                             # You are here
├── NOTEBOOKLM_SETUP.md                   # NotebookLM MCP CLI setup guide
├── setup.sh                              # One-command install script
├── .gitignore
├── reference/
│   ├── keshav_three_pass.md             # Three-pass reading method with decision points
│   ├── kahneman_biases.md               # System 1/System 2 biases and countermeasures
│   ├── first_principles.md              # Invariant questions and design principles
│   ├── notebooklm_tools.md             # NLM MCP CLI tool reference and query patterns
│   ├── writing_craft_moves.md          # Six-move intro formula + evaluation/design craft
│   └── viz_analysis_guide.md           # Figure analysis, WALTER assessment, quality checklist
└── templates/
    ├── survey_intent_template.md        # Archetype, expertise, success criteria
    ├── paper_note_template.md           # Growing paper note: Pass 1 → Craft → Viz
    ├── survey_triage_template.md        # Landscape map, WYSIATI check, reading priorities
    └── synthesis_template.md            # Invariant matrix, dependency graph, gap analysis
```

### Reference Files

Six files providing targeted guidance for specific aspects of the workflow.

`keshav_three_pass.md` covers the three-pass reading method with decision criteria for depth allocation and time estimates per pass level. `kahneman_biases.md` covers the five biases most dangerous during surveys — WYSIATI, Anchoring, Availability, Substitution, Illusion of Validity — with structural countermeasures baked into the workflow.

`first_principles.md` covers the four invariant questions (State, Time, Coordination, Interface), three design principles, and Anchored Dependency Graph construction. `notebooklm_tools.md` covers the full NLM MCP CLI tool reference with query pattern templates organized by survey mode.

`writing_craft_moves.md` covers the six-move introduction formula, evaluation architecture analysis, design section craft, and related work positioning strategy. `viz_analysis_guide.md` covers figure inventory, visual argument analysis, WALTER assessment, and quality checklists for honest representation.

### Templates

Four templates that grow during a survey. `survey_intent_template.md` captures archetype, expertise baseline, and success criteria. `paper_note_template.md` structures the growing paper note from Pass 1 through craft and visualization extraction. `survey_triage_template.md` structures landscape maps, WYSIATI checks, and prioritized reading lists. `synthesis_template.md` structures invariant matrices, dependency graphs, and gap analyses.

### Use These Templates Without Claude Code

The reference materials and templates work independently of the skill runtime. Use `paper_note_template.md` as a reading note structure in Obsidian or any markdown editor. Use `writing_craft_moves.md` as a framework for analyzing how papers communicate — print it out for lab reading groups. Use `synthesis_template.md` to structure cross-paper analysis manually. Use `viz_analysis_guide.md` and the WALTER principle for figure analysis in lab meetings.

---

## Why This Skill Exists

Academic research faces a structural squeeze. Stagnant funding collides with rising costs. The arithmetic is stark: researchers must produce more with less, or momentum falters. Agentic AI systems offer a way through — not by replacing researchers, but by compressing the operational middle of the research pipeline while keeping the intellectual work human. This is the argument laid out in [*Systems for Agents, Agents for Systems*](https://sites.cs.ucsb.edu/~arpitgupta/blog/systems-for-agents-agents-for-systems.html).

The division is clean. Three competencies remain structurally human: **discrimination** (evaluating what agents produce), **critique** (understanding failure modes), and **framing** (hypothesis formation and interpretation). Everything else — the mechanical logistics that exhaust students before they reach synthesis — is plumbing that machines can handle.

Literature surveys are where this principle hits hardest. A student with a sharp research question and a pile of 50 papers has the ideation. What they lack is an efficient path from that question to a synthesized understanding they can build on. They spend weeks on extraction and cross-referencing, arrive at synthesis anchored by whatever they happened to read first, and mistake a fluent annotated bibliography for genuine understanding. The skill provides the path. The student walks it.

The concern that agents weaken intellectual muscles gets the causality backwards. This skill doesn't hand students conclusions — it forces them to articulate their own understanding at every checkpoint and confront where it falls short. The calibration protocol, the WYSIATI checks, the first-principles decomposition — these are structural demands on the student's judgment. The machine provides raw material. The student provides discrimination, critique, and framing. The result is a student who reaches synthesis faster and arrives sharper, not one who skipped the thinking.

## Part of a Series

This skill is one of a family of Claude Code skills developed at the [Systems and Networking Lab (SNL)](https://github.com/SNL-UCSB) at UC Santa Barbara by [Arpit Gupta](https://sites.cs.ucsb.edu/~arpitgupta/), each targeting a different phase of the research pipeline where plumbing buries ingenuity:

| Skill | What it compresses | Student retains |
|-------|-------------------|-----------------|
| **[literature-survey-skill](https://github.com/SNL-UCSB/literature-survey-skill)** | Paper ingestion, claim extraction, cross-referencing, landscape mapping | Hypothesis formation, assumption identification, gap recognition, narrative construction |
| **[data-visualization-skill](https://github.com/SNL-UCSB/data-visualization-skill)** | Plot formatting, code generation, style compliance | Deciding what to show, why it matters, and whether the figure is honest |
| **[paper-writing-skill](https://github.com/SNL-UCSB/paper-writing-skill)** | Drafting mechanics, structural scaffolding, revision logistics | Argument construction, positioning, voice |

The principle is the same across all three: bridge the gap between ideation and execution. Compress the operational middle. Protect the thinking. The skills are independent — use any one alone — but they share an intellectual foundation and reinforce each other when used together. A literature survey feeds directly into a paper's related work section and its figures.

## Intellectual Foundations

### Kahneman's Dual-Process Theory

System 1 (fast, intuitive, pattern-matching) and System 2 (slow, deliberate, analytical) explain why surveys fail in predictable ways.

System 1 is efficient for triage. "This paper is relevant, this one isn't" is a fast pattern-match, and it works. System 1 becomes dangerous at synthesis. It substitutes easy questions for hard ones — "What is this paper about?" replaces "What assumption does this paper share with that one, and when does it break?" The student produces a fluent annotated bibliography and mistakes it for synthesis.

Five biases are operationally relevant. WYSIATI (treating the current corpus as complete) is countered by explicit "what's missing?" checks at every mode transition. Anchoring (the first papers read frame everything) is countered by generating a landscape map before deep reading begins. Availability (recent or vivid papers dominate recall) is countered by the invariant matrix, which forces comparison across all papers on the same dimensions. Substitution (easy questions replacing hard ones) is countered by structured prompts that ask the hard question directly. The Illusion of Validity (coherent narrative masking incompleteness) is countered by the calibration protocol — student summary versus NLM grounded extraction, side by side.

Every countermeasure is structural, not advisory. The landscape map breaks anchoring. The calibration protocol surfaces the specificity gap. The WYSIATI check makes absence visible. The workflow embeds the fix — the student never has to remember to apply it.

### Keshav's Three-Pass Reading Method

Keshav's method allocates reading depth systematically. Pass 1 (5-10 minutes) covers title, abstract, headings, and conclusions — enough to decide if the paper merits more time. Pass 2 (~1 hour) grasps content without details: evidence and arguments, not proofs. Pass 3 (4-5 hours) is virtual re-implementation. Understand every assumption. Identify every limitation.

The skill extends Pass 3 with two dimensions Keshav's original omits: writing craft extraction and visualization extraction. A well-written paper at Pass 3 rewards analysis of *how* it communicates, not just *what*. The six-move introduction formula, evaluation architecture patterns, and figure design choices extracted during deep reading feed directly into the student's own writing.

### First-Principles Systems Analysis

Four invariant questions cut through surface differences between papers to reveal fundamental design choices. Developed at the [Systems and Networking Lab (SNL)](https://github.com/SNL-UCSB) at UC Santa Barbara and detailed in [*A First-Principles Approach to Networked Systems*](https://sites.cs.ucsb.edu/~arpitgupta/first-principles-networking/), they are: What state does the system manage? What timescales matter? How do components coordinate? What are the boundaries between components?

These questions generate an invariant matrix — each row a paper, each column a fundamental dimension. Patterns, disagreements, and unexplored combinations become visible. The matrix is the raw material for a related work section built on structural comparison rather than chronological listing.

### NotebookLM as Grounded Query Backend

NotebookLM serves as a query engine, not a knowledge store. Papers are ingested as sources. The student queries NLM for grounded extractions — exact quotes, cross-paper comparisons, passage identification. All intellectual artifacts (reading notes, synthesis documents, brainstorming sessions) live locally in the student's filesystem.

This architecture is deliberate. If the NLM notebook were deleted, only query capability is lost. The student's accumulated understanding — captured in local markdown files — survives intact.

## Design Principles

**Shunt the plumbing, protect the thinking.** The machine handles paper ingestion, claim extraction, cross-referencing, and template population. The student handles hypothesis formation, assumption identification, gap recognition, and narrative construction. The division is clean: logistics to the machine, judgment to the human.

**Local-first architecture.** All intellectual artifacts live in the student's filesystem. NotebookLM holds paper sources and returns grounded answers. If NLM disappears, the student loses query capability — not the knowledge base.

**Calibrated depth.** Not every paper deserves the same attention. The skill allocates reading depth based on the student's goals and the paper's role in the landscape — Pass 1 for background, Pass 2 for core threads, Pass 3 for foundational papers — with time budget tracking throughout.

**Anti-bias by structure, not advice.** Every countermeasure is baked into the workflow. The landscape map breaks anchoring. The calibration protocol surfaces the specificity gap. The WYSIATI check makes absence visible. The invariant matrix prevents availability bias from distorting the narrative.

**Growing notes.** Paper notes accumulate sections as reading deepens. A Pass 1 paper has a one-paragraph note. A Pass 3+ paper has claims, evidence audits, methodology analysis, first-principles decomposition, craft extraction, and visualization analysis — all in one file, all traceable.

**Reading as writing practice.** Pass 3+ papers are analyzed for craft as well as content. The six-move introduction formula, evaluation architecture patterns, and visualization design choices extracted from well-written papers feed directly into the student's own writing skill. Reading and writing develop together.

## Customize for Your Field

The skill ships with defaults tuned for systems and networking research (SIGCOMM, NSDI, CoNEXT, IMC). Five adaptation points:

**First-principles questions.** Replace the four invariant questions (State, Time, Coordination, Interface) in `reference/first_principles.md` with dimensions fundamental to your field. ML: Data, Inductive Bias, Optimization, Generalization. Security: Threat Model, Trust Boundary, Mechanism, Usability.

**Writing craft examples.** The six-move formula in `reference/writing_craft_moves.md` is venue-agnostic. The examples are from systems papers. Add examples from your field's best-written work.

**Survey archetypes.** The four archetypes and their default paper counts are calibrated for CS PhD students. Adjust scope numbers for your field's publication rate and density.

**NotebookLM prompts.** The query templates in `SKILL.md` use systems-specific terminology. Adapt for your domain vocabulary.

**Visualization patterns.** The WALTER principle and figure analysis guide are domain-agnostic. Add field-specific encoding recommendations where needed (confusion matrices for ML, survival curves for clinical research, circuit diagrams for hardware).

## Intellectual Lineage

| Source | Contribution | Where it appears |
|--------|-------------|------------------|
| Gupta, [*Systems for Agents, Agents for Systems*](https://sites.cs.ucsb.edu/~arpitgupta/blog/systems-for-agents-agents-for-systems.html) (2025) | Compress the operational middle, protect judgment | Design philosophy, skill series rationale |
| Kahneman, *Thinking, Fast and Slow* (2011) | Dual-process theory, WYSIATI, anchoring, calibration | Every mode transition, calibration protocol, WYSIATI checks |
| Keshav, "How to Read a Paper" (2007) | Three-pass reading, calibrated depth | Triage depth assignment, Deepen mode structure |
| Gupta, [*A First-Principles Approach to Networked Systems*](https://sites.cs.ucsb.edu/~arpitgupta/first-principles-networking/) | Invariant questions (STCI), design principles, ADGs | Deepen Step 4, Synthesize invariant matrix |
| [paper-writing-skill](https://github.com/SNL-UCSB/paper-writing-skill) | Six-move intro formula, evaluation maturity, design craft | Deepen Step 6, writing craft extraction |
| [data-visualization-skill](https://github.com/SNL-UCSB/data-visualization-skill) | WALTER principle, structured figure narration, visual argument analysis | Deepen Step 7, visualization extraction |
| NotebookLM MCP CLI | Grounded query backend, source ingestion, cross-corpus queries | All modes (backend infrastructure) |
| Tufte, *The Visual Display of Quantitative Information* (1983) | Data-ink ratio, honest representation | Visualization analysis guide |

## Contributing

Contributions welcome. The highest-impact additions: domain-specific first-principles questions for fields beyond networking (ML, security, HCI, theory), example survey walkthroughs showing the full Intent → Triage → Deepen → Synthesize cycle on a real corpus, writing craft examples from venues beyond SIGCOMM/NSDI/IMC (NeurIPS, ICML, SOSP, OSDI, CHI), and integration patterns for reference managers (Zotero, Mendeley) and note-taking tools (Obsidian, Notion).

## License

MIT

## Citation

If you use this skill in your research workflow:

```
@misc{literature-survey-skill,
  author = {Gupta, Arpit},
  title = {literature-survey-skill: A Claude Code skill for structured literature surveys},
  year = {2026},
  publisher = {GitHub},
  url = {https://github.com/SNL-UCSB/literature-survey-skill}
}
```
