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
