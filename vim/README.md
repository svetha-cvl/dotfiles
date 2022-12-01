vim/  
├── _[coc-settings.json](./coc-settings.json) [DEPRECATED for neovim lsp]_   
├── [init.vim](./init.vim) - neovim configuration   
└── [plug.vim](./plug.vim) - neovim plugin configuration using [vim-plug](https://github.com/junegunn/vim-plug)

### Theme
:AirlineTheme dark
Github theme
https://github.com/projekt0n/github-nvim-theme

### Language Servers
- LSP configuration - https://github.com/neovim/nvim-lspconfig
- Autocompletion with LSP - https://github.com/ms-jpq/coq_nvim
    - :COQdeps to install dependencies
- Language servers used:
    - GO111MODULE=on go get golang.org/x/tools/gopls@latest
    - npm i -g bash-language-server
    - yarn global add yaml-language-server
    - brew install efm-langserver (General purpose language server for shellcheck, to use with neovim lsp. https://github.com/mattn/efm-langserver#example-for-configyaml)
    - brew install hadolint
    - brew install shellcheck
    - brew install jq
    - brew install clojure-lsp/brew/clojure-lsp-native
    - cargo install --git https://github.com/latex-lsp/texlab.git --locked
    - npm i -g pyright
    - brew install hashicorp/tap/terraform-ls
    - npm i -g sql-language-server

### Writing Mode
- Tools:
    - [Moby thesaurus](https://github.com/words/moby): npm i -g moby
- Vim goodness for writing mode taken from [here](https://www.reddit.com/r/vim/comments/q03mqa/my_setup_for_prose/)
