# Scrimba Explain — Agent Plugin

An [Agent Plugin](https://agent-plugins.org) that connects agents to **Scrimba Explain**, a remote MCP server that turns anything into a rich visual explainer — narration, mermaid diagrams, LaTeX maths, and precisely composed code walkthroughs — rendered live at a shareable scrimba.com URL.

The plugin follows the Agent Plugins open standard, so it loads unchanged in any compatible client, including [Cursor](https://cursor.com/docs/plugins).

## What's inside

| File | Purpose |
|------|---------|
| `plugin.json` | Plugin manifest (Agent Plugins 1.0.0 standard) |
| `mcp.json` | Declares the remote `scrimba-explain` MCP server at `https://scrimba.com/mcp/explain` (Streamable HTTP, no auth). The non-www URL is used because `www.scrimba.com` 301-redirects to the apex domain, and some MCP clients don't follow redirects on POST. |
| `skills/scrimba-explain/SKILL.md` | Skill that teaches the agent when and how to create explainers |
| `assets/logo.svg` / `assets/logo.png` | Plugin logo — a copy of Scrimba's official brand icon, canonically served at `https://scrimba.com/static/brand/icon.svg` (use that URL wherever a hosted logo link is asked for, e.g. Cursor's marketplace submission form). The PNG is a 512×512 render for repo-relative references. Note: the Agent Plugins 1.0.0 `plugin.json` schema has no `logo` field (it's a closed schema), so the logo is referenced at marketplace-submission time rather than from the manifest. |

## Tools provided by the MCP server

- `start_explainer_stream` / `append_explainer_chunk` / `finish_explainer_stream` — author one focused explainer, streamed as OPML and rendered live
- `create_playlist` — plan a curriculum and author a playlist or course of lessons

## Test locally in Cursor

Open **Customize** in the sidebar → **Plugins** → **+ Add** → **From Local Repo** and pick this folder. Ask the agent for "an explainer of X on Scrimba" to try it.

## Formats in this repo

The repo is dual-format — the files are additive and don't conflict:

- **Agent Plugins standard** ([agent-plugins.org](https://agent-plugins.org), v1.0.0): root `plugin.json` + `mcp.json` + `skills/`. Loaded natively by Cursor, and by the standard's launch clients (ChatGPT, Codex, GitHub Copilot, Kiro, VS Code) through their own install flows.
- **Claude Code plugin**: `.claude-plugin/plugin.json` + `.mcp.json` + the same `skills/`. `.claude-plugin/marketplace.json` also makes the repo itself an installable marketplace. Validate with `claude plugin validate .`.

## Install

**Cursor** — from the Cursor Marketplace, or **Customize → Plugins → + Add** and point it at this repo.

**Claude Code**:

```
/plugin marketplace add scrimba/explainer-mcp-plugin
/plugin install scrimba-explain@scrimba
```

**Other agents, one command** — Vercel's [`plugins` CLI](https://www.npmjs.com/package/plugins) reads this repo, detects which agent tools are installed on your machine (Claude Code, Cursor, Codex, Grok Build, Kimi Code, GitHub Copilot CLI, VS Code), and installs the plugin into each one in its native format:

```sh
npx plugins add scrimba/explainer-mcp-plugin
```

**Any MCP client without plugin support** — add the server directly: `https://scrimba.com/mcp/explain` (Streamable HTTP, no auth).
