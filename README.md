# Scrimba Video Explainer — Agent Plugin

Connects your coding agent to Scrimba Video Explainer: allows you to ask your agent to explain any code, concept, architecture, git branch, pr, anything really, and an instant video is generated with narration, animations, diagrams, maths, and code, diffs, and more, rendered live at a shareable scrimba.com link.

## Install

**Claude Code**

```
/plugin marketplace add scrimba/explainer-mcp-plugin
/plugin install scrimba-explain@scrimba
```

**Other agents** — one command that installs into every agent tool it finds on your machine (Cursor, Codex, Copilot CLI, VS Code, …):

```sh
npx plugins add scrimba/explainer-mcp-plugin
```

**Cursor Marketplace** — coming; not yet listed. Until then use the command above, or clone this repo and add it via **Customize → Plugins → + Add → From Local Repo**.

**Plain MCP** — no plugin needed: add `https://scrimba.com/mcp/explain` (Streamable HTTP, no auth) to any MCP client. Same tools, minus the bundled skill.

## What's in the plugin

A remote MCP server with four tools (`start_explainer_stream` / `append_explainer_chunk` / `finish_explainer_stream`, plus `create_playlist` for courses) and a skill that tells the agent when to use them. The repo carries both agent-plugins.org and Claude Code manifests, so it loads natively in either ecosystem.
