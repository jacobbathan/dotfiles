call plug#begin("$XDG_CONFIG_HOME/nvim/plugged")
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'chrisbra/csv.vim'
call plug#end()


" Allow paste from system clipboard
set clipboard+=unnamedplus

" no stupid swapfiles
set noswapfile

" Set massive undo file for when mistakes are too grandiose
set undofile
set undodir=$HOME/.config/nvim/undo
set undolevels=10000
set undoreload=10000

" numbers
set number

" 4 spaces instead of tabs,
" copy indent from current line
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set hidden

nnoremap <space> <nop>
let mapleader = "\<space>"

nnoremap <leader>bn :bn<cr> ;buffer next
nnoremap <leader>tn gt ;new tab

augroup filetype_csv
    autocmd!

    autocmd BufRead,BufWritePost *.csv :%ArrangeColumn!
    autocmd BufWritePre *.csv :%UnArrangeColumn
augroup END
