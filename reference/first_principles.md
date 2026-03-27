# First-Principles Networking Framework: Quick Reference

Source: Arpit Gupta, "First-Principles Networking," https://sites.cs.ucsb.edu/~arpitgupta/first-principles-networking/

## The Four Invariant Questions

Apply these to any networked system paper. They are dimensions of analysis, not categories — a paper should be analyzed along ALL four.

### 1. State
- What state does the system manage?
- Where is it stored? How is it distributed?
- What happens when state becomes stale or inconsistent?
- How does state scale with network size/traffic volume?

### 2. Time
- What are the relevant timescales?
- How does the system handle tension between reaction speed and decision quality?
- What happens at different time horizons (per-packet vs. per-flow vs. per-epoch)?
- Is there a tradeoff between freshness of information and quality of decisions?

### 3. Coordination
- How do components coordinate?
- What's centralized vs. distributed?
- What are the consistency/availability tradeoffs?
- What happens under partial failure or network partition?

### 4. Interface
- What are the boundaries between components?
- What's the contract across each boundary?
- What gets abstracted away, and at what cost?
- Could a different interface boundary improve the design?

## Three Design Principles

### Disaggregation
Break a complex system into modular components. When papers propose monolithic solutions, ask: what are the separable concerns? When papers propose disaggregated designs, ask: what coupling did they introduce?

### Closed-Loop Reasoning
Does the system observe, decide, and act in a feedback loop? What's the loop latency? What happens when the loop is broken (partial observability, delayed action)?

### Decision Placement
Where are decisions made in the architecture? Why there? What would change if you moved the decision point closer to the data source, or further away?

## Anchored Dependency Graphs (ADGs)

A tool for mapping cross-paper dependencies:
- Paper A assumes "full flow-level visibility"
- Paper B shows flow-level visibility is impossible at 400Gbps
- The ADG reveals the tension → potential research opportunity

## Using This Framework in Synthesis

Build an **invariant matrix** across all papers:

| Paper | State | Time | Coordination | Interface |
|-------|-------|------|-------------|-----------|
| Paper A | Centralized flow table | Per-flow (~ms) | SDN controller | OpenFlow |
| Paper B | Distributed sketches | Per-packet (~μs) | Gossip | Custom P4 |

This reveals: which dimensions are contested, where there's consensus, where there's genuine disagreement, and which combinations no paper explores.

## Constraint-Change Analysis for Gap Identification

For each invariant, ask: "What if this changed by 10x?"
- What if bandwidth 10x → which designs break?
- What if latency 10x lower → which assumptions change?
- What if scale 10x → which coordination models fail?
- What if interface complexity 10x → which abstractions leak?

The answers reveal research opportunities at the intersection of changing constraints and existing design assumptions.
