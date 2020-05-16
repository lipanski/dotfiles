"" Plugins
"" Call `:PlugInstall` every time you add a new plugin

"" Install vim-plug if missing
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'airblade/vim-gitgutter' " Gutter with line modification icons
Plug 'airblade/vim-rooter' " Automatically set pwd to git repo root
Plug 'bling/vim-bufferline'
Plug 'janko-m/vim-test'
Plug 'junegunn/goyo.vim'
Plug 'morhetz/gruvbox'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
Plug 'pearofducks/ansible-vim'
Plug 'rhysd/vim-crystal'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'
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
let g:strip_whitespace_confirm = 1

"" Search

set nohlsearch
set incsearch
set ignorecase
set smartcase

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable("ag")
  " Use Ag over Grep
  set grepprg=ag\ --vimgrep
  set grepformat=%f:%l:%c%m

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    " nnoremap \ :Ag<SPACE>
  endif

  function! FindFiles(...)
    return system('ag --vimgrep -g ' . join(a:000, ' ') . ' | sed -e "s/$/:0:0/"')
  endfunction
  command! -nargs=+ -complete=file -bar Agf cgetexpr FindFiles(<f-args>)|cwindow|redraw!
endif

"" Directory tree

let g:netrw_liststyle = 3
let g:netrw_banner = 0

" Perform a case-insensitive sort
let g:netrw_sort_options = "i"

" Hide gitignored files and other common patterns
let g:netrw_list_hide = netrw_gitignore#Hide() . 'node_modules/,\.bundle/,\.git/'

"" Custom commands

command! -nargs=+ FindAll execute "vimgrep /" . <q-args> . "/j **" | execute "cw"

" Remove current file and close buffer
command! Rm execute ":call delete(expand('%')) | bd!"

" Spell checking
command! English execute "setlocal spell spelllang=en_gb"
command! German execute "setlocal spell spelllang=de_de"

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
nmap <silent> <leader>tT :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

" Browse through search results faster
nmap <silent> <RIGHT> :cnext<CR>
nmap <silent> <LEFT> :cprev<CR>

