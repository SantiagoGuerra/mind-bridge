#!/usr/bin/env bash
# mind-bridge release gate
# Verifies the repo is ready to publish a new version.
# - Runs scripts/lint.sh (must pass with exit 0).
# - Verifies CHANGELOG.md has an entry for the expected version (default: argv[1] or
#   inferred as the topmost "## vX.Y.Z" entry).
# - Prints a clear summary and exits non-zero on any failure.
# - Read-only. Does not publish, tag, or push.

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
EXPECTED_VERSION="${1:-}"

fails=0
warns=0

pass()    { echo "  ✓ $1"; }
fail()    { echo "  ✗ $1"; fails=$((fails+1)); }
warn()    { echo "  ⚠ $1"; warns=$((warns+1)); }
section() { echo ""; echo "── $1 ──"; }

echo "mind-bridge release gate"
echo "SKILL_ROOT: $SKILL_ROOT"

# ── Lint ──
section "Lint"
if bash "$SCRIPT_DIR/lint.sh" > /tmp/mind-bridge-lint.out 2>&1; then
  pass "scripts/lint.sh passed"
  tail -1 /tmp/mind-bridge-lint.out | sed 's/^/      /'
else
  fail "scripts/lint.sh failed (exit non-zero)"
  echo "      Last 20 lines of lint output:"
  tail -20 /tmp/mind-bridge-lint.out | sed 's/^/        /'
fi

# ── CHANGELOG version entry ──
section "CHANGELOG version entry"
changelog="$SKILL_ROOT/CHANGELOG.md"
if [ ! -f "$changelog" ]; then
  fail "CHANGELOG.md not found at $changelog"
else
  if [ -n "$EXPECTED_VERSION" ]; then
    target="$EXPECTED_VERSION"
    if grep -qE "^## v?${target//./\\.}[[:space:]]" "$changelog"; then
      pass "CHANGELOG.md contains entry for $target"
    else
      fail "CHANGELOG.md missing entry for $target (expected line starting with '## v$target' or '## $target')"
    fi
  else
    topmost=$(grep -E "^## v[0-9]+\.[0-9]+\.[0-9]+" "$changelog" | head -1 | sed -E 's/^## (v[0-9]+\.[0-9]+\.[0-9]+).*/\1/')
    if [ -n "$topmost" ]; then
      pass "Topmost version entry: $topmost"
      target="$topmost"
    else
      fail "No '## vX.Y.Z' version entry found in CHANGELOG.md"
      target=""
    fi
  fi

  if [ -n "${target:-}" ]; then
    body=$(awk -v v="$target" '
      $0 ~ "^## "v"([[:space:]]|$)" { found=1; next }
      found && /^## / { exit }
      found { print }
    ' "$changelog")
    body_lines=$(echo "$body" | grep -cE '^[^[:space:]]' || true)
    if [ "$body_lines" -ge 3 ]; then
      pass "Entry body has $body_lines non-blank content lines"
    else
      warn "Entry body is only $body_lines non-blank lines — consider expanding"
    fi
  fi
fi

# ── SKILL.md sanity (delegated to lint, but reconfirm headline values) ──
section "SKILL.md headline"
if [ -f "$SKILL_ROOT/SKILL.md" ]; then
  lines=$(wc -l < "$SKILL_ROOT/SKILL.md" | tr -d ' ')
  desc_len=$(python3 -c "
import re, sys
try:
    with open('$SKILL_ROOT/SKILL.md') as f: c = f.read()
    m = re.search(r'^description:\s*\"(.*?)\"', c, re.MULTILINE | re.DOTALL)
    print(len(m.group(1)) if m else -1)
except Exception as e:
    print(-1, file=sys.stderr); print(-1)
")
  pass "SKILL.md lines: $lines (recommended < 500)"
  pass "description chars: $desc_len (hard cap 1024, soft 850)"
else
  fail "SKILL.md not found"
fi

# ── Repo state (advisory) ──
section "Repo state (advisory)"
if command -v git >/dev/null 2>&1 && git -C "$SKILL_ROOT" rev-parse --git-dir >/dev/null 2>&1; then
  if git -C "$SKILL_ROOT" diff --quiet && git -C "$SKILL_ROOT" diff --cached --quiet; then
    pass "Working tree clean"
  else
    warn "Uncommitted changes present — review before tagging release"
  fi
else
  warn "Not a git repository — release gate cannot verify clean state"
fi

# ── Summary ──
echo ""
echo "────────────────────────────"
if [ "$fails" -eq 0 ]; then
  echo "RELEASE GATE: PASS ($warns warnings)"
  echo ""
  echo "Next steps (manual):"
  echo "  1. Review uncommitted changes (if any)."
  echo "  2. Tag the release: git tag -a v<X.Y.Z> -m 'mind-bridge v<X.Y.Z>'"
  echo "  3. Publish per your distribution path."
  exit 0
else
  echo "RELEASE GATE: FAIL ($fails errors, $warns warnings)"
  echo ""
  echo "Release is BLOCKED until the errors above are resolved."
  exit 1
fi
