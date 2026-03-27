#!/bin/bash
# Install the literature-survey skill for Claude Code
# Usage: ./setup.sh

set -e

SKILL_DIR="${HOME}/.claude/skills/survey"

echo "Installing literature-survey skill to ${SKILL_DIR}..."

mkdir -p "${SKILL_DIR}/reference"
mkdir -p "${SKILL_DIR}/templates"

# Copy skill file
cp SKILL.md "${SKILL_DIR}/SKILL.md"

# Copy reference materials
cp reference/keshav_three_pass.md "${SKILL_DIR}/reference/keshav_three_pass.md"
cp reference/kahneman_biases.md "${SKILL_DIR}/reference/kahneman_biases.md"
cp reference/first_principles.md "${SKILL_DIR}/reference/first_principles.md"
cp reference/notebooklm_tools.md "${SKILL_DIR}/reference/notebooklm_tools.md"
cp reference/writing_craft_moves.md "${SKILL_DIR}/reference/writing_craft_moves.md"
cp reference/viz_analysis_guide.md "${SKILL_DIR}/reference/viz_analysis_guide.md"

# Copy templates
cp templates/survey_intent_template.md "${SKILL_DIR}/templates/survey_intent_template.md"
cp templates/paper_note_template.md "${SKILL_DIR}/templates/paper_note_template.md"
cp templates/survey_triage_template.md "${SKILL_DIR}/templates/survey_triage_template.md"
cp templates/synthesis_template.md "${SKILL_DIR}/templates/synthesis_template.md"

echo "Done. The /survey skill is now available in Claude Code."
echo ""
echo "Usage:"
echo "  /survey intent     — Capture your survey goals and expertise level"
echo "  /survey triage     — Map the landscape and prioritize reading depth"
echo "  /survey deepen     — Structured deep reading with craft extraction"
echo "  /survey synthesize — Cross-paper analysis for your deliverable"
echo "  /survey expand     — Propose and evaluate corpus growth"
