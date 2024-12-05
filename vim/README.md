vim/  
├── _[coc-settings.json](./coc-settings.json) [DEPRECATED for neovim lsp]_   
├── [init.vim](./init.vim) - neovim configuration   
└── [plug.vim](./plug.vim) - neovim plugin configuration using [vim-plug](https://github.com/junegunn/vim-plug)

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
