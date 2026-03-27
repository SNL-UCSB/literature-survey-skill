# Kahneman's Dual-Process Framework: Biases in Literature Surveys

Source: Daniel Kahneman, *Thinking, Fast and Slow*, 2011.

## System 1 vs. System 2

**System 1:** Fast, automatic, effortless, pattern-matching. Generates impressions, feelings, inclinations. Always running.

**System 2:** Slow, deliberate, effortful, serial. Performs complex computations, applies rules, checks System 1. Lazy — only activates when needed.

## How System 1 Dominates Literature Surveys

When a student reads papers without structured intervention, System 1 runs the show:

- **Instant categorization:** "This is a caching paper." Feels like understanding. It isn't.
- **Narrative construction:** After 3-4 papers, System 1 has already built a story. Every subsequent paper gets assimilated or discarded.
- **Question substitution:** Instead of "what are the fundamental tradeoffs?" System 1 answers "what did the conclusion say?"
- **Fluent confidence:** The student *feels* knowledgeable. They can talk about the area. But they can't explain why Paper A conflicts with Paper B's assumptions.

## The Five Key Biases

### 1. WYSIATI (What You See Is All There Is)
System 1 builds a coherent story from available information without noticing what's missing. A student who has read 5 CDN papers unconsciously assumes CDNs are the whole field.

**Countermeasure:** The WYSIATI check in triage mode. Explicitly ask: "What's NOT here?"

### 2. Anchoring
The first paper read sets the frame. If it's a measurement paper, the entire area feels like "measurement." Breaking the anchor requires deliberate System 2 effort.

**Countermeasure:** The landscape map presents all papers simultaneously. The intent comparison shows how the student's mental model (anchored on early reading) differs from the actual corpus.

### 3. Availability Heuristic
Recent papers and vivid results ("10x improvement!") dominate mental models regardless of significance.

**Countermeasure:** The priority scoring in expand mode weights citation frequency over recency. The invariant matrix in synthesize mode forces analysis across dimensions rather than by salience.

### 4. Illusion of Validity
After reading 10 papers, students feel confident they understand the area. Confidence is driven by the *coherence* of their story, not by its *completeness*.

**Countermeasure:** The calibration protocol in deepen mode. Student writes their understanding → NLM extracts the paper's actual text → the gap becomes visible.

### 5. Substitution
When asked hard questions ("what are the open problems?"), System 1 substitutes easy ones ("what did the last paper say the future work is?").

**Countermeasure:** The structured prompts in deepen mode are designed to block substitution. "Quote the exact claims" prevents paraphrase-as-understanding. "What would break if constraints changed?" forces counterfactual reasoning.

## When System 1 IS Useful

System 1 excels at rapid pattern matching across many items — exactly what Pass 1 triage needs. The skill deliberately gives System 1 free rein during batch categorization, then inserts System 2 checkpoints.

## The Dual-Process Rhythm

```
Intent:     [System 2] — deliberate self-interrogation before exposure
Triage:     [System 1] → checkpoint → [System 2] → checkpoint
Deepen:     [System 2] with anti-substitution scaffolding + NLM calibration
Synthesize: [System 2] with counterfactual prompts + WYSIATI audit
Expand:     [System 2] gatekeeping of System 1 impulses
```
