set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdtree-git-plugin'
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'ryanoasis/vim-devicons'
Plugin 'srcery-colors/srcery-vim'

call vundle#end()

map <C-n> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

set laststatus=2
set showtabline=2
set noshowmode
set t_Co=256

syntax on
filetype plugin indent on

colorscheme srcery
