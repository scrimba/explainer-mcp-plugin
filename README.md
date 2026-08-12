# Scrimba Explain — Agent Plugin

An [Agent Plugin](https://agent-plugins.org) that connects agents to **Scrimba Explain**, a remote MCP server that turns anything into a rich visual explainer — narration, mermaid diagrams, LaTeX maths, and precisely composed code walkthroughs — rendered live at a shareable scrimba.com URL.

The plugin follows the Agent Plugins open standard, so it loads unchanged in any compatible client, including [Cursor](https://cursor.com/docs/plugins).

## What's inside

| File | Purpose |
|------|---------|
| `plugin.json` | Plugin manifest (Agent Plugins 1.0.0 standard) |
| `mcp.json` | Declares the remote `scrimba-explain` MCP server at `https://scrimba.com/mcp/explain` (Streamable HTTP, no auth). The non-www URL is used because `www.scrimba.com` 301-redirects to the apex domain, and some MCP clients don't follow redirects on POST. |
| `skills/scrimba-explain/SKILL.md` | Skill that teaches the agent when and how to create explainers |
| `assets/logo.svg` / `assets/logo.png` | Plugin logo — the Scrimba glyph (brand colors from `scrimba-next/assets/logo.png`) on a black rounded square, matching the official avatar. The PNG is a 512×512 render for the marketplace. Note: the Agent Plugins 1.0.0 `plugin.json` schema has no `logo` field (it's a closed schema), so the logo is referenced at marketplace-submission time rather than from the manifest. |

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

## Publish

When ready, submit the repo at [cursor.com/marketplace/publish](https://cursor.com/marketplace/publish), or distribute it as a Git repository through a team marketplace.
