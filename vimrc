"" Plugins
""
"" Requires `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
"" Call `:PluginInstall` every time you add a new plugin
""
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'pearofducks/ansible-vim'
Plugin 'ntpeters/vim-better-whitespace'
call vundle#end()
filetype plugin indent on

"" General
syntax on
set encoding=utf-8
set number
set laststatus=2
set noswapfile

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

"" Whitespace
set tabstop=2 shiftwidth=2
set expandtab
set fixendofline
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 1

"" Search
set hlsearch
set incsearch
set ignorecase
set smartcase
set rtp+=~/.fzf

"" Directory tree
let g:netrw_liststyle = 3
let g:netrw_banner = 0
" Perform a case-insensitive sort
let g:netrw_sort_options = "i"

