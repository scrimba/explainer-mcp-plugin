---
name: setup-pr-explainer
description: Set up automatic Scrimba explainer videos for every pull request in a GitHub repository, by installing the scrimba/pr-explainer GitHub Action. Use when the user asks to set up PR explainers, install the Scrimba PR explainer workflow, or wants every PR explained automatically.
---

# Set up Scrimba PR Explainer

Installs the [scrimba/pr-explainer](https://github.com/scrimba/pr-explainer) GitHub Action in the current repository: every non-draft pull request gets a Scrimba explainer built automatically and posted as a PR comment.

Two things get set up:

1. `.github/workflows/scrimba-pr-explainer.yml` — copied from this skill's bundled template
2. The GitHub Actions secret `SCRIMBA_PR_EXPLAINER_CLAUDE_CODE_OAUTH_TOKEN` — minted via `claude setup-token`, stored via `gh secret set`

## Step 1: Preflight

Run:

```bash
gh repo view --json nameWithOwner -q .nameWithOwner
```

- If this fails because the directory is not a git repo, or has no GitHub remote: stop and tell the user this skill needs a git repository hosted on GitHub.
- If it fails because `gh` is missing or unauthenticated: stop and tell the user to install the GitHub CLI and run `gh auth login`.
- Otherwise, save the `owner/repo` value — the later steps need it.

## Step 2: Workflow file

Check whether `.github/workflows/scrimba-pr-explainer.yml` already exists.

- If it exists, tell the user and ask whether to overwrite it with the current template or leave it as is.
- Copy `files/scrimba-pr-explainer.yml` from this skill's base directory to `.github/workflows/scrimba-pr-explainer.yml` in the repo. Copy the file as-is — do not regenerate or edit it.

Explain briefly to the user: it triggers on PRs (skipping drafts and fork PRs), never blocks merging (`continue-on-error`), and supports manual runs via workflow_dispatch.

## Step 3: Token and secret

Check whether the secret already exists:

```bash
gh secret list --repo <owner/repo>
```

If `SCRIMBA_PR_EXPLAINER_CLAUDE_CODE_OAUTH_TOKEN` is already listed, tell the user and ask whether to re-mint it or keep the existing one.

To mint and store: first tell the user that a browser window will open and they need to click **Authorize** (one click, no code to copy). Then run the bundled script with a **10-minute timeout** (the script waits for the user's click):

```bash
bash <skill-base-dir>/scripts/mint-token-and-set-secret.sh <owner/repo>
```

The script runs `claude setup-token` under a pseudo-TTY, waits for authorization, extracts the token from the captured output, and pipes it directly into `gh secret set` — the token is never displayed to anyone. Never attempt to run `claude setup-token` directly yourself: it hangs without a TTY, and its output would expose the token in the conversation.

If the script fails, relay its error output to the user — it includes the manual fallback commands to run in their own terminal.

## Step 4: Commit and push

Offer to commit `.github/workflows/scrimba-pr-explainer.yml` and push. Do not commit or push without the user's confirmation.

After pushing, tell the user: open a non-draft PR (or mark a draft ready for review) and the explainer will appear as a PR comment. Manual runs are available under Actions → Scrimba PR Explainer → Run workflow.
