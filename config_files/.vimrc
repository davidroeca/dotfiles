" -------------------------------------------
" Non-Plugin Personal Customization
" -------------------------------------------
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab " tabs are spaces
set ruler " shows line and column number
" set number " shows line number
set showcmd " show previous command
set cursorline  " highlights current line
set incsearch " search as characters are entered
set hlsearch "highlight matches"
set virtualedit=onemore

" -------------------------------------------
" Vundle Package
" -------------------------------------------
" Fix incompatibilities
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/

call vundle#begin()
Plugin 'gmarik/vundle'
Plugin 'tomasr/molokai'
call vundle#end()
filetype plugin indent on

syntax enable 
set t_Co=256 " sets color count for terminal
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai
