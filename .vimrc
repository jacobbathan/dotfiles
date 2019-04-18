call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'vimwiki/vimwiki'
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'jelera/vim-javascript-syntax'
Plug 'prettier/vim-prettier', { 'do': 'yarn install'}
Plug 'wakatime/vim-wakatime'
Plug 'jiangmiao/auto-pairs'

call plug#end()


" Disable Arrow Keys, THE TRAINING WHEELS ARE OFF
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

let g:gruvbox_italic=1
set termguicolors
set background=dark
syntax enable
set number
set nocompatible
filetype plugin on
set t_Co=256
colorscheme gruvbox
set guifont=Consolas:h10
set tabstop=4 "tab will space 4 times
let mapleader=","
let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md' }]
map <F2> :NERDTreeToggle<CR>
