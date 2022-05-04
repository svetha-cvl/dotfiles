runtime ./plug.vim
set nocompatible "be iMproved, required

set noswapfile

set mouse=a

"Remap leader
let mapleader = ","

set termguicolors
colorscheme github_dark
let g:github_comment_style = "italic"
let g:github_keyword_style = "NONE"
let g:github_function_style = "NONE"
let g:github_variable_style = "NONE"

"Remap most used NERDTree commands
nnoremap <Leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

"Map ctrl+p to fuzzy find files
nnoremap <c-p> :FZF<CR>

"Remap window and split navigation, just a little easier
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l
nnoremap <leader>h <c-w>h
"Handy shortcut to make a vertical split and switch to it
nnoremap <leader>v <c-w>v<c-w>l
"Remap tab navigation
nnoremap tn :tabnext<CR>
nnoremap tp :tabprev<CR>
nnoremap te :tabedit

"https://github.com/camspiers/lens.vim#disabled-filetypes
let g:lens#disabled_filetypes = ['nerdtree', 'fzf']

"Set filename as window title
set title

"Automatically write the content of the buffer if you call :make
"Especially useful for :GoBuild, saves an explicit write operation
set autowrite

"Show cursor position"
set ruler
"Set scroll offset to avoid hitting the last line before scrolling"
set scrolloff=3

syntax on
let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'vim', 'go', 'clojure', 'rust', 'bash']

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
"Round indent spacing to the next multiple of shiftwidth on any indent actions
set shiftround

"Setting both number and relative number shows the actual line number for the current line (where cursor is located) and the relative number for the other lines.
set number
set relativenumber
"Toggle line numbers
nnoremap <leader>ln :set number!<CR>
nnoremap <leader>lrn :set relativenumber!<CR>
"Toggle cursor line
nnoremap <leader>lc :set cursorline!<CR>

"Show whitespaces
set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:.

"Increment/decrement letters (useful for lists).
set nrformats+=alpha

"Show status bar always
set laststatus=2

"Allow hidden buffers, ie buffers outside of any windows with unsaved text.
"This does mean that we can exit vim and unsaved changes will be lost!
set hidden

"Search is case-insensitive if the search text is all lower-case. It also becomes case-sensitive if the search text has any upper-case characters.
set ignorecase
set smartcase

"Reselect pasted text
nnoremap gp `[v`]

"Turn on incremental search, ie search as the search text is being typed.
set incsearch
"Highlight search results. :set nohlsearch if this is overwhelming visually.
set hlsearch

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{timeout=1000}
augroup END

"Indent"
set autoindent
set foldmethod=indent
set foldlevel=2

"Disable automatic window resizing for nerdtree and fzf
let g:lens#disabled_filetypes = ['nerdtree', 'fzf']

"Turn off audio bell for errors. This can get annoying. Use a visual bell instead.
"Turn off flash for the visual bell
set noerrorbells visualbell t_vb=

"Remap vim-go commands
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

"Prose mode. Reference: https://www.reddit.com/r/vim/comments/q03mqa/my_setup_for_prose/
let w:ProseModeOn = 0

function EnableProseMode()
	setlocal spell spelllang=en_us
	Goyo
	SoftPencil
	echo "Prose Mode On"
endfu

function DisableProseMode()
	Goyo!
	NoPencil
	setlocal nospell
	echo "Prose Mode Off"
endfu

function ToggleProseMode()
	if w:ProseModeOn == 0
		call EnableProseMode()
		let w:ProseModeOn = 1
	else
		call DisableProseMode()
	endif
endfu

command Prose call EnableProseMode()
command UnProse call DisableProseMode()
command ToggleProse call ToggleProseMode()

function ScratchBufferize()
	setlocal buftype=nofile
	setlocal bufhidden=hide
	setlocal noswapfile
endfu

"Requires moby thesaurus https://github.com/words/moby
nnoremap <Leader>t :new \| read ! moby <C-R><C-W> \| tr , '\n' <CR>:call ScratchBufferize() <CR>:normal gg2dd <CR>

let g:coq_settings = { 'auto_start': 'shut-up' }

" -------------------- LSP ---------------------------------
lua << EOF
  local nvim_lsp = require('lspconfig')
  local coq = require('coq')

  local on_attach = function(client, bufnr)
    -- require('completion').on_attach(client, bufnr)

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        require('lspconfig').util.nvim_multiline_command [[
        :hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
        :hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
        :hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
        augroup lsp_document_highlight
            autocmd!
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]]
    end
  end

  local servers = {'gopls', 'yamlls', 'bashls', 'pyright'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
    }
  end

  nvim_lsp['clojure_lsp'].setup {
      cmd = { "clojure-lsp" },
      filetypes = { "clojure", "edn" },
      --root_dir = root_pattern("project.clj", "deps.edn", ".git"),
      on_attach = on_attach,
    }
  -- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#texlab
  nvim_lsp['texlab'].setup {
      cmd = { "texlab" },
      filetypes = { "tex", "bib" },
      on_attach = on_attach,
      settings = {
          texlab = {
            auxDirectory = ".",
            bibtexFormatter = "texlab",
            build = {
              args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
              executable = "latexmk",
              forwardSearchAfter = false,
              onSave = false
            },
            chktex = {
              onEdit = false,
              onOpenAndSave = false
            },
            diagnosticsDelay = 300,
            formatterLineLength = 80,
            forwardSearch = {
              args = {}
            },
            latexFormatter = "latexindent",
            latexindent = {
              modifyLineBreaks = false
            }
          }
        }
    }

  -- efm language server requires configuration at ~/.config/efm-langserver/config.yaml
  -- Refer https://github.com/mattn/efm-langserver#configuration
  nvim_lsp['efm'].setup {
      filetypes = { 'dockerfile', 'sh', 'yaml', 'json' },
      init_options = {documentFormatting=true, hover=true, documentSymbol=true, completion=true},
      settings = {
        rootMarkers = {".git/"},
        languages = {
            dockerfile = {
                {lintCommand="hadolint", lintFormats="%f:%l %m"}
            },
            sh = {
                {lintCommand="shellcheck -f gcc -x", lintSource="shellcheck", lintFormats={"%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m"}}
            },
            json = {
                {lintCommand="jq .", lintSource="jq"}
            }
        }
      },
      on_attach = on_attach,
    }

    nvim_lsp['terraformls'].setup {
        filetypes = { "terraform", "tf" },
        cmd = { "terraform-ls", "serve" },
        root_pattern = {".terraform", ".git"},
        }
EOF
autocmd BufWritePre *.tf lua vim.lsp.buf.formatting_sync()

let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,scheme,go,tf RainbowParentheses
augroup END
