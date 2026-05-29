#!/usr/bin/env bash
# mind-bridge lint — v0.5 hardening
#
# Deterministic sanity-check runner for v0.4.1 + v0.5 invariants.
# Read-only: never mutates skill files.
#
# Exit 0 if all hard checks pass (warnings are OK).
# Exit 1 if any hard check fails.

set -uo pipefail

SKILL_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

fails=0
warns=0

# ── helpers ──────────────────────────────────────────────────────────────────

pass()    { echo "  ✓ $1"; }
fail()    { echo "  ✗ $1"; fails=$((fails+1)); }
warn()    { echo "  ⚠ $1"; warns=$((warns+1)); }
section() { echo ""; echo "── $1 ──"; }

# grep_fail PATTERN LABEL PATHS...
# Fails if any *.md matches PATTERN under PATHS (CHANGELOG.md excluded by default).
grep_fail() {
  local pattern="$1"; local label="$2"; shift 2
  local matches
  matches=$(grep -rnE "$pattern" --include='*.md' --exclude='CHANGELOG.md' "$@" 2>/dev/null)
  if [ -z "$matches" ]; then
    pass "$label"
  else
    fail "$label"
    echo "$matches" | sed 's/^/      /'
  fi
}

# grep_fail_strict PATTERN LABEL PATHS...
# Like grep_fail but does NOT exclude any file (caller scopes via PATHS).
grep_fail_strict() {
  local pattern="$1"; local label="$2"; shift 2
  local matches
  matches=$(grep -rnE "$pattern" --include='*.md' "$@" 2>/dev/null)
  if [ -z "$matches" ]; then
    pass "$label"
  else
    fail "$label"
    echo "$matches" | sed 's/^/      /'
  fi
}

# ── start ────────────────────────────────────────────────────────────────────

echo "mind-bridge lint"
echo "SKILL_ROOT: $SKILL_ROOT"

# ── SKILL.md metadata ────────────────────────────────────────────────────────
section "SKILL.md metadata"

if [ ! -f "$SKILL_ROOT/SKILL.md" ]; then
  fail "SKILL.md exists"
else
  pass "SKILL.md exists"

  skill_lines=$(wc -l < "$SKILL_ROOT/SKILL.md" | tr -d ' ')
  if [ "$skill_lines" -lt 500 ]; then
    pass "SKILL.md line count < 500 (actual: $skill_lines)"
  else
    fail "SKILL.md line count >= 500 (actual: $skill_lines)"
  fi

  desc_len=$(python3 -c "
import re
with open('$SKILL_ROOT/SKILL.md') as f: c = f.read()
m = re.search(r'^description:\s*\"(.*?)\"', c, re.MULTILINE | re.DOTALL)
print(len(m.group(1)) if m else -1)
" 2>/dev/null)

  if [ "$desc_len" = "-1" ]; then
    fail "description field could not be parsed"
  else
    if [ "$desc_len" -lt 1024 ]; then
      pass "description char count < 1024 (actual: $desc_len)"
    else
      fail "description char count >= 1024 (actual: $desc_len)"
    fi
    if [ "$desc_len" -lt 850 ]; then
      pass "description char count < 850 (soft target met: $desc_len)"
    else
      warn "description char count >= 850 (over soft target; actual: $desc_len)"
    fi
  fi
fi

# ── Canonical files exist ────────────────────────────────────────────────────
section "Canonical files exist"

for rel in \
  "templates/source-coverage-gates.md" \
  "templates/library-entry.md" \
  "templates/concept-package.md" \
  "templates/validation.md"
do
  if [ -f "$SKILL_ROOT/$rel" ]; then
    pass "$rel"
  else
    fail "$rel missing"
  fi
done

# ── v0.4.1 invariants — no stale terminology ─────────────────────────────────
section "v0.4.1 invariants — no stale terminology"

# Modo A-E: exclude CHANGELOG (history) and README (versioning prose). Should
# not appear anywhere else after the v0.4 Execution-modifier rename.
modo_matches=$(grep -rnE 'Modo [A-E]\b' \
  --include='*.md' \
  --exclude='CHANGELOG.md' \
  --exclude='README.md' \
  "$SKILL_ROOT" 2>/dev/null)
if [ -z "$modo_matches" ]; then
  pass 'no "Modo A/B/C/D/E" outside CHANGELOG/README'
else
  fail 'no "Modo A/B/C/D/E" outside CHANGELOG/README'
  echo "$modo_matches" | sed 's/^/      /'
fi

# README has a legitimate historical-note mention (versioning section names
# the historical "Work modes" inside a rename callout); exclude README too.
wm_matches=$(grep -rnE 'Work modes' \
  --include='*.md' \
  --exclude='CHANGELOG.md' \
  --exclude='README.md' \
  "$SKILL_ROOT" 2>/dev/null)
if [ -z "$wm_matches" ]; then
  pass 'no "Work modes" outside CHANGELOG/README'
else
  fail 'no "Work modes" outside CHANGELOG/README'
  echo "$wm_matches" | sed 's/^/      /'
fi
grep_fail 'VALIDACIÓN INSTALACIÓN' 'no "VALIDACIÓN INSTALACIÓN"' "$SKILL_ROOT"
grep_fail 'instalación sólida' 'no "instalación sólida"' "$SKILL_ROOT"

# "explicar sólido" appears legitimately inside user-prompt quoted strings in
# tests/manual-evals.md and README.md. Scope to modes/, templates/, examples/.
grep_fail 'explicar sólido' 'no schema value "explicar sólido" in modes/templates/examples' \
  "$SKILL_ROOT/modes" "$SKILL_ROOT/templates" "$SKILL_ROOT/examples"

# ── v0.4.1 invariants — collaboration dominance metric ───────────────────────
section "v0.4.1 invariants — collaboration dominance metric"

# Only group.md, duo.md, collaboration-modes.md. The engineering-team example
# (examples/group-package-session.md) uses "% del tiempo" as a real metric.
grep_fail_strict '% del tiempo' \
  'no airtime wording in collaboration files' \
  "$SKILL_ROOT/modes/group.md" \
  "$SKILL_ROOT/modes/duo.md" \
  "$SKILL_ROOT/templates/collaboration-modes.md"

# ── v0.4.1 invariants — canonical spellings ──────────────────────────────────
section "v0.4.1 invariants — canonical spellings"

# Canonical is "ready-for-validation" (hyphenated). Catch unhyphenated value
# in schema-like contexts: backticks or after a colon.
grep_fail '(`|: )ready for validation\b' \
  'use kebab "ready-for-validation" (not "ready for validation")' \
  "$SKILL_ROOT/modes" "$SKILL_ROOT/templates" "$SKILL_ROOT/examples"

# `pendiente` as a stored value (vs prose like "decisiones pendientes" or
# "pendiente de definir"). Require backticks OR ": pendiente" with no
# additional prose (line ends, or table cell terminates).
grep_fail '(`pendiente`|:\s*pendiente\s*($|\|))' \
  'no "pendiente" as stored value (use "pending")' \
  "$SKILL_ROOT/modes" "$SKILL_ROOT/templates" "$SKILL_ROOT/examples" "$SKILL_ROOT/tests"

# ── v0.5 invariants — state machine + new evals ──────────────────────────────
section "v0.5 invariants — state machine + new evals"

cp_file="$SKILL_ROOT/templates/concept-package.md"
if grep -qE '^\| `aligned` \|' "$cp_file" 2>/dev/null; then
  pass '`aligned` row present in templates/concept-package.md'
else
  fail '`aligned` row missing in templates/concept-package.md'
fi

mr_file="$SKILL_ROOT/modes/meta-review.md"
mr_aligned=0
mr_rfv=0
if grep -q 'aligned' "$mr_file" 2>/dev/null; then mr_aligned=1; fi
if grep -q 'ready-for-validation' "$mr_file" 2>/dev/null; then mr_rfv=1; fi
if [ $mr_aligned -eq 1 ] && [ $mr_rfv -eq 1 ]; then
  pass '`aligned` and `ready-for-validation` both mentioned in modes/meta-review.md'
else
  fail "meta-review.md missing state mentions (aligned=$mr_aligned, ready-for-validation=$mr_rfv)"
fi

eval_file="$SKILL_ROOT/tests/manual-evals.md"
for ev in DD EE FF GG HH II JJ KK; do
  if grep -qE "^## Eval $ev " "$eval_file" 2>/dev/null; then
    pass "Eval $ev present in tests/manual-evals.md"
  else
    fail "Eval $ev missing in tests/manual-evals.md"
  fi
done

lr_file="$SKILL_ROOT/templates/learning-roadmap.md"
if grep -qE '(ASCII values are canonical|recognize / explain / apply / implement / teach)' "$lr_file" 2>/dev/null; then
  pass 'learning-roadmap.md contains ASCII canonical mapping note'
else
  fail 'learning-roadmap.md missing ASCII canonical mapping note'
fi

# MF-1 (v0.5.2): hedge-per-mention rule must be present in canonical gates file.
scg_file="$SKILL_ROOT/templates/source-coverage-gates.md"
if grep -qE '(Hedge-per-mention|hedge debe repetirse en cada mención)' "$scg_file" 2>/dev/null; then
  pass 'MF-1 hedge-per-mention rule present in source-coverage-gates.md'
else
  fail 'MF-1 hedge-per-mention rule missing in source-coverage-gates.md'
fi

# ── Repo hygiene ─────────────────────────────────────────────────────────────
section "Repo hygiene"

junk=$(find "$SKILL_ROOT" \( -name '.DS_Store' -o -name '._*' -o -name '__MACOSX' \) 2>/dev/null)
if [ -z "$junk" ]; then
  pass 'no .DS_Store / ._* / __MACOSX'
else
  fail 'macOS metadata found'
  echo "$junk" | sed 's/^/      /'
fi

# Self-executable bit (warn-level; chmod is platform-dependent).
if [ -x "$0" ]; then
  pass 'scripts/lint.sh is executable'
else
  warn 'scripts/lint.sh is not executable (run: chmod +x scripts/lint.sh)'
fi

# ── Summary ──────────────────────────────────────────────────────────────────
echo ""
echo "────────────────────────────"
if [ $fails -eq 0 ]; then
  echo "PASS ($warns warnings)"
  exit 0
else
  echo "FAIL ($fails errors, $warns warnings)"
  exit 1
fi
