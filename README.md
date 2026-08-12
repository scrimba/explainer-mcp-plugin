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

Cursor loads plugins from `~/.cursor/plugins/local` during development. Copy this repo there (Cursor's docs suggest symlinking, but as of Cursor 3.15.6 the loader rejects symlinks pointing outside `~/.cursor/plugins/local`, so a real copy is required):

```sh
mkdir -p ~/.cursor/plugins/local
rsync -a --exclude .git ./ ~/.cursor/plugins/local/scrimba-explain/
```

Then run **Developer: Reload Window** (a full restart is not needed — the plugin folder is rescanned on reload) and check **Customize** in the sidebar — the `scrimba-explain` plugin, its MCP server, and its skill should appear. Ask the agent for "an explainer of X on Scrimba" to try it.

After editing plugin files, re-run the `rsync` and reload again.

To remove: `rm -rf ~/.cursor/plugins/local/scrimba-explain` and reload.

## Formats in this repo

The repo is dual-format — the files are additive and don't conflict:

- **Agent Plugins standard** ([agent-plugins.org](https://agent-plugins.org), v1.0.0): root `plugin.json` + `mcp.json` + `skills/`. Loaded natively by Cursor, and by the standard's launch clients (ChatGPT, Codex, GitHub Copilot, Kiro, VS Code) through their own install flows.
- **Claude Code plugin**: `.claude-plugin/plugin.json` + `.mcp.json` + the same `skills/`. `.claude-plugin/marketplace.json` also makes the repo itself an installable marketplace: `/plugin marketplace add scrimba/<repo>` then `/plugin install scrimba-explain@scrimba`. Validate with `claude plugin validate .`.

## Distribution channels

Once the repo is public on GitHub:

| Channel | How |
|---------|-----|
| Cursor Marketplace | Submit at [cursor.com/marketplace/publish](https://cursor.com/marketplace/publish) (manual review; logo required) |
| Claude Code | Works immediately via `/plugin marketplace add scrimba/<repo>`; optionally submit to the community marketplace at [platform.claude.com/plugins/submit](https://platform.claude.com/plugins/submit) |
| Vercel `plugins` / skills.sh ecosystem | Works immediately via `npx plugins add scrimba/<repo>` (auto-installs into Claude Code, Cursor, Codex, Copilot, and 20+ agents); [skills.sh](https://skills.sh) leaderboard tracks installs |
| MCP registries (server-level) | The remote server itself can be listed on the official [MCP Registry](https://registry.modelcontextprotocol.io) (needs `server.json` + domain verification, a scrimba.com-side task) and community registries (Smithery, Glama, PulseMCP, mcp.so, cursor.directory) |
