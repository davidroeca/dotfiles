" vim:fdm=marker
" Vundle Package {{{
" Fix incompatibilities
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tomasr/molokai'
Plugin 'wting/rust.vim'
Plugin 'elzr/vim-json'
Plugin 'autowitch/hive.vim'
call vundle#end()
filetype plugin indent on
" }}}
" Non-Plugin Personal Customization {{{
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab " tabs are spaces
set ruler " shows line and column number
" set number " shows line number
set showcmd " show previous command
set cursorline  " highlights current line
set incsearch " search as characters are entered
set hlsearch " highlight matches
set virtualedit=onemore " gives you access to one more space on a line
set wildmenu " allows graphical cycling through command options
set lazyredraw " redraw screen only when necessary
set showmatch " highlight matching [{()}]
" }}}
" Colorschemes {{{
syntax enable 
set t_Co=256 " sets color count for terminal
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai
" }}}
" Filetype-specific settings {{{
augroup indentation_DR
    autocmd!
    autocmd Filetype dot :setlocal autoindent cindent
augroup END

augroup hive_files
    autocmd!
    autocmd BufNewFile,BufRead *.hql set filetype=hive expandtab
    autocmd BufNewFile,BufRead *.q set filetype=hive expandtab
augroup END
" }}}
