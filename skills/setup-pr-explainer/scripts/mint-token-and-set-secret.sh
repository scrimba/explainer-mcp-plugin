#!/usr/bin/env bash
# Mints a Claude Code OAuth token and stores it as a GitHub Actions secret,
# without the token ever being displayed or pasted manually.
#
# `claude setup-token` requires a TTY, so we run it under script(1) to get a
# pseudo-TTY. It opens a browser for the user to click Authorize; the CLI
# polls and prints the token when authorization completes. We capture the
# transcript, extract the token, and pipe it straight into `gh secret set`.
#
# Usage: mint-token-and-set-secret.sh <owner/repo>
set -euo pipefail

REPO="${1:?usage: mint-token-and-set-secret.sh <owner/repo>}"
SECRET_NAME="SCRIMBA_PR_EXPLAINER_CLAUDE_CODE_OAUTH_TOKEN"

command -v claude >/dev/null 2>&1 || { echo "ERROR: claude CLI not found on PATH." >&2; exit 1; }
command -v gh >/dev/null 2>&1 || { echo "ERROR: gh CLI not found on PATH." >&2; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "ERROR: gh is not authenticated. Run: gh auth login" >&2; exit 1; }

TRANSCRIPT="$(mktemp)"
trap 'rm -f "$TRANSCRIPT"' EXIT

echo "Opening browser for Claude authorization — click Authorize when prompted..."

# Wide pty so the token is never line-wrapped in the transcript.
# script(1) syntax differs between BSD/macOS and GNU/Linux.
if [ "$(uname -s)" = "Darwin" ]; then
  script -q "$TRANSCRIPT" sh -c 'stty cols 4000 2>/dev/null; claude setup-token' >/dev/null 2>&1 || true
else
  script -q -e -c 'stty cols 4000 2>/dev/null; claude setup-token' "$TRANSCRIPT" >/dev/null 2>&1 || true
fi

# Strip ANSI escape sequences (CSI and OSC), then extract the token.
CLEAN="$(sed -e 's/\x1b\[[0-9;?]*[a-zA-Z]//g' -e 's/\x1b\][^\x07]*\x07//g' "$TRANSCRIPT" | tr -d '\r')"
TOKEN="$(printf '%s\n' "$CLEAN" | grep -oE 'sk-ant-oat[0-9]+-[A-Za-z0-9_-]{40,}' | tail -1 || true)"

if [ -z "$TOKEN" ]; then
  echo "ERROR: no token found — authorization may not have completed." >&2
  AUTH_URL="$(printf '%s\n' "$CLEAN" | grep -oE 'https://claude\.com/[^ ]*oauth[^ ]*' | head -1 || true)"
  if [ -n "$AUTH_URL" ]; then
    echo "The authorization URL was: $AUTH_URL" >&2
    echo "Open it, authorize, then re-run this script." >&2
  fi
  echo "Manual fallback (run in your own terminal):" >&2
  echo "  claude setup-token" >&2
  echo "  gh secret set $SECRET_NAME --repo $REPO" >&2
  exit 1
fi

printf '%s' "$TOKEN" | gh secret set "$SECRET_NAME" --repo "$REPO"
echo "OK: secret $SECRET_NAME set on $REPO (token never displayed)."
