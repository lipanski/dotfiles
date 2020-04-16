"" Plugins
"" Requires `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
"" Call `:PluginInstall` every time you add a new plugin

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'pearofducks/ansible-vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'janko-m/vim-test'
call vundle#end()
filetype plugin indent on

"" General

syntax on

set encoding=utf-8

set number

" Always display the status line
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
set rtp+=~/.fzf

"" Directory tree

let g:netrw_liststyle = 3
let g:netrw_banner = 0

" Perform a case-insensitive sort
let g:netrw_sort_options = "i"

" Hide gitignored files and other common patterns
let g:netrw_list_hide = netrw_gitignore#Hide() . 'node_modules/,\.bundle/,\.git/'

"" Custom commands

command! -nargs=+ FindAll execute "vimgrep /" . <q-args> . "/j **" | execute "cw"

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
