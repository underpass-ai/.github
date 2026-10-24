#!/usr/bin/env bash
# Apply the organisation and repository metadata proposed in the profile audit.
#
# Prints every command by default and changes nothing. Pass --apply to run them
# (needs `gh` signed in with admin rights on underpass-ai; the org description
# also needs the admin:org scope). Every command sets a value, so running it
# twice leaves the same result.
#
# Not covered, because they are the owner's decisions or have no API:
#   - pinned repositories (set them in the web UI; the order is in the PR);
#   - licences for plugins, axlr-repair-lab, aws-side-cluster, underpass-vllms,
#     .github and underpass-kmp-operator-trainer;
#   - the future of the stale `plugins` marketplace.

set -euo pipefail

ORG=underpass-ai
APPLY=0

case "${1:-}" in
  --apply) APPLY=1 ;;
  "" | --dry-run) ;;
  *) echo "usage: $0 [--dry-run | --apply]" >&2; exit 2 ;;
esac

run() {
  printf '+'
  printf ' %q' "$@"
  printf '\n'
  if [ "$APPLY" -eq 1 ]; then
    "$@"
  fi
}

# Replace a repository's topics with exactly the names given.
topics() {
  local repo=$1
  shift
  local args=()
  local name
  for name in "$@"; do
    args+=(-f "names[]=$name")
  done
  run gh api --silent -X PUT "repos/$ORG/$repo/topics" "${args[@]}"
}

COMMON=(ai-agents agent-infrastructure underpass-ai)

# Descriptions and homepages
run gh repo edit "$ORG/kmp" \
  --description "Local-first agent memory that preserves what happened, when and why"
run gh repo edit "$ORG/AXLR" \
  --description "AXLR: Underpass's agentic execution runtime. A console, one-command runs and an mTLS HTTP/gRPC/MCP service, with a policy, budget and correlation ids per execution; KMP memory and MADE procedures over MCP." \
  --homepage "https://axlr.underpassai.com"
run gh repo edit "$ORG/axlr-bots" \
  --description "AXLR Bots: persistent, governed bots on your own hosts. A control plane and node agents over mutual TLS; AXLR runs each execution under the bot's policy." \
  --homepage "https://underpassai.com"
run gh repo edit "$ORG/axlr-registry" \
  --homepage "https://axlr.underpassai.com/registry/"

# Topics, in the order KMP, MADE, AXLR, AXLR Bots, then the AXLR satellites
topics kmp "${COMMON[@]}" agent-memory kernel-memory-protocol memory-system \
  context-engineering mcp mcp-server rust sqlite claude-code codex llm
topics made "${COMMON[@]}" multi-agent-systems human-in-the-loop workflow-engine \
  audit-log mcp mcp-server rust sqlite claude-code codex llm
topics AXLR "${COMMON[@]}" axlr agent-runtime go mcp mcp-client grpc mtls tui llm
topics axlr-bots "${COMMON[@]}" axlr bots control-plane go mtls systemd
topics axlr-site "${COMMON[@]}" axlr website zola
topics axlr-registry "${COMMON[@]}" axlr tool-registry rust aws-lambda serverless
topics plugins "${COMMON[@]}" claude-code codex mcp plugin-marketplace

# Organisation, last: it needs a token with the admin:org scope
# (gh auth refresh -h github.com -s admin:org), and a refusal here leaves the
# repository changes above already applied.
run gh api --silent -X PATCH "orgs/$ORG" \
  -f description="Memory, coordination, and execution infrastructure for reliable AI agents. KMP, MADE, AXLR, and AXLR Bots."

if [ "$APPLY" -eq 0 ]; then
  echo "Dry run: nothing changed. Run '$0 --apply' to apply."
fi
