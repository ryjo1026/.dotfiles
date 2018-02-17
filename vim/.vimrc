set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" ##########################################################
" User Settings (@ryjo1026)
" ##########################################################

" Plugins --------------------------------------------------
Plugin 'chriskempson/base16-vim'    " Install base16 color theme

call vundle#end()            " required
filetype plugin indent on    " required

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
set number
