---
name: scrimba-explain
description: Create a Scrimba explainer — a rich visual walkthrough with narration, mermaid diagrams, LaTeX maths, and precisely composed code walkthroughs, rendered live on scrimba.com. Use when the user wants something explained visually, asks for an explainer or walkthrough, or would benefit from a presentation of a code diff, concept, flow, architecture, or learning topic. Also use for playlists or courses of lessons.
---

# Scrimba Explain

Scrimba Explain turns anything into a rich explainer with narration and visual aids, built live at a shareable scrimba.com URL. It shines for:

- Code diffs (side-by-side before/after)
- Concepts and learning topics
- Flows and architectures
- Code walkthroughs with precise highlighting
- Mermaid diagrams and LaTeX maths

## How to use it

The `scrimba-explain` MCP server (bundled with this plugin) provides the tools:

1. **One focused explainer**: call `start_explainer_stream`, then push content with `append_explainer_chunk`, and close with `finish_explainer_stream`. Scrimba renders the OPML you push live.
2. **A playlist or course of lessons**: use `create_playlist` — you plan the curriculum and author every lesson through the same OPML streaming flow.

## The `start_explainer_stream` result IS the authoring contract (~50 KB)

The return value of `start_explainer_stream` is not a status message. It contains the stream URL plus the **complete OPML authoring contract** — the format specification you must follow in every subsequent `append_explainer_chunk` call. Handle it accordingly:

- **It is ~50 KB.** Many agent harnesses truncate or elide tool results (limits like 2,000 bytes or 10,000 characters are common). Before calling the tool, make sure you can receive and retain a payload of that size.
- **If your environment truncates large tool results**, use whatever file/storage tools you have to save the full result to a file, then read that file to the end before pushing any chunk.
- **Never author chunks from a partial contract.** If you only saw a truncated result and cannot recover the rest, say so rather than guessing at the format.

## Important workflow notes

- As soon as `start_explainer_stream` returns the URL, give it to the user — they open it to watch the explainer get built live.
- The streaming and tokens are internal mechanics for you; don't narrate them to the user. Just say you're creating their Scrimba explainer.
