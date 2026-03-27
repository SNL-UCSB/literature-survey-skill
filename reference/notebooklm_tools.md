# NotebookLM MCP CLI: Key Tools for the Literature Survey Skill

Source: https://github.com/jacob-bd/notebooklm-mcp-cli

## Prerequisites

Install and authenticate the NotebookLM MCP CLI before using this skill. See the repo's AUTHENTICATION.md for setup.

**Rate limits:** Free tier ~50 queries/day. Track usage in `nlm_config.md`.

## Architecture Reminder

NotebookLM is a **backend query engine**. Papers go in as sources. Grounded, cited answers come out. All student intellectual work lives locally.

Data flows:
- **To NLM:** Paper files/URLs for ingestion + structured queries
- **From NLM:** Grounded responses → parsed → written to local markdown files

## Core Tools Used by This Skill

### Notebook Management
```
notebook_create(title="survey-<topic>")
→ returns notebook_id (save to nlm_config.md)

notebook_get(notebook_id=<id>)
→ returns details + source list + processing status

tag(action="add", notebook_id=<id>, tags=["survey", "<topic>"])
→ enables cross-survey discovery

chat_configure(notebook_id=<id>, goal="custom",
    custom_prompt="<student intent context>",
    response_length="longer")
→ injects intent profile into every subsequent query
```

### Source Ingestion
```
# Single paper (blocking — use for expansion):
source_add(notebook_id=<id>, source_type="file", file=<path>, wait=True, wait_timeout=120)

# Single paper (async — use for batch ingestion):
source_add(notebook_id=<id>, source_type="file", file=<path>, wait=False)

# URL-based paper:
source_add(notebook_id=<id>, source_type="url", url="https://arxiv.org/pdf/...", wait=True)

# Batch ingestion (10+ papers):
batch(action="add_source", notebook_id=<id>,
      sources=[{"type": "file", "file": p} for p in papers])
```

### Querying (the primary tool)
```
# Per-paper queries (Pass 1, Pass 2, craft extraction, viz extraction):
notebook_query(notebook_id=<id>, query="For [title] by [author]: ...")
→ returns grounded response with citations to paper passages

# Cross-paper queries (synthesis, landscape, gap identification):
notebook_query(notebook_id=<id>, query="Across all papers in this notebook: ...")

# Cross-survey queries:
cross_notebook_query(query="...", tags=["survey"])
→ returns results from multiple notebooks with per-notebook citations
```

### Research Discovery
```
# Find papers the student doesn't know about:
research_start(query="<topic search>", source="web", mode="deep", title="<topic>-expansion")
→ returns notebook_id for research task

research_status(notebook_id=<research_id>, max_wait=300)
→ poll until complete, returns discovered sources

# Import approved discoveries into the survey notebook:
research_import(notebook_id=<survey_id>, task_id=<task_id>,
    source_indices=[0, 2, 5],  # student-approved only
    timeout=300)
```

### Artifact Generation
```
# Generate reports or slides as starting points:
studio_create(notebook_id=<id>, artifact_type="report")  # or "slide_deck"
studio_status(notebook_id=<id>)  # poll until complete
download_artifact(notebook_id=<id>, artifact_type="report", output_path="synthesis/nlm_report.md")
```

### Source Content Extraction
```
# Get raw text from a specific source (for local processing):
source_get_content(source_id=<id>)

# Describe a source (AI summary + keywords):
source_describe(source_id=<id>)
```

## Query Patterns by Mode

### Triage (batch, landscape-level)
- Pass 1 extraction: per-paper structured query (category, problem, contribution, evaluation, refs, relevance)
- Landscape map: cross-corpus grouping by problem threads + WYSIATI check
- Expansion candidates: frequently-cited references not in corpus

### Deepen (per-paper, structured extraction)
- Claim extraction with exact quotes
- Evidence audit (strong/moderate/weak rating)
- Methodology probe (assumptions, counterfactuals)
- Dependency extraction
- First-principles decomposition (State/Time/Coordination/Interface)
- Writing craft extraction (six-move intro, evaluation architecture, design craft)
- Visualization extraction (figure inventory, visual argument analysis)

### Synthesize (cross-paper, connective)
- Invariant matrix construction
- Dependency graph mapping
- Constraint-change gap identification
- Cross-survey comparison via tags
