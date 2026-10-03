#!/usr/bin/env bash
# hotelbyte skill — connection doctor.
# Usage: bash scripts/doctor.sh [--env uat|prod]
# Emits one verdict: live | degraded | error (+ per-check detail).
set -uo pipefail

ENV="uat"
if [ "${1:-}" = "--env" ] && [ -n "${2:-}" ]; then ENV="$2"; fi
case "$ENV" in uat|prod) ;; *) ENV=uat;; esac

say() { printf '%s\n' "$*"; }

# 1) hbcli present?
if ! command -v hbcli >/dev/null 2>&1; then
  say "verdict: error"
  say "check hbcli: NOT INSTALLED"
  say "fix: run the one-liner from https://hotelbyte.com/products/ai-distribution (hbcli mcp setup)"
  exit 2
fi
say "check hbcli: $(hbcli --version 2>/dev/null || echo unknown-version)"

# 2) credentials + live initialize probe through the same path agents use.
PROBE=$(printf '%s\n%s\n%s\n' \
  '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-06-18","capabilities":{},"clientInfo":{"name":"skill-doctor","version":"1.0"}}}' \
  '{"jsonrpc":"2.0","method":"notifications/initialized"}' \
  '{"jsonrpc":"2.0","id":2,"method":"tools/list"}' \
  | timeout 30 hbcli mcp serve --env "$ENV" 2>/dev/null)

if printf '%s' "$PROBE" | grep -q '"hotel.list"'; then
  say "check credentials: OK"
  say "check /mcp endpoint ($ENV): reachable, tools listed"
  say "verdict: live"
  exit 0
fi

# credentials exist but probe failed → degraded vs error
ERR=$(printf '%s' "$PROBE" | grep -o '"text":"[^"]*"' | head -1)
if printf '%s' "$PROBE" | grep -q 'authentication denied\|invalid token\|401'; then
  say "check credentials: EXPIRED/DENIED"
  say "fix: hbcli auth set-credentials --app-key ... --app-secret ...   (or portal: hbcli auth login)"
else
  say "check /mcp endpoint ($ENV): unreachable"
  say "detail: ${ERR:-no response}"
fi
say "verdict: degraded"
exit 1
