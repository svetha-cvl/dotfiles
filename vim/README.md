vim/  
├── _[coc-settings.json](./coc-settings.json) [DEPRECATED for neovim lsp]_   
├── [init.vim](./init.vim) - neovim configuration   
└── [plug.vim](./plug.vim) - neovim plugin configuration using [vim-plug](https://github.com/junegunn/vim-plug)

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
