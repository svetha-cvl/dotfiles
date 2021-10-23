vim/   
├── _[coc-settings.json](./coc-settings.json) [DEPRECATED for neovim lsp]_   
├── [init.vim](./init.vim) - neovim configuration   
└── [plug.vim](./plug.vim) - neovim plugin configuration using [vim-plug](https://github.com/junegunn/vim-plug)   

### Theme
Solarized dark
- https://github.com/overcache/NeoSolarized
- https://github.com/vim-airline/vim-airline/wiki/Screenshots#solarized-dark
:AirlineTheme solarized

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
