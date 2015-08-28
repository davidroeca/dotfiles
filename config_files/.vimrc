" -------------------------------------------
" Non-Plugin Personal Customization
" -------------------------------------------
syntax enable 
set background=dark
set tabstop=4
set softtabstop=4
set expandtab " tabs are spaces
" set number " shows line number
set showcmd " show previous command
set cursorline  " highlights current line
set incsearch " search as characters are entered
set hlsearch "highlight matches"
set virtualedit=onemore

" -------------------------------------------
" Below is for Vundle Package
" -------------------------------------------
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'gmarik/vundle'
call vundle#end()
" Now we can turn our filetype functionality back on
filetype plugin indent on

