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
Plug 'bling/vim-bufferline'
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'morhetz/gruvbox'
Plug 'natebosch/vim-lsc'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
Plug 'pearofducks/ansible-vim'
Plug 'rhysd/vim-crystal'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tmsvg/pear-tree' " Close parenthesis, curly braces etc.
Plug 'tpope/vim-endwise' " Automatically insert `end` in code blocks
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired' " Navigation shortcuts: [q / ]q quickfix list, [b / ]b buffer list, [p / ]p paste above or below line, [<Space> / ]<Space> add a blank line
Plug 'vim-ruby/vim-ruby'
Plug 'vimwiki/vimwiki'
call plug#end()

"" General

syntax on

set encoding=utf-8

set number

" Theme
colorscheme gruvbox
set background=dark

" Always display the status line
set laststatus=2

" Customize the status line
set statusline=%<%f\ %#PmenuSel#%h%m%r%{FugitiveStatusline()}%#CursorColumn#%=%y\ \ %l,%c\ \ %P

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
  au FileType fzf tunmap <buffer> <Esc>
endif

"" Whitespace

set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set fixendofline
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 1

"" Search

set nohlsearch
set incsearch

" All searches are case insensitive except when search contains one upper case letter
" set ignorecase
" set smartcase

"" Code completion

" Install with `gem install solargraph` (globally)
if executable("solargraph")
  let g:lsc_server_commands = {
  \  'ruby': {
  \    'command': 'solargraph stdio',
  \    'log_level': -1,
  \    'suppress_stderr': v:true,
  \  }
  \}
endif

let g:lsc_auto_map = {
 \  'GoToDefinition': 'gd',
 \  'FindReferences': 'gr',
 \  'Rename': 'gR',
 \  'ShowHover': 'K',
 \  'FindCodeActions': 'ga',
 \  'Completion': 'omnifunc',
 \}

let g:lsc_enable_autocomplete  = v:true
let g:lsc_enable_diagnostics   = v:false
let g:lsc_reference_highlights = v:false
let g:lsc_trace_level          = 'off'

" Completion for parenthesis, curly braces etc.
let g:pear_tree_repeatable_expand = 0
let g:pear_tree_smart_backspace   = 1
let g:pear_tree_smart_closers     = 1
let g:pear_tree_smart_openers     = 1

" Never auto-select entries when displaying the autocomplete menu
set completeopt=menu,menuone,noinsert,noselect

" Disalbe fzf preview window
let g:fzf_preview_window = ''

" Key bindings for fzf and ag
nnoremap <leader>f :GFiles<CR>
nnoremap <leader>g :Ag<SPACE>
vnoremap <leader>g y:Ag<SPACE>-Q<SPACE>"<C-R>=escape(@",'"')<CR>"<CR>
nnoremap <leader>b :Buffers<CR>

" Use fzf with ag in raw mode to allow passing arguments - e.g. `:Ag --ruby 'some search keyword' /some/search/path`
" See https://github.com/junegunn/fzf.vim/issues/27
command! -bang -nargs=+ -complete=file Ag call fzf#vim#ag_raw(<q-args>, <bang>0)

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable("ag")
  " Use Ag over Grep
  set grepprg=ag\ --vimgrep
  set grepformat=%f:%l:%c:%m

  " if !exists(":Ag")
    " command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    " nnoremap // :Ag<SPACE>
    " vnoremap // y:Ag<SPACE><C-R>=escape(@",'/\')<CR><CR>
  " endif

  " function! FindFiles(...)
    " return system('ag --vimgrep -g ' . join(a:000, ' ') . ' | sed -e "s/$/|1|  /"')
  " endfunction
  " command! -nargs=+ -complete=file -bar Agf cgetexpr FindFiles(<f-args>)|cwindow|redraw!
  " nnoremap /f :Agf<SPACE>
endif

" Snippets
let g:UltiSnipsExpandTrigger="<c-s>"

"" Directory tree

let g:netrw_liststyle = 3
let g:netrw_banner = 0

" Perform a case-insensitive sort
let g:netrw_sort_options = "i"

" Hide gitignored files and other common patterns
let g:netrw_list_hide = netrw_gitignore#Hide() . 'node_modules/,\.bundle/,\.git/'

"" NERDTree

" Toggle NERDTree with Ctrl-n
map <C-n> :NERDTreeToggle<CR>

" Open NERDTree automatically when vim starts if no file was specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"" Custom commands

" command! -nargs=+ FindAll execute "vimgrep /" . <q-args> . "/j **" | execute "cw"

" Remove current file and close buffer
" command! Rm execute ":call delete(expand('%')) | bd!"

" Spell checking
command! English execute "setlocal spell spelllang=en_gb"
command! German execute "setlocal spell spelllang=de_de"

"" Wiki

let g:vimwiki_list = [{'path': '~/Dropbox/wiki/', 'syntax': 'markdown', 'ext': '.md'}]

" Sitck to the vimwiki_list, don't create temporary wikis within the project directory
let g:vimwiki_global_ext = 0

"" Key bindings

" Window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Window resize
" nnoremap <C-Right> :vertical resize +2<CR>
" nnoremap <C-Left> :vertical resize -2<CR>
" nnoremap <C-Up> :resize +2<CR>
" nnoremap <C-Down> :resize -2<CR>

" vim-test bindings
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

