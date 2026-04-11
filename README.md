# Roundtable

AI advisory roundtable for Claude Code. Six legendary thinkers debate your strategy — backed by real-time market research.

## What is this?

A set of Claude Code skills that let you consult AI personas of world-class strategists, then run structured debates between them on any topic.

**The flow:**
```
Your question → Market Research (web search) → 6 Personas debate → Structured synthesis
```

## Personas

### Investors & Strategists

| Skill | Persona | One-liner |
|-------|---------|-----------|
| `/rt-thiel` | Peter Thiel | Contrarian visionary — "What secret are you not seeing?" |
| `/rt-munger` | Charlie Munger | Inversion master — "How will this fail?" |
| `/rt-taleb` | Nassim Taleb | Risk philosopher — "Where is the hidden fragility?" |
| `/rt-horowitz` | Ben Horowitz | Wartime operator — "What's the hard thing nobody wants to say?" |

### Builders & Bootstrappers

| Skill | Persona | One-liner |
|-------|---------|-----------|
| `/rt-levels` | Pieter Levels | Solo builder — "Just ship it. What's your MRR?" |
| `/rt-walling` | Rob Walling | SaaS strategist — "Where are you on the staircase?" |

### Core

| Skill | What it does |
|-------|-------------|
| `/rt-research` | Web-based market research. Produces a structured brief in `docs/research/` |
| `/rt-roundtable` | Orchestrates multi-persona debates with research → discussion → synthesis |

## Install

### One-liner (recommended)

```bash
cd your-project
curl -fsSL https://raw.githubusercontent.com/risingdream/roundtable/main/install.sh | bash
```

### Multi-platform

Built on the [Agent Skills open standard](https://agentskills.io). Works with Claude Code, Codex CLI, OpenClaw, and Hermes Agent.

```bash
./install.sh              # Claude Code  → .claude/skills/
./install.sh --codex      # Codex CLI    → .codex/skills/
./install.sh --openclaw   # OpenClaw     → skills/
./install.sh --hermes     # Hermes Agent → ~/.hermes/skills/
./install.sh --all        # All platforms
```

### Manual

```bash
git clone https://github.com/risingdream/roundtable.git
cp -r roundtable/skills/**/rt-* .claude/skills/
```

### Selective install

Only want the bootstrapping personas?

```bash
git clone https://github.com/risingdream/roundtable.git
cp -r roundtable/skills/builders/rt-* .claude/skills/
cp -r roundtable/skills/core/rt-* .claude/skills/
```

## Usage

### Individual consultation

```
/rt-thiel Should I take VC funding for my AI startup?
/rt-levels I want to build a SaaS but I'm overthinking the tech stack
/rt-munger Evaluate this acquisition target for me
```

### Full roundtable debate

Use group shortcuts or individual names to pick participants:

| Shortcut | Personas | Description |
|----------|----------|-------------|
| `investors` | thiel, munger, taleb, horowitz | Investment & strategy mindsets |
| `builders` | levels, walling | Bootstrapping & indie hacking |
| `all` | all 6 | Everyone |

```
/rt-roundtable investors AI 버블인가                     → 4 investors
/rt-roundtable builders 사이드프로젝트 사업화               → levels + walling
/rt-roundtable investors levels 케어 사업 적자 전략        → 4 investors + levels
/rt-roundtable all 한국 세무 SaaS 시장 진입                → 6인 전원
/rt-roundtable thiel walling 법인환급 확장 전략             → individual pick
```

Groups and individual names can be mixed freely. Default (no names) = `investors`.

The roundtable runs 4 rounds:
1. **Research** — Web search for current market data, saved to `docs/research/`
2. **Round 1** — Each persona gives their independent take (in parallel)
3. **Round 2** — Cross-debate: personas challenge each other
4. **Round 3** — Moderator synthesizes convergence, divergence, and hidden insights

### Research only

```
/rt-research Korean tax SaaS market
```

Produces a structured brief saved to `docs/research/[topic].md`.

## Customization

### Add your own persona

1. Create `.claude/skills/rt-yourpersona/SKILL.md`:

```markdown
---
name: rt-yourpersona
description: "One-line description"
argument-hint: "[topic or question]"
allowed-tools: WebSearch WebFetch Read Grep Bash
---

# You Are [Name].

[Persona definition...]

## Handling the User's Input

The user has asked you about: **$ARGUMENTS**

[Instructions for how the persona should approach questions...]
```

2. Add the persona to `rt-roundtable/SKILL.md` — both the Available Personas table and the group shortcuts section if applicable.

## Repo structure

```
skills/
├── investors/          # Investment & strategy mindsets
│   ├── rt-thiel/
│   ├── rt-munger/
│   ├── rt-taleb/
│   └── rt-horowitz/
├── builders/           # Bootstrapping & indie hacking
│   ├── rt-levels/
│   └── rt-walling/
└── core/               # Infrastructure
    ├── rt-research/    # Market research agent
    └── rt-roundtable/  # Debate orchestrator
```

## Requirements

- [Claude Code](https://claude.ai/code) CLI or Desktop app
- Claude API key (skills run on your own API key — no additional cost from this project)

## License

MIT
