#!/usr/bin/env zsh
# Smoke-test driver for the dotfiles repo.
# Run from the repo root: zsh .claude/skills/run-dotfiles/smoke.sh

set -euo pipefail

DOTFILES_ROOT="${1:-$(pwd -P)}"
PASS=0; FAIL=0

ok()   { echo "  PASS: $1"; ((PASS++)); }
fail() { echo "  FAIL: $1"; ((FAIL++)); }

echo "=== dotfiles smoke test (root: $DOTFILES_ROOT) ==="

# ── 1. Config file syntax ─────────────────────────────────────────────────────
echo "\n[1] Config syntax"

zsh -n "$DOTFILES_ROOT/zsh/.zshrc.symlink" 2>&1 \
  && ok "zsh/.zshrc.symlink" \
  || fail "zsh/.zshrc.symlink syntax error"

nvim --headless --noplugin \
  -c "source $DOTFILES_ROOT/vim/.vimrc.symlink" \
  -c "qa!" 2>/dev/null \
  && ok "vim/.vimrc.symlink" \
  || fail "vim/.vimrc.symlink syntax error"

nvim --headless --noplugin \
  -c "source $DOTFILES_ROOT/vim/init.vim" \
  -c "qa!" 2>/dev/null \
  && ok "vim/init.vim" \
  || fail "vim/init.vim syntax error"

# ── 2. Shell functions ────────────────────────────────────────────────────────
echo "\n[2] Shell functions"

zsh -c "
source $DOTFILES_ROOT/functions/mkcd
source $DOTFILES_ROOT/functions/gcom

# mkcd: creates nested dirs and cds into them
TMPD=\$(mktemp -d)
mkcd \"\$TMPD/sub/nested\" && [[ \"\$PWD\" == *sub/nested* ]] && echo OK || echo FAIL
rm -rf \"\$TMPD\"
" | grep -q OK && ok "mkcd" || fail "mkcd"

zsh -c "
source $DOTFILES_ROOT/functions/gcom

TMPGIT=\$(mktemp -d)
git -C \"\$TMPGIT\" init -q
git -C \"\$TMPGIT\" commit --allow-empty -m init -q
git -C \"\$TMPGIT\" branch -M main -q
cd \"\$TMPGIT\"
gcom 2>/dev/null
[[ \"\$(git branch --show-current)\" == main ]] && echo OK || echo FAIL
rm -rf \"\$TMPGIT\"
" | grep -q OK && ok "gcom" || fail "gcom"

# gccd: clone + auto-cd (tests with a local bare repo)
zsh -c "
source $DOTFILES_ROOT/functions/gccd

REMOTE=\$(mktemp -d)/remote.git
mkdir -p \"\$REMOTE\"
git init --bare -q \"\$REMOTE\"
git -C \"\$REMOTE\" symbolic-ref HEAD refs/heads/main

WORKDIR=\$(mktemp -d)
cd \"\$WORKDIR\"
gccd \"\$REMOTE\" 2>/dev/null
[[ \"\$PWD\" == *remote* ]] && echo OK || echo FAIL
rm -rf \"\$WORKDIR\" \"\$(dirname \$REMOTE)\"
" | grep -q OK && ok "gccd" || fail "gccd"

# ── 3. install.sh dry-run: template substitution ──────────────────────────────
echo "\n[3] install.sh template substitution"

TMPDIR=$(mktemp -d)
# Replicate the zshrc template substitution from install.sh
sed -e "s=DOTFILES_ROOT=${DOTFILES_ROOT}=g" \
  "$DOTFILES_ROOT/zsh/.zshrc.symlink" > "$TMPDIR/.zshrc.local"
grep -q "$DOTFILES_ROOT" "$TMPDIR/.zshrc.local" \
  && ok "zshrc DOTFILES_ROOT substitution" \
  || fail "zshrc DOTFILES_ROOT substitution"
rm -rf "$TMPDIR"

# ── 4. Required files present ─────────────────────────────────────────────────
echo "\n[4] Required files"

for f in \
  install.sh \
  zsh/.zshrc.symlink \
  zsh/.p10k.zsh \
  vim/.vimrc.symlink \
  vim/init.vim \
  vim/plug.vim \
  git/.gitconfig.symlink \
  git/.gitconfig-work.symlink \
  psql/.psqlrc.symlink \
  functions/gccd \
  functions/gcom \
  functions/mkcd; do
  [[ -f "$DOTFILES_ROOT/$f" ]] && ok "$f" || fail "$f missing"
done

# ── Summary ───────────────────────────────────────────────────────────────────
echo "\n=== Results: $PASS passed, $FAIL failed ==="
(( FAIL == 0 ))
