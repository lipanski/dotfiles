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
Plug 'ajh17/VimCompletesMe'
Plug 'andrewradev/splitjoin.vim'
Plug 'bling/vim-bufferline'
Plug 'hashivim/vim-terraform'
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'leafgarland/typescript-vim'
Plug 'ludovicchabant/vim-gutentags' " Manage ctags updates automatically
Plug 'majutsushi/tagbar'
Plug 'morhetz/gruvbox'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'nelstrom/vim-visual-star-search'
Plug 'ntpeters/vim-better-whitespace'
Plug 'pearofducks/ansible-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'rhysd/vim-crystal'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'stsewd/fzf-checkout.vim'
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

Plug 'nvim-lua/plenary.nvim'
Plug 'frankroeder/parrot.nvim'

Plug 'neovim/nvim-lspconfig' " Collection of common configurations for the Nvim LSP client
Plug 'hrsh7th/nvim-cmp' " Completion
Plug 'hrsh7th/cmp-buffer' " Completion
Plug 'hrsh7th/cmp-nvim-lsp' " Completion
Plug 'hrsh7th/cmp-path' " Completion
Plug 'hrsh7th/vim-vsnip' " Snippet engine
Plug 'mrcjkb/rustaceanvim' " Enable some features of rust-analyzer, such as inlay hints and more (similar to simrat39/rust-tools.nvim)
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

" Remap insert mode escape in :term while leaving fzf to its default
if has("nvim")
  au TermOpen * tnoremap <buffer> <C-[> <C-\><C-n>
  au FileType fzf silent! tunmap <buffer> <Esc>
  au FileType fzf silent! tunmap <buffer> <C-[>
endif

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

"" CTags

let g:gutentags_generate_on_empty_buffer = 1
let g:gutentags_ctags_exclude = ['*.js', '*.json', '*.md', '*.svg', '*.xml', '*/bin/*', '*/log/*', '*/node_modules/*', '*/bower_components/*', '*/vendor/*', '*/public/*']
let g:gutentags_file_list_command = 'git ls-files'
let g:gutentags_cache_dir = '~/.tags'
let g:tagbar_sort = 0

"" LSP

lua <<EOF
  local nvim_lsp = require'lspconfig'

  vim.g.rustaceanvim = {
    tools = {
      enable_clippy = true
    },
    server = {
      on_attach = function(client, bufnr)
        vim.keymap.set(
          "n",
          "<C-space>",
          function()
            vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
            -- or vim.lsp.buf.codeAction() if you don't want grouping.
          end,
          { silent = true, buffer = bufnr }
        )
        vim.keymap.set(
          "n",
          "K",  -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
          function()
            vim.cmd.RustLsp({'hover', 'actions'})
          end,
          { silent = true, buffer = bufnr }
        )
      end,
    },
  }

EOF

lua <<EOF
  local cmp = require'cmp'

  cmp.setup({
    -- Enable LSP snippets
    snippet = {
      expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      })
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'path' },
      { name = 'buffer' },
    },
    preselect = false,
    completion = {
      autocomplete = false,
    }
  })
EOF

autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

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

" Disable fzf preview window
let g:fzf_preview_window = ''

" Use fzf with ag in raw mode to allow passing arguments - e.g. `:Ag --ruby 'some search keyword' /some/search/path`
" See https://github.com/junegunn/fzf.vim/issues/27
command! -bang -nargs=+ -complete=file Ag call fzf#vim#ag_raw('--hidden ' . <q-args>, <bang>0)

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

"" Claude

lua <<EOF
  require("parrot").setup({
    providers = {
      anthropic = {
        api_key = os.getenv("CLAUDE_API_KEY"),
      },
    },
  })
EOF

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

" Key bindings for fzf and ag
nnoremap <leader>f :GFiles<CR>
nnoremap <leader>g :Ag<SPACE>
vnoremap <leader>g y:Ag<SPACE>-Q<SPACE>"<C-R>=escape(@",'"')<CR>"<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>j :Tags<CR>
nnoremap <leader>k :BTags<CR>

" fzf-checkout
nnoremap <leader>c :GBranches --locals<CR>

" Clear all buffers
nmap <leader>l :bufdo :bd<CR>

" Open vim-fugitive
nmap <C-g> :G<CR>

" Terminal shortcuts
nmap <leader>s :term<CR>i
nmap <leader>rc :term<CR>ibundle exec rails c<CR>
