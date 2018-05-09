set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins --------------------------------------------------
Plugin 'VundleVim/Vundle.vim'
Plugin 'chriskempson/base16-vim'    " base16 color themes

call vundle#end()
filetype plugin indent on


" ##########################################################
" User Settings (@ryjo1026)
" ##########################################################

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
colorscheme base16-default-dark     " Apply dark theme
syntax on                           " Always turn on syntax highlighting (TODO only for certain filetypes)
set number                          " Add line numbers
set colorcolumn=110                 " Add a line cuttoff at 110 characters
highlight ColorColumn ctermbg=darkgray
