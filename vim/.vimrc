" Settings ------------------------------------------------
" Make backspace work
set backspace=indent,eol,start

" Disable writing backup files
set nobackup
set nowritebackup

" Shortcuts ------------------------------------------------
" Tabs convert to 4 spaces
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" Habit breaking
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Visuals --------------------------------------------------
syntax on                           " Always turn on syntax highlighting (TODO only for certain filetypes)
colorscheme onedark                 " Load onedark theme (joshdick/onedark)
set number                          " Add line numbers
set colorcolumn=110                 " Add a line cuttoff at 110 characters
highlight ColorColumn ctermbg=darkgray

