# Keshav's Three-Pass Method for Reading Research Papers

Source: S. Keshav, "How to Read a Paper," ACM SIGCOMM Computer Communication Review, 2007.

## Pass 1: The Bird's-Eye View (5-10 minutes)

**Read:** Title, abstract, introduction, section headings, conclusion. Glance at figures. Scan references for familiar names.

**Answer these questions:**
1. **Category:** What type of paper? Measurement, systems-building, theory, survey?
2. **Context:** What other papers is it related to? What theoretical bases were used?
3. **Correctness:** Do the assumptions appear valid?
4. **Contributions:** What are the paper's main contributions?
5. **Clarity:** Is the paper well written?

**Decision:** Stop (not relevant), or continue to Pass 2?

**Most papers deserve only Pass 1.** Use it for corpus triage.

## Pass 2: Grasping Content (~1 hour)

**Read:** The entire paper with greater care, but skip proofs and complex math.

**Key actions:**
- Note key points in margins
- Look at figures and graphs carefully — axes, error bars, statistical tests
- Mark relevant unread references for future reading
- Understand the main thrust well enough to summarize to someone else

**After Pass 2, you should be able to:**
- Summarize the paper's main thrust with supporting evidence
- Explain the paper's structure and argument to a peer

**Decision:** Stop (sufficient for background knowledge), or continue to Pass 3?

## Pass 3: Virtual Re-Implementation (4-5 hours)

**Goal:** Understand the paper deeply enough to reconstruct it from memory.

**Key actions:**
- Challenge every assumption
- Think about how YOU would have done it
- Compare your imagined approach with the actual one
- Identify hidden assumptions and missing citations
- Identify potential issues with experimental methodology
- Think about the design space the paper explores vs. what it doesn't

**After Pass 3, you should be able to:**
- Reconstruct the entire paper from memory
- Identify its strong and weak points
- Pinpoint implicit assumptions
- Identify missing citations
- Identify potential issues with experimental methodology

## The Three-Pass Method for Literature Surveys

Keshav also describes using the method for surveying a field:

1. Use an academic search engine to find 3-5 recent papers in the area
2. Do Pass 1 on each. Get a sense of the recent work.
3. Find shared citations and repeated author names → these are key papers and key researchers
4. Go to the key researchers' websites and see where they've published recently → these are the top venues
5. Go to the top venues' recent proceedings and scan for related work
6. Now you have your initial corpus → do Pass 2 on the key papers

This maps to our triage mode: the three-pass method IS the triage algorithm.
