# literature-survey-skill

A [Claude Code](https://docs.anthropic.com/en/docs/claude-code) skill that helps PhD students build deep, synthesized understanding of a research area through a structured, cognitively-aware reading workflow.

## The Problem

Literature surveys are where PhD students spend the most time and get the least guidance. The standard approach — collect papers, read them, write a related work section — fails in predictable ways. Students anchor on the first few papers they read and never escape that framing. They read deeply where they should skim and skim where they should go deep. They extract information but never synthesize it. They know what each paper says but not what the papers say *to each other*. They produce related work sections that are annotated bibliographies in disguise — chronological lists of "X did Y" without intellectual narrative.

The root cause is cognitive, not mechanical. Kahneman's research on System 1 (fast, intuitive, pattern-matching) and System 2 (slow, deliberate, analytical) thinking explains exactly why surveys go wrong. System 1 is efficient for triage — "this paper is relevant, this one isn't" — but dangerous for synthesis, where it substitutes easy questions ("what's this paper about?") for hard ones ("what assumption does this paper share with that one, and when does it break?"). Students need structured checkpoints that force System 2 engagement at the moments where System 1 leads them astray.

This skill fixes that by combining four intellectual frameworks into a single workflow: Kahneman's dual-process theory (when to trust intuition, when to override it), Keshav's three-pass reading method (calibrated depth allocation), first-principles systems analysis (invariant questions that cut across papers), and NotebookLM as a grounded query backend (extracting exact quotes to counteract confirmation bias).

## Intellectual Foundations

### Daniel Kahneman — *Thinking, Fast and Slow* (2011)

Kahneman's dual-process framework provides the cognitive scaffolding. Five biases are particularly dangerous during literature surveys:

**WYSIATI (What You See Is All There Is).** Students treat their current corpus as complete. The skill forces explicit "what's missing?" checks at every transition point — after triage, after synthesis, and before finalizing any deliverable.

**Anchoring.** The first 2-3 papers read anchor all subsequent interpretation. The skill counteracts this by generating a landscape map *before* deep reading begins, so the student sees the full structure before committing to a mental model.

**Availability.** Recent or vivid papers dominate recall. The skill's invariant matrix forces systematic comparison across *all* papers on the same dimensions, preventing any single paper from disproportionately shaping the narrative.

**Substitution.** System 1 replaces hard questions with easy ones. "What assumption does this paper share with that one?" becomes "What is this paper about?" The skill uses structured prompts that block substitution — asking the hard question directly and requiring specific evidence.

**Illusion of Validity.** A coherent narrative feels true even when incomplete. The calibration protocol (student summary vs. NLM grounded extraction) makes gaps in understanding visible rather than hidden behind confident prose.

The skill instantiates these insights operationally: System 1 handles paper triage (fast categorization), while structured checkpoints force System 2 for claim verification, cross-paper analysis, and synthesis. The calibration protocol — where students write their understanding *before* seeing NLM's grounded extraction — is a direct prosthetic for System 2 engagement.

### S. Keshav — "How to Read a Paper" (2007)

Keshav's three-pass method provides the reading depth framework:

- **Pass 1** (5-10 minutes): Title, abstract, introduction, section headings, conclusions. Decide: is this worth more time?
- **Pass 2** (~1 hour): Grasp the content but not the details. Evidence and arguments, not proofs.
- **Pass 3** (4-5 hours): Virtual re-implementation. Understand every assumption, identify every limitation.

The skill extends Pass 3 with two additional dimensions not in Keshav's original: **writing craft extraction** (how the paper communicates, not just what it communicates) and **visualization extraction** (how figures serve the argument). These turn reading from pure consumption into active pattern-building for the student's own writing.

### First-Principles Systems Analysis

Developed in the Gupta Research Group for networking and systems research. Four invariant questions cut through surface differences between papers to reveal fundamental design choices:

- **State:** What state does the system manage? Where is it stored? How stale can it be?
- **Time:** What timescales matter? What are the latency requirements? Decision horizons?
- **Coordination:** Centralized or distributed? What consistency model? How are failures handled?
- **Interface:** What are the boundaries between components? What do the contracts look like?

These questions generate an *invariant matrix* where each row is a paper and each column is a fundamental dimension. Patterns, disagreements, and unexplored combinations become visible — precisely the material a strong related work section is built from.

### NotebookLM MCP CLI — Grounded Query Backend

NotebookLM serves as a backend query engine, not a knowledge store. Papers are ingested as sources; the student queries NLM for grounded extractions (exact quotes, cross-paper comparisons, passage identification). All intellectual artifacts — reading notes, synthesis documents, brainstorming sessions — live locally in the student's filesystem.

This architecture means the student's knowledge base survives even if the NLM notebook is deleted. Only query capability would be lost, not the accumulated understanding.

## How the Skill Works

The skill has four modes plus an expansion mechanism. Each mode can be invoked independently, but the intended flow is Intent → Triage → Deepen → Synthesize, with Expand triggering at transition points.

### `/survey intent` — What are you trying to learn?

Before any paper is read, the skill captures the student's goals, expertise level, and success criteria. It identifies one of four survey archetypes:

- **Explorer** — Entering a new area, needs landscape mapping (50-100+ papers, breadth-first)
- **Investigator** — Has specific questions to answer (10-25 papers, targeted)
- **Validator** — Thinks they've found a gap, needs confirmation (15-30 papers, positioning-focused)
- **Examiner** — Needs comprehensive mastery for an exam or survey paper (80-150+ papers, exhaustive)

The student's initial mental model is recorded verbatim — this becomes the baseline for measuring how their understanding changes. The archetype shapes every subsequent mode: corpus scope, reading depth allocation, time budget, and output format.

### `/survey triage` — What's in this pile?

Rapid Pass 1 over the corpus using NotebookLM for grounded extraction. The skill:

1. Sets up a NotebookLM notebook with the paper corpus
2. Generates Pass 1 summaries (category, problem, contribution quote, evaluation, key references)
3. Builds a landscape map — papers grouped by thread, methodology, and time period
4. Runs a WYSIATI check: what problem areas have zero papers? What methodologies are absent?
5. Compares the landscape to the student's initial mental model from intent mode — making anchoring effects visible
6. Prioritizes reading depth (Pass 1 only / Pass 2 recommended / Pass 3 required) against the time budget

### `/survey deepen` — What does this paper really say?

Structured Pass 2 and Pass 3 reading for individual papers. The mode forces System 2 engagement through:

- **Claim extraction and evidence audit** — exact quotes with strength ratings
- **Methodology probing** — explicit and implicit assumptions, what would break under changed conditions
- **Calibration protocol** — student writes their summary *before* seeing NLM's grounded extraction, then compares. The specificity gap is where learning happens.
- **First-principles decomposition** — State, Time, Coordination, Interface analysis for every paper
- **Virtual re-implementation** (Pass 3) — "If you built this from scratch, what would your design look like?"
- **Writing craft extraction** (Pass 3+) — Introduction anatomy using the six-move formula (Stakes → Problem Gap → Key Abstraction → Design Intuition → Contributions → Results Preview), evaluation architecture analysis, design section craft, related work positioning strategy
- **Visualization extraction** (Pass 2+) — Figure inventory, visual argument analysis using the WALTER principle, best-practice capture for the student's own figures

Each paper's note grows incrementally: `[Pass 1]` → `[Pass 2]` → `[Calibration]` → `[First-Principles]` → `[Craft]` → `[Visualization]` → `[My Notes]`.

### `/survey synthesize` — What connects all of this?

Cross-paper analysis for a specific deliverable. The mode builds:

- **Invariant matrix** — Papers compared on fundamental dimensions, revealing patterns and disagreements
- **Dependency graph** — Where one paper's design depends on another paper's assumption, and where those assumptions conflict
- **Gap analysis** — Constraint-change reasoning ("if bandwidth 10x, which solutions break?"), missing quadrants in the invariant matrix, methodology gaps
- **Narrative construction** — Thematic threads with intellectual arcs, not chronological annotated bibliographies

Output varies by intent: related work sections, area exam presentations, gap analyses, or new research directions.

### `/survey expand` — Should this corpus grow?

Structured corpus growth with student approval. Candidates emerge during triage (foundational references), deepen (dependencies), and synthesize (missing areas). Each candidate is presented with justification and time cost. The student chooses Add / Bookmark / Skip, with a budget guard that alerts when expansion outgrows the plan.

## What's in This Repo

```
literature-survey-skill/
├── SKILL.md                                    # The skill definition (install this)
├── README.md                                   # You are here
├── setup.sh                                    # One-command install script
├── .gitignore
├── reference/
│   ├── keshav_three_pass.md                   # Three-pass reading method with decision points
│   ├── kahneman_biases.md                     # System 1/System 2 biases and countermeasures
│   ├── first_principles.md                    # Invariant questions and design principles
│   ├── notebooklm_tools.md                   # NLM MCP CLI tool reference and query patterns
│   ├── writing_craft_moves.md                # Six-move intro formula + evaluation/design craft
│   └── viz_analysis_guide.md                 # Figure analysis, WALTER assessment, quality checklist
└── templates/
    ├── survey_intent_template.md              # Archetype, expertise, success criteria
    ├── paper_note_template.md                 # Growing paper note: Pass 1 → Craft → Viz
    ├── survey_triage_template.md              # Landscape map, WYSIATI check, reading priorities
    └── synthesis_template.md                  # Invariant matrix, dependency graph, gap analysis
```

### `SKILL.md`

The skill itself. Contains all four modes (Intent, Triage, Deepen, Synthesize), the Expand mechanism, session continuity protocol, and pointers to reference files. This is what Claude Code reads when you invoke `/survey`.

### `reference/`

Six reference files providing deep guidance for specific aspects of the workflow:

- **`keshav_three_pass.md`** — Condensed three-pass method with decision criteria for depth allocation and time estimates per pass level.
- **`kahneman_biases.md`** — The five biases most dangerous during surveys (WYSIATI, Anchoring, Availability, Substitution, Illusion of Validity) with concrete countermeasures and the dual-process rhythm that the skill enforces.
- **`first_principles.md`** — The four invariant questions (State, Time, Coordination, Interface) with sub-questions, three design principles (Disaggregation, Closed-loop reasoning, Decision placement), Anchored Dependency Graph construction, and constraint-change analysis.
- **`notebooklm_tools.md`** — Complete NLM MCP CLI tool reference organized by function (notebook management, source ingestion, querying, research discovery, artifact generation), with query pattern templates for each survey mode.
- **`writing_craft_moves.md`** — The six-move introduction formula derived from the paper-writing skill, evaluation architecture analysis (claim-evidence mapping, maturity scale, ablation), design section craft (abstraction-first opening, "Why" move, named components), and related work positioning strategy.
- **`viz_analysis_guide.md`** — Figure inventory template, visual argument analysis (encoding choices and why), the WALTER assessment protocol, figure quality checklist (axes, legend, caption, data-ink ratio, colorblind safety), and best-practice extraction for building a field-specific visualization cookbook.

### `templates/`

Four templates that the skill populates during a survey:

- **`survey_intent_template.md`** — Captures archetype, expertise level, mental model baseline, success criteria, advisor input, and an evolution log.
- **`paper_note_template.md`** — The growing paper note structure: Pass 1 (category, problem, contribution quote) → Pass 2 (claims, evidence audit, methodology, dependencies) → Calibration (student vs. NLM) → First-Principles (STCI analysis) → Craft (six-move intro, evaluation architecture, design craft, related work positioning, peak observation) → Visualization (figure inventory, visual argument analysis, WALTER) → My Notes (free-form).
- **`survey_triage_template.md`** — Landscape map with thread metadata, WYSIATI check, intent comparison (before vs. after), prioritized reading list with time budget allocation.
- **`synthesis_template.md`** — Invariant matrix, dependency graph, gap analysis (constraint changes, missing quadrants, methodology gaps, unasked questions), writing craft patterns from the corpus, narrative draft scaffolding by goal type, WYSIATI final audit.

## Installation

### Claude Code (recommended)

```bash
git clone https://github.com/SNL-UCSB/literature-survey-skill.git
cd literature-survey-skill
./setup.sh
```

This installs the skill to `~/.claude/skills/survey/`. You can then use `/survey intent`, `/survey triage`, `/survey deepen`, and `/survey synthesize` in any Claude Code session.

### Prerequisites

The skill requires the [NotebookLM MCP CLI](https://github.com/nicholasgcoles/notebooklm-mcp-cli) to be configured as an MCP server in your Claude Code setup. See `reference/notebooklm_tools.md` for configuration details.

### Manual

Copy `SKILL.md` to `~/.claude/skills/survey/SKILL.md`. Copy the `reference/` and `templates/` directories alongside it.

### Standalone (without Claude Code)

The reference materials and templates work independently:

- Use `templates/paper_note_template.md` as a reading note structure in Obsidian or any markdown editor.
- Use `reference/before_you_plot.md` and the WALTER principle from `reference/viz_analysis_guide.md` for figure analysis.
- Use `reference/writing_craft_moves.md` as a framework for analyzing how papers communicate.
- Use `templates/synthesis_template.md` to structure cross-paper analysis manually.

## Adapting for Your Lab

The skill ships with defaults tuned for systems and networking research. To adapt:

1. **First-principles questions.** Edit `reference/first_principles.md` to replace the four invariant questions (State, Time, Coordination, Interface) with dimensions fundamental to your field. In ML: Data, Inductive Bias, Optimization, Generalization. In security: Threat Model, Trust Boundary, Mechanism, Usability.
2. **Writing craft moves.** The six-move introduction formula in `reference/writing_craft_moves.md` is venue-agnostic but the examples are from systems papers. Add examples from your field's best papers.
3. **Survey archetypes.** The four archetypes (Explorer, Investigator, Validator, Examiner) and their default paper counts are calibrated for CS PhD students. Adjust the scope numbers for your field's publication rate and paper density.
4. **NotebookLM prompts.** The NLM query templates in `SKILL.md` use systems-specific terminology. Adapt the custom prompts for your domain vocabulary.
5. **Visualization patterns.** The WALTER principle and figure analysis guide are domain-agnostic, but you may want to add field-specific encoding recommendations (e.g., confusion matrices for ML, survival curves for clinical research).

## Design Principles

**Cognitive scaffolding, not mechanical automation.** The skill does not read papers for you. It structures when and how you engage your own thinking. System 1 handles triage; structured checkpoints force System 2 for everything that matters.

**Local-first architecture.** All intellectual artifacts (notes, synthesis, brainstorming) live in the student's filesystem. NotebookLM is a query backend — papers go in, grounded answers come out. If the NLM notebook were deleted, only query capability is lost, not the knowledge base.

**Calibrated depth.** Not every paper deserves the same attention. The skill allocates reading depth based on the student's goals and the paper's role in the landscape. Pass 1 for background, Pass 2 for core threads, Pass 3 for foundational papers — with time budget tracking.

**Anti-bias by design.** Every bias countermeasure is structural, not advisory. The skill doesn't say "watch out for anchoring" — it generates a landscape map before deep reading begins, so the student sees the full structure before committing to a mental model.

**Growing notes.** Paper notes accumulate sections as reading deepens. A paper read at Pass 1 has a one-paragraph note. The same paper at Pass 3+ has claims, evidence audits, methodology analysis, first-principles decomposition, writing craft extraction, and visualization analysis — all in one file.

**Reading as writing practice.** Pass 3+ papers aren't just analyzed for content — they're analyzed for craft. The six-move introduction formula, evaluation architecture, and visualization patterns extracted from well-written papers directly feed the student's own writing skill.

## Intellectual Lineage

| Source | Contribution | Where it appears |
|--------|-------------|------------------|
| Kahneman, *Thinking, Fast and Slow* (2011) | Dual-process theory; WYSIATI; anchoring; calibration | Every mode transition, calibration protocol, WYSIATI checks |
| Keshav, "How to Read a Paper" (2007) | Three-pass reading method; calibrated depth allocation | Triage mode depth assignment, Deepen mode structure |
| Gupta Lab, First-Principles Framework | Invariant questions (STCI); design principles; ADGs | Deepen mode Step 4, Synthesize mode invariant matrix |
| Gupta Lab, Paper-Writing Skill | Six-move intro formula; evaluation maturity; design craft | Deepen mode Step 6, writing craft extraction |
| Gupta Lab, WALTER Principle (2025) | Structured figure narration; visual argument analysis | Deepen mode Step 7, viz extraction |
| NotebookLM MCP CLI | Grounded query backend; source ingestion; cross-corpus queries | All modes (backend infrastructure) |
| Tufte, *The Visual Display of Quantitative Information* (1983) | Data-ink ratio; honest representation | Visualization analysis guide |

## Contributing

Contributions welcome. The most valuable additions would be:

- **Domain-specific first-principles questions** for fields beyond networking (ML, security, HCI, theory).
- **Example survey walkthroughs** showing the full Intent → Triage → Deepen → Synthesize cycle on a real corpus.
- **Additional bias countermeasures** from the judgment and decision-making literature.
- **Writing craft examples** from venues beyond SIGCOMM/NSDI/IMC (NeurIPS, ICML, SOSP, OSDI, CHI).
- **Integration patterns** for reference managers (Zotero, Mendeley) and note-taking tools (Obsidian, Notion).

## License

MIT

## Citation

If you use this skill in your research workflow, please cite:

```
@misc{literature-survey-skill,
  author = {Gupta, Arpit},
  title = {literature-survey-skill: A Claude Code skill for structured literature surveys},
  year = {2026},
  publisher = {GitHub},
  url = {https://github.com/SNL-UCSB/literature-survey-skill}
}
```
