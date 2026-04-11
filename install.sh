#!/bin/bash
set -e

# Roundtable — AI Advisory Roundtable Skills for Claude Code
# https://github.com/risingdream/roundtable

REPO_URL="https://github.com/risingdream/roundtable"
SKILLS_DIR=".claude/skills"
TEMP_DIR=$(mktemp -d)

echo "Roundtable — Installing AI advisory skills..."
echo ""

# Check if .claude directory exists (are we in a Claude Code project?)
if [ ! -d ".claude" ]; then
  mkdir -p ".claude/skills"
  echo "Created .claude/skills directory"
fi

# Clone or use local
if [ -d "skills" ] && [ -f "install.sh" ]; then
  # Running from cloned repo
  SRC="skills"
else
  # Running via curl
  echo "Downloading from $REPO_URL..."
  git clone --depth 1 "$REPO_URL" "$TEMP_DIR" 2>/dev/null
  SRC="$TEMP_DIR/skills"
fi

# Copy all skills (flatten subgroups into .claude/skills/)
count=0
for group in "$SRC"/*/; do
  for skill in "$group"*/; do
    skill_name=$(basename "$skill")
    if [ -f "$skill/SKILL.md" ]; then
      cp -r "$skill" "$SKILLS_DIR/$skill_name"
      echo "  + $skill_name"
      count=$((count + 1))
    fi
  done
done

# Cleanup
rm -rf "$TEMP_DIR"

echo ""
echo "Installed $count skills to $SKILLS_DIR/"
echo ""
echo "Usage:"
echo "  /rt-roundtable [topic]              Run a full roundtable debate"
echo "  /rt-research [topic]                Market research only"
echo "  /rt-thiel [question]                Ask Peter Thiel"
echo "  /rt-munger [question]               Ask Charlie Munger"
echo "  /rt-taleb [question]                Ask Nassim Taleb"
echo "  /rt-horowitz [question]             Ask Ben Horowitz"
echo "  /rt-levels [question]               Ask Pieter Levels"
echo "  /rt-walling [question]              Ask Rob Walling"
echo ""
echo "Example:"
echo "  /rt-roundtable AI SaaS 사이드프로젝트 사업화 전략 levels walling thiel"
echo ""
