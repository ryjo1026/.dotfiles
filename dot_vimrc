" Settings ------------------------------------------------
" Make backspace work
set backspace=indent,eol,start

" Disable writing backup files
set nobackup
set nowritebackup

" Show regex matches during incremental search
set is hls

" Shortcuts ------------------------------------------------
" Tabs convert to 4 spaces
filetype plugin indent on
syntax enable
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" Map Alt+j/k to move lines up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Habit breaking
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Visuals --------------------------------------------------
colorscheme onedark                 " Load onedark theme (joshdick/onedark)
set number                          " Add line numbers
set colorcolumn=110                 " Add a line cuttoff at 110 characters
highlight ColorColumn ctermbg=darkgray

