" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'

let g:plug_home = stdpath('data') . '/plugged'
call plug#begin()

" Plug 'projekt0n/github-nvim-theme'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" Plug 'HiPhish/nvim-ts-rainbow2' " this plugin is not working
" Plug 'junegunn/rainbow_parentheses.vim'
Plug 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim'

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
" fzf-native needs to be built using make
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'neovim/nvim-lspconfig'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}

Plug 'mfussenegger/nvim-dap'
" dependency for nvim-dap-ui
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'
Plug 'leoluz/nvim-dap-go'
Plug 'nvim-telescope/telescope-dap.nvim'

" Plug 'camspiers/animate.vim'
" Plug 'camspiers/lens.vim'

Plug 'junegunn/goyo.vim', { 'for': [ 'markdown', 'text' ] }
Plug 'reedes/vim-pencil', { 'for': [ 'markdown', 'text' ] }

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'github/copilot.vim'
Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'main' }

Plug 'folke/which-key.nvim'

" Initialize plugin system
call plug#end()
