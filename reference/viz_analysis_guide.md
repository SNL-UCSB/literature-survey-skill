# Visualization Analysis Guide: Extracting Craft from Paper Figures

This reference guides the visualization extraction step during Pass 2+ in deepen mode. The goal: build a corpus of effective visualization patterns from papers in your field, feeding directly into the data-visualization skill.

Source: SNL-UCSB WALTER principle + Tufte's data-ink ratio + Tukey's exploratory analysis philosophy.

## Figure Inventory Template

For every paper you analyze at Pass 2 or deeper, catalog every figure and table:

| # | Type | Role | Claim Supported | Encoding | Headline? |
|---|------|------|-----------------|----------|-----------|
| Fig 1 | Diagram | Overview/architecture | — | Block diagram | No |
| Fig 2 | Plot | Result comparison | Claim 1 | CDF comparison | Yes |
| Fig 3 | Plot | Deep-dive | Claim 2 | Faceted CDF | No |
| Tab 1 | Table | Baseline comparison | Claim 1 | Bold best, CI | No |

### Role Categories
- **Overview/architecture:** System diagram, pipeline, conceptual model
- **Result comparison:** Head-to-head against baselines (THE core evidence)
- **Deep-dive/disaggregation:** Results broken down by meaningful dimension
- **Ablation:** Component contribution analysis
- **Case study:** Specific instance or scenario walkthrough
- **Methodology illustration:** How data was collected/processed

## Visual Argument Analysis (Key Figures)

For the 2-3 most important figures, analyze deeply:

### 1. Claim Connection
- What specific claim from the introduction does this figure support?
- Can you trace: contribution → evaluation subsection → this figure?
- If the figure doesn't connect to a claim, why does it exist?

### 2. Encoding Choices
- What visual encoding is used? (CDF, bar chart, line plot, scatter, heatmap, violin, box plot, etc.)
- What are the axes? Units? Scale (linear vs. log)?
- How are groups distinguished? (Color, markers, line style, faceting)
- Is color the only differentiator, or are there redundant encodings (markers + line style) for grayscale printing?

### 3. WHY These Choices?
This is the critical analysis question. Good visualization choices serve the argument:
- **CDF instead of bar chart of means:** Reveals distribution shape, tail behavior, variance across observations — not just central tendency
- **Log scale:** Reveals order-of-magnitude differences that linear scale compresses
- **Faceting by dimension:** Shows disaggregated behavior (who benefits most?) that aggregate plots hide
- **CCDF on log-log:** Reveals heavy-tail structure invisible on linear axes

### 4. What's Missing?
- Error bars or confidence intervals?
- Baseline comparisons?
- Distribution shape (if only showing means)?
- Alternative conditions or configurations?
- Would a different encoding reveal something this one hides?

## Figure Quality Checklist

For each key figure, assess:

- [ ] **Axes:** Labeled, with units, readable font size
- [ ] **Legend:** Unambiguous, minimal, well-placed (not obscuring data)
- [ ] **Caption:** Self-contained — can you understand the figure from caption alone?
- [ ] **Text-figure alignment:** Does the prose accurately describe what the figure shows? Any contradictions?
- [ ] **Data-ink ratio:** Is there chartjunk? Unnecessary grid lines, borders, 3D effects?
- [ ] **Colorblind safety:** Would this figure be readable in grayscale or by someone with color vision deficiency?
- [ ] **Scale honesty:** Is the y-axis starting at zero when it should? Is a log scale justified or hiding weakness?

## The WALTER Assessment

Apply the WALTER principle to each key figure:

| Letter | Question | Assessment |
|--------|----------|------------|
| **W** | What hypothesis does this figure test? | [Clear / Vague / Missing] |
| **A** | What do the axes represent? Stated explicitly? | [Yes / Partially / No] |
| **L** | Where should the viewer focus? | [Directed / Left to reader] |
| **T** | What is the dominant trend? | [Clear in one sentence / Unclear] |
| **E** | What breaks the pattern? | [Identified / Missed / No exceptions] |
| **R** | Does the result connect back to W? | [Yes / Partially / No] |

## Best-Practice Extraction

When a figure is particularly effective, capture why:

```markdown
### Best Practice: [Paper] Fig [N]
**Pattern:** [e.g., "Faceted CDF for disaggregated comparison"]
**Why it works:** [e.g., "Reveals that improvement varies 3x across speed tiers — an aggregate CDF would mask this, making the result look uniformly moderate instead of dramatic for high-speed users"]
**Adopt for:** [e.g., "My evaluation when comparing across ISP tiers"]
```

Collect these in `synthesis/viz_patterns.md` to build a field-specific visualization cookbook.

## Recording Visualization Observations

```markdown
## [Visualization] — YYYY-MM-DD

### Figure Inventory
[Table as above]

### Visual Argument Analysis
**Fig [N] (headline figure):**
- Claim supported: ...
- Encoding: ...
- Why this encoding: ...
- What's missing: ...
- WALTER: W=[...] A=[...] L=[...] T=[...] E=[...] R=[...]

### Best Practices to Adopt
- [Pattern from this paper I want to use in my own work]

### Figures Extracted
- papers/figures/YYYY_author_figN_description.png
```
