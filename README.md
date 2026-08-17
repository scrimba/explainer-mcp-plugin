# Explain by Scrimba — Agent Plugin

Connects your agent to Explain by Scrimba: ask your agent to explain anything — a concept, a document, a process, a codebase, an architecture, a git branch or PR — and a narrated slideshow is generated with animations, diagrams, maths, images, code diffs, and more, rendered live at a shareable scrimba.com link.

Try prompts like:

- "Turn my study notes into a video"
- "Explain how OAuth works, with diagrams"
- "Make a video walkthrough of this PR for my colleague"

## Install

### $Claude Code

```
/plugin marketplace add scrimba/explainer-mcp-plugin
/plugin install scrimba-explain@scrimba
```

### Other agents
One command that installs into every agent tool it finds on your machine (Cursor, Codex, Copilot CLI, VS Code, …):

```sh
npx plugins add scrimba/explainer-mcp-plugin
```

### Cursor Marketplace

Coming; not yet listed. Until then use the command above, or clone this repo and add it via **Customize → Plugins → + Add → From Local Repo**.

### Plain MCP

No plugin needed: add `https://scrimba.com/mcp/explain` (Streamable HTTP, no auth) to any MCP client. Same tools, minus the bundled skill.

## What's in the plugin

A remote MCP server with four tools (`start_explainer_stream` / `append_explainer_chunk` / `finish_explainer_stream`, plus `create_playlist` for courses) and a skill that tells the agent when to use them. The repo carries both agent-plugins.org and Claude Code manifests, so it loads natively in either ecosystem.
