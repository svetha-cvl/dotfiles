vim/  
├── _[coc-settings.json](./coc-settings.json) [DEPRECATED for neovim lsp]_   
├── [init.vim](./init.vim) - neovim configuration   
├── [local.vim.example](./local.vim.example) - template for machine-local overrides (see below)
└── [plug.vim](./plug.vim) - neovim plugin configuration using [vim-plug](https://github.com/junegunn/vim-plug)

`init.local.vim` (gitignored) holds per-machine settings such as private GitLab
domains; it is not listed above because each clone creates its own copy.

### Machine-local overrides

Some settings are machine- or employer-specific and should not be committed
(for example a private GitLab domain for `:GBrowse` via
[vim-fugitive](https://github.com/tpope/vim-fugitive) and
[fugitive-gitlab.vim](https://github.com/shumphrey/fugitive-gitlab.vim)).

`init.vim` sources `init.local.vim` from the same directory when it exists.
That file matches the repo's `*.local.*` gitignore rule.

On a new machine:

```sh
cp vim/local.vim.example vim/init.local.vim
# edit init.local.vim — set g:fugitive_gitlab_domains to your instance(s)
```

No `install.sh` changes are needed; because `~/.config/nvim/init.vim` is a
symlink into this directory, the local file is picked up automatically.

### Neovim version
**Supported: Neovim 0.11.x only (currently pinned to 0.11.7).**

This config keeps `nvim-treesitter` on its `master` branch (see
[plug.vim](./plug.vim)) so the existing `require('nvim-treesitter.configs').setup{}`
block in `init.vim` keeps working. That branch is frozen upstream and
explicitly does **not** support Neovim 0.12+ — running 0.12 produces a
crash loop in the `conceal_line` decoration provider on every redraw.

Don't install Neovim via Homebrew (it tracks latest only and will pull
in 0.12). Use the official signed release tarball pinned to the latest
0.11 patch and symlink it onto PATH. Full instructions and the
underlying root cause are in
[TROUBLESHOOTING.md §5](./TROUBLESHOOTING.md#5-nvim-treesitter-crash-on-neovim-012-attempt-to-call-method-range-a-nil-value).

Moving to 0.12+ requires migrating `nvim-treesitter` to its `main`
branch (a full rewrite that drops the `configs` API). See the "When
can we move forward" subsection of TROUBLESHOOTING §5 for the concrete
list of changes that migration entails.

### Plugin Manager
```sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

### Theme
:AirlineTheme dark
Github theme
https://github.com/projekt0n/github-nvim-theme
https://github.com/catppuccin/catppuccin

### Language Servers
- LSP configuration - https://github.com/neovim/nvim-lspconfig
- Autocompletion with LSP - https://github.com/ms-jpq/coq_nvim
    - :COQdeps to install dependencies
- Language servers used:
    - go install golang.org/x/tools/gopls@latest
    - npm i -g bash-language-server
    - yarn global add yaml-language-server
    - brew install efm-langserver (General purpose language server for shellcheck, to use with neovim lsp. https://github.com/mattn/efm-langserver#example-for-configyaml)
    e brew install hadolint
    - brew install shellcheck
    - brew install jq
    - brew install clojure-lsp/brew/clojure-lsp-native
    - cargo install --git https://github.com/latex-lsp/texlab.git --locked
    - npm i -g pyright
    - brew install hashicorp/tap/terraform-ls
    - npm i -g sql-language-server

### Treesitter Parsers
- Install these manually using `:TSInstall <parser>`
    - bash
    - c
    - dockerfile
    - go
    - json
    - latex
    - lua
    - make
    - markdown
    - markdown_inline
    - proto
    - python
    - query
    - terraform
    - vim
    - vimdoc
    - yaml
- Reference: https://github.com/nvim-treesitter/nvim-treesitter#supported-languages

### Telescope dependencies
- brew install ripgrep

### Writing Mode
- Tools:
    - [Moby thesaurus](https://github.com/words/moby): npm i -g moby
- Vim goodness for writing mode taken from [here](https://www.reddit.com/r/vim/comments/q03mqa/my_setup_for_prose/)
