set nocompatible
filetype off

" Check for first run and install if relevant
let vundleInstalled=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  let iCanHazVundle=0
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins --------------------------------------------------
Plugin 'VundleVim/Vundle.vim'
Plugin 'chriskempson/base16-vim'    " base16 color themes

call vundle#end()
filetype plugin indent on

" Install packages if first run
if vundleInstalled == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  :PluginInstall
endif

" ##########################################################
" User Settings (@ryjo1026)
" ##########################################################

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
colorscheme base16-default-dark     " Apply dark theme
syntax on                           " Always turn on syntax highlighting (TODO only for certain filetypes)
set number                          " Add line numbers
set colorcolumn=110                 " Add a line cuttoff at 110 characters
highlight ColorColumn ctermbg=darkgray

