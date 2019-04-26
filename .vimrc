"""""""""""""""""""""""""""""
" => VimPlug Stuff
"""""""""""""""""""""""""""""

call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'vimwiki/vimwiki'
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'jelera/vim-javascript-syntax'
Plug 'prettier/vim-prettier', { 'do': 'yarn install'}
Plug 'jiangmiao/auto-pairs'
Plug 'lifepillar/vim-mucomplete'

call plug#end()

set completeopt+=noinsert
set shortmess+=c "shut off completion messages
set belloff+=ctrlg "if vim beeps

"Disable Arrow Keys, THE TRAINING WHEELS ARE OFF
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

set number
set nocompatible
let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md' }]
map <F2> :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "right"

""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""
set history=500
filetype plugin on
filetype indent on
let mapleader = ','
nmap <leader>w :w!<cr>
command W w !sudo tee % > /dev/null

""""""""""""""""""""""""""""""""""
" => VIM UI
""""""""""""""""""""""""""""""""""
set so=7
set wildmenu
set ruler
set cmdheight=2
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set hlsearch
set incsearch
set magic
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set foldcolumn=1

"""""""""""""""""""""""""""""""""""
" => Colors + Fonts
"""""""""""""""""""""""""""""""""""
syntax enable
set t_Co=256
set termguicolors
try
    colorscheme gruvbox
catch
endtry
let gruvbox_italic=1
set background=dark
set encoding=utf8

"""""""""""""""""""""""""""""""""""
" => Files, Backups, Undo
"""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""
" => Text, Tab, Indent
"""""""""""""""""""""""""""""""""""
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set lbr
set tw=500
set ai
set si
set wrap


