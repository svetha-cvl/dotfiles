runtime ./plug.vim
set nocompatible "be iMproved, required

set noswapfile

set mouse=a

"Remap leader
let mapleader = ","

set termguicolors
" colorscheme github_dark
" let g:github_comment_style = "italic"
" let g:github_keyword_style = "NONE"
" let g:github_function_style = "NONE"
" let g:github_variable_style = "NONE"

lua << EOF
require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
    dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = { -- https://github.com/catppuccin/nvim#integrations
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = false,
        mini = false,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
            inlay_hints = {
                background = true,
            },
        },
        treesitter = true,
        ts_rainbow2 = true,
        gitgutter = true,
    },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
EOF

colorscheme catppuccin
let g:airline_theme = 'catppuccin'

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

"Tab between buffers
noremap <tab> <c-w><c-w>
"Display open buffers
nnoremap <leader>b :buffers<CR>:buffer<Space>

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
"Make the substitute command change the document live.
set inccommand=split

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
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

    -- Broken with neovim 0.10
    -- Set autocommands conditional on server_capabilities
    -- if client.resolved_capabilities.document_highlight then
    --     require('lspconfig').util.nvim_multiline_command [[
    --     :hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
    --     :hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
    --     :hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
    --     augroup lsp_document_highlight
    --         autocmd!
    --         autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    --         autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    --     augroup END
    --     ]]
    -- end
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
        on_attach = on_attach,
        }

    nvim_lsp['sqlls'].setup {
        cmd = { "sql-language-server", "up", "--method", "stdio" },
  --      on_attach = on_attach,
        }
EOF

lua << EOF
    require'nvim-treesitter.configs'.setup {
    -- treesitter requires the following parsers to always be installed
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = false,

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "c", "rust" },
        -- -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        -- disable = function(lang, buf)
        --     local max_filesize = 100 * 1024 -- 100 KB
        --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        --     if ok and stats and stats.size > max_filesize then
        --         return true
        --     end
        -- end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },

    indent = {
        enable = true
    },

    -- Broken with nvim 0.10 / latest treesitter
    -- Using rainbow-delimiters with default config instead
    -- https://github.com/HiPhish/nvim-ts-rainbow2
    -- rainbow = {
    --     enable = true,
    --     query = {
    --         'rainbow-parens',
    --         html = 'rainbow-tags',
    --         latex = 'rainbow-blocks',
    --     },
    --     -- Highlight the entire buffer all at once
    --     strategy = require('ts-rainbow').strategy.global,
    -- }
}
EOF

" Trying out ts-rainbow instead
" let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
" augroup rainbow_lisp
"   autocmd!
"   autocmd FileType lisp,clojure,scheme,go,tf RainbowParentheses
" augroup END
"
lua << EOF
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

-- Has to be called after setup
require('telescope').load_extension('fzf')
EOF

nnoremap <silent> ;f <cmd>Telescope find_files<cr>
nnoremap <silent> ;r <cmd>Telescope live_grep<cr>
nnoremap <silent> ; <cmd>Telescope<cr>
