""""""""""""""""""""
" => VIMRC
""""""""""""""""""""


""""""""""""""""""""
"=> VimPlug
""""""""""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'vimwiki/vimwiki'
Plug 'scrooloose/nerdtree'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/goyo.vim'
Plug 'Shirk/vim-gas'
Plug 'lervag/vimtex'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-syntastic/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim'
Plug 'ycm-core/YouCompleteMe'
Plug 'nvie/vim-flake8'
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'

call plug#end()

"""""""""""""""""""""
" => Movement Keys
"""""""""""""""""""""

"Split navigations with CTRL-HJKL
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Disable Arrow Keys
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>

""""""""""""""""""""
" => General
""""""""""""""""""""

set nocompatible
set history=500
filetype plugin on
filetype indent on
let mapleader = ','
set encoding=utf-8

""""""""""""""""""""
" => Vim UI
""""""""""""""""""""

set number
set so=7 " Tries to keep cursor in middle of screen
set wildmenu
set ruler " Show line and column numbers

""""""""""""""""""""
" => Text, Tab, Indent
""""""""""""""""""""

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set clipboard=unnamed

""""""""""""""""""""
" => Colors + Fonts
""""""""""""""""""""

syntax enable
if (has("termguicolors"))
set termguicolors
endif
set term=xterm-256color
set t_Co=256
let g:solarized_termcolors=16
let g:solarized_contrast="high"
if has('gui_running')
    colorscheme zenburn
else
    set background=dark
    colorscheme solarized
    let g:airline_theme='solarized'
endif
call togglebg#map("<F5>")
if exists('$TMUX')
	let &t_8f="<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b="<Esc>[48;2;%lu;%lu;%lum"
endif

""""""""""""""""""""
" => File, Backup, Swap
""""""""""""""""""""

set nobackup
set nowb
set noswapfile

""""""""""""""""""""
" => Plugin Settings
""""""""""""""""""""

map <F2> :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "right"
let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
let g:SimpylFold_docstring_preview=1
" Auto complete window disapears after done
let g:ycm_autoclose_preview_window_after_completion=1
" Shortcut for definitions
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR> 
let g:prettier#config#single_quote = 'true'

""""""""""""""""""""
" => Python
""""""""""""""""""""

let python_highlight_all=1

" Virtualenv support for python
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

