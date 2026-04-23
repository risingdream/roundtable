#!/bin/bash
set -e

# Roundtable — AI Advisory Roundtable Skills
# https://github.com/risingdream/roundtable
# Supports: Claude Code, Codex CLI, OpenClaw, Hermes Agent

REPO_URL="https://github.com/risingdream/roundtable"
TEMP_DIR=$(mktemp -d)
PLATFORM=""
CUSTOM_DEST=""

cleanup() {
  rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

# Parse arguments
while [ $# -gt 0 ]; do
  arg="$1"
  case "$arg" in
    --codex)    PLATFORM="codex" ;;
    --openclaw) PLATFORM="openclaw" ;;
    --hermes)   PLATFORM="hermes" ;;
    --all)      PLATFORM="all" ;;
    --dest)
      shift
      if [ $# -eq 0 ]; then
        echo "Error: --dest requires a directory path" >&2
        exit 1
      fi
      CUSTOM_DEST="$1"
      ;;
    --help|-h)
      echo "Usage: ./install.sh [--codex|--openclaw|--hermes|--all] [--dest DIR]"
      echo ""
      echo "  (default)     Install to Claude Code   (.claude/skills/)"
      echo "  --codex       Install to Codex CLI      (\${CODEX_HOME:-~/.codex}/skills/)"
      echo "  --openclaw    Install to OpenClaw        (skills/)"
      echo "  --hermes      Install to Hermes Agent    (~/.hermes/skills/)"
      echo "  --all         Install to all platforms"
      echo "  --dest DIR    Install to a custom skills directory"
      exit 0
      ;;
    *)
      echo "Error: unknown option: $arg" >&2
      echo "Run ./install.sh --help for usage." >&2
      exit 1
      ;;
  esac
  shift
done

# Determine target directories
declare -a TARGETS

if [ -n "$CUSTOM_DEST" ]; then
  TARGETS=("$CUSTOM_DEST")
elif [ "$PLATFORM" = "all" ]; then
  TARGETS=(".claude/skills" "${CODEX_HOME:-$HOME/.codex}/skills" "skills" "$HOME/.hermes/skills")
elif [ "$PLATFORM" = "codex" ]; then
  TARGETS=("${CODEX_HOME:-$HOME/.codex}/skills")
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
        mkdir -p "$SKILLS_DIR/$skill_name"
        cp -R "$skill"/. "$SKILLS_DIR/$skill_name"/
        count=$((count + 1))
      fi
    done
  done

  echo "  [$SKILLS_DIR] $count skills installed"
done

echo ""
echo "Usage:"
echo "  /rt-roundtable vc [topic]            Thiel + Horowitz + Andreessen + Graham + Gurley debate"
echo "  /rt-roundtable investors [topic]     Buffett + Munger + Marks + Lynch + Dalio + Taleb + PTJ + Soros debate"
echo "  /rt-roundtable builders [topic]      Levels + Walling debate"
echo "  /rt-roundtable growth [topic]        Balfour + Chen + Collins + Verna + Currier debate"
echo "  /rt-roundtable all [topic]           Representative 6 across all 20 personas"
echo "  /rt-research [topic]                 Market research only"
echo "  /rt-thiel [question]                 Ask Peter Thiel"
echo "  /rt-buffett [question]               Ask Warren Buffett"
echo ""
echo "Example:"
echo "  /rt-roundtable investors 지금 주식 더 살 때인가"
echo ""
echo "Restart your agent client to pick up newly installed skills."
