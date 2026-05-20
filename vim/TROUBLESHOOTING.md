# Neovim config troubleshooting log

A record of issues hit while bringing up this Neovim config on macOS Tahoe
(26.2) in May 2026, and the fixes that resolved them. Keep this around so
the next time something similar pops up you don't have to re-debug from
scratch.

---

## 1. `module 'nvim-treesitter.configs' not found`

### Symptom
```
Error in /Users/svetha/.config/nvim/init.vim:
line  485:
E5108: Lua: [string ":lua"]:1: module 'nvim-treesitter.configs' not found
```

### Root cause
`nvim-treesitter` published a full rewrite on the `main` branch (which is
now the default that vim-plug clones). The new branch removes the
`require('nvim-treesitter.configs').setup{}` API entirely. The README is
explicit about this:

> This is a full, incompatible, rewrite: Treat this as a different plugin
> you need to set up from scratch. If you can't or don't want to update,
> specify the `master` branch (which is locked but will remain available
> for backward compatibility with Nvim 0.11).

### Fix
Pin `nvim-treesitter` to `master` in `vim/plug.vim`:

```vim
Plug 'nvim-treesitter/nvim-treesitter', { 'branch': 'master', 'do': ':TSUpdate' }
```

Then reinstall:

```vim
:PlugClean
:PlugInstall
:TSUpdate
```

The existing `require('nvim-treesitter.configs').setup{}` block in
`init.vim` keeps working as-is.

The alternative (migrating to the new `main`-branch API) requires Neovim
0.12+ nightly and `tree-sitter-cli >= 0.26.1`, so stick with `master`
unless/until you're on nightly.

---

## 2. `require('lspconfig')` deprecation warning

### Symptom
```
The `require('lspconfig')` "framework" is deprecated, use vim.lsp.config
(see :help lspconfig-nvim-0.11) instead.
Feature will be removed in nvim-lspconfig v3.0.0
```

### Root cause
Since Neovim 0.11, the canonical way to configure LSP servers is the
built-in `vim.lsp.config` / `vim.lsp.enable` API. `nvim-lspconfig` still
ships per-server defaults under `lsp/<name>.lua`, which `vim.lsp.enable`
picks up automatically — but the old
`require('lspconfig')[name].setup{}` "framework" is being removed in
v3.0.0.

### Fix
Migrate the LSP block in `vim/init.vim`:

```lua
-- Before
local nvim_lsp = require('lspconfig')
nvim_lsp[lsp].setup { on_attach = on_attach }

-- After
vim.lsp.config('*', { on_attach = on_attach })   -- wildcard applies to all
vim.lsp.config('terraformls', {                  -- per-server overrides
  filetypes = { 'terraform', 'tf' },
  cmd = { 'terraform-ls', 'serve' },
  root_markers = { '.terraform', '.git' },
})
vim.lsp.enable({
  'gopls', 'yamlls', 'bashls', 'pyright', 'buf_ls',
  'clojure_lsp', 'texlab', 'efm', 'terraformls', 'sqlls',
})
```

Notes:
- `vim.lsp.config('*', { ... })` applies to every enabled server, so
  `on_attach` doesn't need to be passed per-server anymore.
- Use `vim.bo[bufnr].omnifunc = ...` instead of the deprecated
  `vim.api.nvim_buf_set_option(bufnr, 'omnifunc', ...)`.
- Use `root_markers` (not `root_pattern`) for the new API.
- Per-server defaults shipped under `nvim-lspconfig/lsp/<name>.lua` are
  picked up automatically, so you only need overrides where you actually
  customise something.

See `:help lspconfig-nvim-0.11` for the official migration guide.

---

## 3. `airline: Could not resolve airline theme "catppuccin"`

### Symptom
```
airline: Could not resolve airline theme "catppuccin".
```

### Root cause
`catppuccin/nvim` doesn't ship an airline theme, and `vim-airline-themes`
doesn't include catppuccin in its built-in theme set either. The
`let g:airline_theme = 'catppuccin'` line had no provider.

### Fix
Add the `catppuccin/vim` plugin (which ships the airline theme files for
all four flavours) in `vim/plug.vim`. Alias it to avoid colliding with
the existing `catppuccin/nvim` alias:

```vim
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'catppuccin/vim', { 'as': 'catppuccin-vim' }
```

And update the theme name in `init.vim` to include the flavour suffix
(it must match the flavour used in `catppuccin.setup({ flavour = "..." })`):

```vim
let g:airline_theme = 'catppuccin_mocha'
```

Available suffixes: `_latte`, `_frappe`, `_macchiato`, `_mocha`.

---

## 4. `:COQdeps` → "Please install python3-venv separately. (apt, yum, apk, etc)"

### Symptom
Running `:COQdeps` in Neovim prints:
```
Please install python3-venv separately. (apt, yum, apk, etc)
```
…even though you're on macOS and Homebrew Python has `venv` available.

### Root cause
**The error message is misleading.** coq_nvim wraps venv setup in a broad
try/except that catches every failure and prints that apt-flavoured
message — even when the real problem is something else entirely.

The real failure is `ensurepip` blowing up during venv creation:

```
ImportError: dlopen(.../pyexpat.cpython-312-darwin.so):
  Symbol not found: _XML_SetAllocTrackerActivationThreshold
  Referenced from: pyexpat.cpython-312-darwin.so
  Expected in:     /usr/lib/libexpat.1.dylib
```

Every Homebrew Python bottle (3.10, 3.12, 3.14) was built against
`libexpat 2.7+` (which has this symbol), but at runtime they load the
older `/usr/lib/libexpat.1.dylib` shipped with macOS Tahoe 26.2 which
doesn't. Anything that imports `pyexpat` — including `ensurepip` invoked
during `python -m venv` — crashes immediately. This is a known Homebrew
↔ macOS Tahoe interaction.

The provenance / `com.apple.provenance` xattr was a red herring along
the way: it does prevent `python -m venv --clear` from deleting the old
venv on subsequent runs, but the actual reason coq fails on the *first*
run is the libexpat ABI mismatch.

### Fix
Two paths tried, in order:

1. **`brew reinstall --build-from-source python@3.12`** — failed with
   `install: Modules/pyexpat.cpython-312-darwin.so: No such file or
   directory` because the formula uses `--with-system-expat` and the
   system expat headers don't have the new symbol either, so the build
   silently skipped pyexpat.
2. **`uv` (winner)** — `uv` installs hermetic Python builds (from
   `astral-sh/python-build-standalone`) that bundle their own libexpat
   and aren't affected by the macOS regression.

One-time setup:

```bash
brew install uv
uv python install 3.12
uv python find 3.12   # prints the install path
rm -rf ~/.local/share/nvim/plugged/coq_nvim/.vars
```

Then in `vim/init.vim`, point `g:python3_host_prog` at the uv-installed
interpreter (the actual block in `init.vim` has a full comment):

```vim
let s:uv_python = expand('~/.local/share/uv/python/cpython-3.12-macos-aarch64-none/bin/python3.12')
if filereadable(s:uv_python)
  let g:python3_host_prog = s:uv_python
endif
```

Open Neovim, run `:COQdeps`, and it completes cleanly.

### How to re-diagnose if this happens again
Don't trust coq's error message. Reproduce the failure manually,
bypassing coq's try/except, to see the real traceback:

```bash
rm -rf ~/.local/share/nvim/plugged/coq_nvim/.vars
python3 -c "
from venv import EnvBuilder
import traceback, sys
try:
    EnvBuilder(
        system_site_packages=False,
        with_pip=True,
        upgrade=True,
        symlinks=True,
        clear=True,
    ).create('/tmp/coq-venv-test')
    print('OK')
except Exception:
    traceback.print_exc()
    sys.exit(1)
"
```

If that fails, drill one level deeper by running `ensurepip` against the
freshly-created venv's interpreter:

```bash
/tmp/coq-venv-test/bin/python3 -m ensurepip --upgrade --default-pip
```

That's how the real `pyexpat` error surfaced.

### When can we remove the `g:python3_host_prog` block?
Once Homebrew ships a Python bottle for macOS Tahoe that links against
its own bundled libexpat (or links against the OS one with a compatible
ABI). Check with:

```bash
brew upgrade python@3.12
python3.12 -c "from xml.parsers import expat; print('expat OK')"
```

If you see `expat OK`, the `g:python3_host_prog` block becomes a no-op
(it's guarded with `filereadable()` so it's safe to leave it; or just
delete it).
