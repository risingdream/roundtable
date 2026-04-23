# Roundtable

AI advisory roundtable for Claude Code and Codex CLI. Twenty legendary thinkers debate your strategy — backed by real-time market research.

## What is this?

A set of agent skills that let you consult AI personas of world-class strategists, then run structured debates between them on any topic.

**The flow:**
```
Your question → Market Research (web search) → N Personas debate → Structured synthesis
```

## Personas

### VC & Strategy

| Skill | Persona | One-liner |
|-------|---------|-----------|
| `/rt-thiel` | Peter Thiel | Contrarian visionary — "What secret are you not seeing?" |
| `/rt-horowitz` | Ben Horowitz | Wartime operator — "What's the hard thing nobody wants to say?" |
| `/rt-andreessen` | Marc Andreessen | Techno-optimist — "Software is eating the world — why aren't you building faster?" |
| `/rt-graham` | Paul Graham | Essayist-founder — "Who are your users, and do they love it?" |
| `/rt-gurley` | Bill Gurley | Marketplace economist — "Do the unit economics actually work?" |

### Public-Market Investors

| Skill | Persona | One-liner |
|-------|---------|-----------|
| `/rt-buffett` | Warren Buffett | Value investor — "Think in decades; what's the moat?" |
| `/rt-munger` | Charlie Munger | Inversion master — "How will this fail?" |
| `/rt-marks` | Howard Marks | Cycle reader — "Where are we in the cycle?" |
| `/rt-lynch` | Peter Lynch | Growth-at-reasonable-price — "Know what you own, and why." |
| `/rt-dalio` | Ray Dalio | Systematic macro — "Which pattern in history is this?" |
| `/rt-taleb` | Nassim Taleb | Risk philosopher — "Where is the hidden fragility?" |
| `/rt-ptj` | Paul Tudor Jones | Macro momentum trader — "Where's the 5:1 setup?" |
| `/rt-soros` | George Soros | Reflexivity theorist — "What flawed core belief is driving this?" |

### Builders & Bootstrappers

| Skill | Persona | One-liner |
|-------|---------|-----------|
| `/rt-levels` | Pieter Levels | Solo builder — "Just ship it. What's your MRR?" |
| `/rt-walling` | Rob Walling | SaaS strategist — "Where are you on the staircase?" |

### Growth & Flywheel

| Skill | Persona | One-liner |
|-------|---------|-----------|
| `/rt-balfour` | Brian Balfour | Growth systems architect — "Which fit is broken?" |
| `/rt-chen` | Andrew Chen | Network effects expert — "What's the atomic network?" |
| `/rt-collins` | Jim Collins | Flywheel originator — "Are you building momentum or in a doom loop?" |
| `/rt-verna` | Elena Verna | PLG operator — "Show me your retention curve" |
| `/rt-currier` | James Currier | Defensibility taxonomist — "What type of network effect is this?" |

### Core

| Skill | What it does |
|-------|-------------|
| `/rt-research` | Web-based market research. Produces a structured brief in `docs/research/` |
| `/rt-roundtable` | Orchestrates multi-persona debates with research → discussion → synthesis |

## Install

### One-liners

```bash
cd your-project
curl -fsSL https://raw.githubusercontent.com/risingdream/roundtable/main/install.sh | bash
```

Codex CLI:

```bash
curl -fsSL https://raw.githubusercontent.com/risingdream/roundtable/main/install.sh | bash -s -- --codex
```

### Multi-platform

Built on the [Agent Skills open standard](https://agentskills.io). Works with Claude Code, Codex CLI, OpenClaw, and Hermes Agent.

```bash
./install.sh              # Claude Code  → .claude/skills/
./install.sh --codex      # Codex CLI    → ${CODEX_HOME:-~/.codex}/skills/
./install.sh --openclaw   # OpenClaw     → skills/
./install.sh --hermes     # Hermes Agent → ~/.hermes/skills/
./install.sh --all        # All platforms
./install.sh --dest DIR   # Custom skills directory
```

### Manual

```bash
git clone https://github.com/risingdream/roundtable.git
cp -r roundtable/skills/**/rt-* .claude/skills/
# Codex: cp -r roundtable/skills/**/rt-* "${CODEX_HOME:-$HOME/.codex}/skills/"
```

### Selective install

Only want the bootstrapping personas?

```bash
git clone https://github.com/risingdream/roundtable.git
cp -r roundtable/skills/builders/rt-* .claude/skills/
cp -r roundtable/skills/core/rt-* .claude/skills/
```

Only want the public-market investors?

```bash
git clone https://github.com/risingdream/roundtable.git
cp -r roundtable/skills/investors/rt-* .claude/skills/
cp -r roundtable/skills/core/rt-* .claude/skills/
```

## Usage

### Individual consultation

```
/rt-thiel Should I take VC funding for my AI startup?
/rt-buffett Is $TICKER a good long-term compounder at this price?
/rt-marks Where are we in the cycle right now?
/rt-ptj What's the 5:1 setup in this chart?
/rt-levels I want to build a SaaS but I'm overthinking the tech stack
/rt-munger Evaluate this acquisition target for me
```

### Full roundtable debate

Use group shortcuts or individual names to pick participants:

| Shortcut | Personas | Description |
|----------|----------|-------------|
| `vc` | thiel, horowitz, andreessen, graham, gurley | VC & strategy mindsets |
| `investors` | buffett, munger, marks, lynch, dalio, taleb, ptj, soros | Public-market investors & macro traders |
| `builders` | levels, walling | Bootstrapping & indie hacking |
| `growth` | balfour, chen, collins, verna, currier | Flywheel, PLG, network effects |
| `all` | all 20 | Everyone |

```
/rt-roundtable vc AI 버블인가                             → 4 vc strategists
/rt-roundtable investors 지금 주식 더 살 때인가             → 6 public-market investors
/rt-roundtable builders 사이드프로젝트 사업화              → levels + walling
/rt-roundtable vc levels AI 에이전트 시장 진입              → 4 vc + levels
/rt-roundtable buffett munger 우량주 집중투자 vs 분산       → 2 cross-persona
/rt-roundtable marks soros 지금 시장 사이클 어디인가         → 2 macro voices
/rt-roundtable all 한국 B2B SaaS 시장 진출                 → representative 6 across all 20 personas
/rt-roundtable thiel walling SaaS 확장 vs 채널 다변화       → individual pick
```

Groups and individual names can be mixed freely. Default (no names) = `vc`.

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

1. Create `rt-yourpersona/SKILL.md` in your agent client's skills directory (for example `.claude/skills/rt-yourpersona/SKILL.md` or `${CODEX_HOME:-$HOME/.codex}/skills/rt-yourpersona/SKILL.md`):

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
├── vc/                 # VC & strategy mindsets
│   ├── rt-thiel/
│   ├── rt-horowitz/
│   ├── rt-andreessen/
│   ├── rt-graham/
│   └── rt-gurley/
├── investors/          # Public-market investors & macro traders
│   ├── rt-buffett/
│   ├── rt-munger/
│   ├── rt-marks/
│   ├── rt-lynch/
│   ├── rt-dalio/
│   ├── rt-taleb/
│   ├── rt-ptj/
│   └── rt-soros/
├── builders/           # Bootstrapping & indie hacking
│   ├── rt-levels/
│   └── rt-walling/
├── growth/             # Flywheel, PLG, network effects
│   ├── rt-balfour/
│   ├── rt-chen/
│   ├── rt-collins/
│   ├── rt-verna/
│   └── rt-currier/
└── core/               # Infrastructure
    ├── rt-research/    # Market research agent
    └── rt-roundtable/  # Debate orchestrator
```

## Requirements

- Claude Code, Codex CLI, or another agent client that supports agent skills
- Web search access for `rt-research` and live market briefs
- Restart your agent client after installing new skills

## License

MIT
