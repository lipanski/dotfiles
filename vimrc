"" Plugins
"" Requires `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
"" Call `:PluginInstall` every time you add a new plugin

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'janko-m/vim-test'
Plugin 'airblade/vim-gitgutter' " Gutter with line modification icons
Plugin 'airblade/vim-rooter' " Automatically set pwd to git repo root
Plugin 'pearofducks/ansible-vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'rhysd/vim-crystal'
Plugin 'morhetz/gruvbox'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tpope/vim-fugitive'
Plugin 'terryma/vim-multiple-cursors'
call vundle#end()
filetype plugin indent on

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
set wildmode=longest,list

" Disable last line that shows current mode
set noshowmode

" Undo always works
set hidden

" Always use vertical diffs
set diffopt+=vertical

"" Whitespace

set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set fixendofline
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 1

"" Search

set hlsearch
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
  command! -nargs=+ -complete=file -bar FF cgetexpr FindFiles(<f-args>)|cwindow|redraw!
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

