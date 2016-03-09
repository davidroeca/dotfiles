" vim:fdm=marker
" Vundle Package {{{
" Fix incompatibilities
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tomasr/molokai'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'wting/rust.vim'
Plugin 'elzr/vim-json'
Plugin 'autowitch/hive.vim'
Plugin 'scrooloose/nerdcommenter' " for quick commenting
Plugin 'hashivim/vim-terraform' " for terraform highlights
call vundle#end()
filetype plugin indent on
" }}}
" Non-Plugin Personal Customization {{{
set tabstop=2
set softtabstop=2
set shiftwidth=2
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
set number " show line number
let &colorcolumn=join(range(81, 1000), ",") " highlight line 81-on
let mapleader="," " change command leader from \ to ,
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
    autocmd Filetype python setlocal shiftwidth=4 softtabstop=4 tabstop=4
    autocmd Filetype dot setlocal autoindent cindent
augroup END

augroup hive_files
    autocmd!
    autocmd BufNewFile,BufRead *.hql set filetype=hive expandtab
    autocmd BufNewFile,BufRead *.q set filetype=hive expandtab
augroup END
" }}}
" Plugin settings for powerline ----------------- {{{
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9                               
set laststatus=2                                                                
" }}}
