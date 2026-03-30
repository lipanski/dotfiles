"" Plugins
"" Call `:PlugInstall` every time you add a new plugin

"" Install vim-plug if missing
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter' " Gutter with line modification icons
Plug 'airblade/vim-rooter' " Automatically set pwd to git repo root
Plug 'bling/vim-bufferline'
Plug 'folke/which-key.nvim' " Shows available keybindings
Plug 'hashivim/vim-terraform'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ibhagwan/fzf-lua'
Plug 'janko-m/vim-test'
Plug 'junegunn/goyo.vim' " Distraction-free writing
Plug 'leafgarland/typescript-vim'
Plug 'majutsushi/tagbar'
Plug 'morhetz/gruvbox'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'nelstrom/vim-visual-star-search'
Plug 'ntpeters/vim-better-whitespace'
Plug 'peitalin/vim-jsx-typescript'
Plug 'rhysd/vim-crystal'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tmsvg/pear-tree' " Close parenthesis, curly braces etc.
Plug 'tomlion/vim-solidity'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise' " Automatically insert `end` in code blocks
Plug 'tpope/vim-eunuch' " Better support for some Unix commands - :Delete, :Move, :Rename (relative), :Mkdir, :SudoWrite
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired' " Navigation shortcuts: [q / ]q quickfix list, [b / ]b buffer list, [p / ]p paste above or below line, [<Space> / ]<Space> add a blank line
Plug 'vim-ruby/vim-ruby'
Plug 'vimwiki/vimwiki'
Plug 'williamboman/mason.nvim' " Manage external tools
Plug 'williamboman/mason-lspconfig.nvim'

Plug 'neovim/nvim-lspconfig' " Collection of common configurations for the Nvim LSP client
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'hrsh7th/nvim-cmp' " Completion
Plug 'hrsh7th/cmp-buffer' " Completion
Plug 'hrsh7th/cmp-nvim-lsp' " Completion
Plug 'hrsh7th/cmp-path' " Completion
Plug 'L3MON4D3/LuaSnip' " Snippet engine
Plug 'saadparwaiz1/cmp_luasnip' " Snippet engine
Plug 'mrcjkb/rustaceanvim' " Enable some features of rust-analyzer, such as inlay hints and more (similar to simrat39/rust-tools.nvim)
Plug 'folke/trouble.nvim' " Diagnostics

call plug#end()

"" General

syntax on

" Redraw time for syntax highlighting
set rdt=0

set encoding=utf-8

set number

" Theme
colorscheme gruvbox
set background=dark

" Always display the status line
set laststatus=2

" Customize the status line
" List available colours with `:so $VIMRUNTIME/syntax/hitest.vim`
set statusline=%<%f\ \ %#TermCursor#%h%m%r[%{FugitiveHead()}]%#StatusLine#%=%y\ \ %l,%c\ \ %P

set noswapfile

" Save file on buffer switch
set autowrite

" Highlight current line
set cursorline

" Highlight column 120
set colorcolumn=120

" Keep 5 lines above / below cursor
set scrolloff=5

" Always use System clipboard
set clipboard=unnamedplus

" Open new splits on the right side / on the bottom
set splitbelow
set splitright

" Show completion window when multiple commands match
set wildmode=longest:full,full

" Expand file search to ** (works best with wildmode enabled)
set path+=**

" Disable last line that shows current mode
set noshowmode

" Undo always works
set hidden

" Always use vertical diffs
set diffopt+=vertical

" Always show the sign column (used by vim-gitgutter)
set signcolumn=yes

" Update various signs in the sign column or elsewhere (mainly used by vim-gitgutter)
set updatetime=300

" Set leader key
let mapleader = " "

" Change the look of the bufferline
let g:bufferline_active_buffer_left = '#'
let g:bufferline_active_buffer_right = ''

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

"" Whitespace

set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set fixendofline
let g:strip_whitespace_on_save = 1
let g:strip_only_modified_lines = 1
let g:strip_whitespace_confirm = 0

"" Search

set nohlsearch
set incsearch

" All searches are case insensitive except when search contains one upper case letter
" set ignorecase
" set smartcase

"" Switch pwd only for these file paths
let g:rooter_targets = ['~/dev/*']

"" LSP

lua <<EOF
  -- trouble
  require('trouble').setup()

  -- tresitter
  require('nvim-treesitter').install {
    'css',
    'html',
    'javascript',
    -- 'markdown',
    -- 'markdown_inline',
    'ruby',
    'rust',
    'scss',
  }

  vim.api.nvim_create_autocmd('FileType', {
    pattern = {
      'css',
      'html',
      'javascript',
      -- 'markdown',
      -- 'markdown_inline',
      'ruby',
      'rust',
      'scss',
    },
    callback = function(args)
      do return end -- this thing is not ready
      local buf, filetype = args.buf, args.match
      local language = vim.treesitter.language.get_lang(filetype)
      if not language then
        return
      end

      -- check if parser exists and load it
      if not vim.treesitter.language.add(language) then
        return
      end

      -- enables syntax highlighting and other treesitter features
      vim.treesitter.start(buf, language)

      -- enables treesitter based folds
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo.foldmethod = "expr"
      -- ensure folds are open to begin with
      vim.o.foldlevel = 99

      -- enables treesitter based indentation
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })

  -- which-key (key bindings helper)
  local wk = require("which-key")
  wk.add({
    { "<leader>f", group = "Find files" },
    { "<leader>g", group = "Find words" },
  })


  -- lsp
  require('mason').setup()
  require('mason-lspconfig').setup {
    ensure_installed = { 'ruby_lsp', 'rust_analyzer' },
    automatic_installation = true,
    automatic_setup = false,
    automatic_enable = false, -- nvim_lsp should do this, otherwise we end up with duplicates
  }

  vim.lsp.config('ruby_lsp', {
    -- Workaround to avoid installing ruby-lsp for every Ruby
    -- See https://github.com/mason-org/mason.nvim/issues/1777
    cmd = { os.getenv('HOME') .. '/.local/share/nvim/mason/bin/ruby-lsp', '--use-launcher' }
  })
  vim.lsp.enable('ruby_lsp', 'rust_analyzer')

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
      end
      map("n", "gd", vim.lsp.buf.definition, "LSP: goto definition")
      map("n", "gr", vim.lsp.buf.references, "LSP: references")
      map("n", "K", vim.lsp.buf.hover, "LSP: hover")
      map("n", "ga", vim.lsp.buf.code_action, "LSP: code action")
      -- map("n", "<leader>lr", vim.lsp.buf.rename, "LSP: rename")
      -- map("n", "<leader>lf", function()
      --   vim.lsp.buf.format({ async = true })
      -- end, "LSP: format")
    end,
  })

  -- rust
  vim.g.rustaceanvim = {
    tools = {
      enable_clippy = true
    },
    server = {
      on_attach = function(_, bufnr)
        local map = function(m, l, r, d) vim.keymap.set(m, l, r, { buffer = bufnr, desc = d }) end
        map("n", "ga", function() vim.cmd.RustLsp("codeAction") end, "Rust: code action")
        -- map("n", "K", function() vim.cmd.RustLsp({'hover', 'actions'}) end, "Rust: hover actions")
      end,
    },
  }

  -- autocomplete
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  cmp.setup({
    -- Enable LSP snippets
    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
    mapping = {
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      ['<Tab>'] = cmp.mapping.select_next_item(),
      -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      -- ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        -- behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      })
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
      { name = 'buffer' },
    },
    preselect = false,
    completion = {
      autocomplete = false,
    },
  })

  -- add a border to floating windows
  vim.o.winborder = "single"
EOF

autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

"" Ruby

let g:rubycomplete_rails = 1
let g:rubycomplete_use_bundler = 1
let g:ruby_indent_assignment_style = 'variable'
let g:ruby_indent_hanging_elements = 0

"" Code completion

" Completion for parenthesis, curly braces etc.
let g:pear_tree_repeatable_expand = 0
let g:pear_tree_smart_backspace   = 1
let g:pear_tree_smart_closers     = 1
let g:pear_tree_smart_openers     = 1

" Never auto-select entries when displaying the autocomplete menu
set completeopt=menu,menuone,noinsert,noselect

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable("ag")
  " Use Ag over Grep
  set grepprg=ag\ --hidden\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" Snippets
let g:UltiSnipsExpandTrigger="<c-s>"

"" Directory tree

let g:netrw_liststyle = 3
let g:netrw_banner = 0

" Perform a case-insensitive sort
let g:netrw_sort_options = "i"

" Hide gitignored files and other common patterns
" let g:netrw_list_hide = netrw_gitignore#Hide() . 'node_modules/,\.bundle/,\.git/'

"" Mail

autocmd FileType mail setlocal fo-=t wrap linebreak nolist
autocmd FileType mail DisableStripWhitespaceOnSave

"" NERDTree

" Toggle NERDTree with Ctrl-n
map <C-n> :NERDTreeToggle<CR>

"" Custom commands

" Spell checking
command! English execute "setlocal spell spelllang=en_gb"
command! German execute "setlocal spell spelllang=de_de"

"" Markdown

augroup Markdown
  autocmd!
  autocmd FileType markdown set wrap
  autocmd FileType markdown set colorcolumn=80
augroup END

"" Wiki

let g:vimwiki_list = [{'path': '~/Dropbox/wiki/', 'syntax': 'markdown', 'ext': '.md'}]

nnoremap <Leader>d :VimwikiIndex<CR>:VimwikiGoto journal<CR>
nnoremap <Leader>p :VimwikiIndex<CR>:VimwikiGoto personal<CR>

" Sitck to the vimwiki_list, don't create temporary wikis within the project directory
let g:vimwiki_global_ext = 0

"" Rust

" Fold comments
function! RustFold(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    endif

    let this_indent = indent(a:lnum) / &shiftwidth

    if getline(a:lnum) =~? '^\s*///.*$'
        return this_indent
    endif

    if getline(a:lnum) =~? '^\s*//!.*$'
        return '1'
    endif

    return '0'
endfunction

autocmd FileType rust setlocal foldmethod=expr foldexpr=RustFold(v:lnum)

let g:rustfmt_autosave = 1

autocmd FileType rust nnoremap <C-b> :Cbuild<CR>
autocmd FileType rust nnoremap <C-x> :RustLsp runnables<CR>

"" Key bindings

" Window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Open file under cursor in a vertical split by default
nmap <C-w>f <C-w>vgf
nmap <C-w>F <C-w>vgF

" vim-test bindings
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

" Key bindings for fzf and diagnostics
nnoremap <leader>p :FzfLua global<CR>
nnoremap <leader>f :FzfLua git_files<CR>
nnoremap <leader>g :FzfLua grep<CR>
vnoremap <leader>g y:FzfLua live_grep<SPACE>query="<C-R>=@"<CR>"<CR>
nnoremap <leader>b :FzfLua buffers<CR>
nnoremap <leader>j :FzfLua tags<CR>
nnoremap <leader>k :FzfLua btags<CR>
nnoremap <leader>c :FzfLua git_branches<CR>
nnoremap <leader>a :Trouble diagnostics<CR>

" Clear all buffers
nmap <leader>l :bufdo :bd<CR>

" Open vim-fugitive
nmap <C-g> :G<CR>

" Terminal shortcuts
nmap <leader>s :term<CR>i
nmap <leader>rc :term<CR>ibundle exec rails c<CR>
