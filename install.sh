#!/bin/bash
set -e

# Roundtable — AI Advisory Roundtable Skills
# https://github.com/risingdream/roundtable
# Supports: Claude Code, Codex CLI, OpenClaw, Hermes Agent

REPO_URL="https://github.com/risingdream/roundtable"
TEMP_DIR=$(mktemp -d)
PLATFORM=""

# Parse arguments
for arg in "$@"; do
  case "$arg" in
    --codex)    PLATFORM="codex" ;;
    --openclaw) PLATFORM="openclaw" ;;
    --hermes)   PLATFORM="hermes" ;;
    --all)      PLATFORM="all" ;;
    --help|-h)
      echo "Usage: ./install.sh [--codex|--openclaw|--hermes|--all]"
      echo ""
      echo "  (default)     Install to Claude Code   (.claude/skills/)"
      echo "  --codex       Install to Codex CLI      (.codex/skills/)"
      echo "  --openclaw    Install to OpenClaw        (skills/)"
      echo "  --hermes      Install to Hermes Agent    (~/.hermes/skills/)"
      echo "  --all         Install to all platforms"
      exit 0
      ;;
  esac
done

# Determine target directories
declare -a TARGETS

if [ "$PLATFORM" = "all" ]; then
  TARGETS=(".claude/skills" ".codex/skills" "skills" "$HOME/.hermes/skills")
elif [ "$PLATFORM" = "codex" ]; then
  TARGETS=(".codex/skills")
elif [ "$PLATFORM" = "openclaw" ]; then
  TARGETS=("skills")
elif [ "$PLATFORM" = "hermes" ]; then
  TARGETS=("$HOME/.hermes/skills")
else
  TARGETS=(".claude/skills")
fi

echo "Roundtable — Installing AI advisory skills..."
echo ""

# Clone or use local
if [ -d "skills" ] && [ -f "install.sh" ]; then
  SRC="skills"
else
  echo "Downloading from $REPO_URL..."
  git clone --depth 1 "$REPO_URL" "$TEMP_DIR" 2>/dev/null
  SRC="$TEMP_DIR/skills"
fi

# Install to each target
for SKILLS_DIR in "${TARGETS[@]}"; do
  mkdir -p "$SKILLS_DIR"
  count=0

  for group in "$SRC"/*/; do
    for skill in "$group"*/; do
      skill_name=$(basename "$skill")
      if [ -f "$skill/SKILL.md" ]; then
        cp -r "$skill" "$SKILLS_DIR/$skill_name"
        count=$((count + 1))
      fi
    done
  done

  echo "  [$SKILLS_DIR] $count skills installed"
done

# Cleanup
rm -rf "$TEMP_DIR"

echo ""
echo "Usage:"
echo "  /rt-roundtable investors [topic]     Thiel + Munger + Taleb + Horowitz debate"
echo "  /rt-roundtable builders [topic]      Levels + Walling debate"
echo "  /rt-roundtable all [topic]           All 6 personas debate"
echo "  /rt-research [topic]                 Market research only"
echo "  /rt-thiel [question]                 Ask Peter Thiel"
echo "  /rt-levels [question]                Ask Pieter Levels"
echo ""
echo "Example:"
echo "  /rt-roundtable builders AI SaaS side project monetization"
echo ""
