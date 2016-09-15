filetype plugin indent on
" Vim-Plug {{{
call plug#begin()
Plug 'tomasr/molokai'
Plug 'vim-airline/vim-airline'
Plug 'rust-lang/rust.vim'
Plug 'elzr/vim-json'
Plug 'autowitch/hive.vim'
Plug 'scrooloose/nerdcommenter' " for quick commenting
Plug 'hashivim/vim-terraform' " for terraform highlights
Plug 'pearofducks/ansible-vim' " Ansible highlights
Plug 'godlygeek/tabular' " needed for vim-markdown
Plug 'plasticboy/vim-markdown'
Plug 'hynek/vim-python-pep8-indent' " For python
Plug 'bronson/vim-trailing-whitespace' " Highlight trailing whitespace;
Plug 'pangloss/vim-javascript', {'branch': 'develop'}
Plug 'mxw/vim-jsx'
Plug 'groenewege/vim-less'
Plug 'othree/javascript-libraries-syntax.vim'
" FixWhitespace fixes this
call plug#end()
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
 "Filetype-specific settings {{{
let g:used_javascript_libs = 'jquery,requirejs,react'
let g:jsx_ext_required = 0
augroup jsx_recognition
  autocmd!
  autocmd BufNewFile,BufFilePre,BufRead *.jsx set filetype=javascript.jsx
augroup END
augroup vim_folding
  autocmd!
  autocmd Filetype vim setlocal foldmethod=marker
augroup END

augroup indentation_DR
  autocmd!
  autocmd Filetype python setlocal shiftwidth=4 softtabstop=4 tabstop=4
  autocmd Filetype dot setlocal autoindent cindent
augroup END

augroup hive_files
  autocmd!
  autocmd BufNewFile,BufFilePre,BufRead *.hql set filetype=hive expandtab
  autocmd BufNewFile,BufFilePre,BufRead *.q set filetype=hive expandtab
augroup END

augroup md_markdown
  autocmd!
  autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
augroup END

augroup md_markdown
  autocmd!
  autocmd BufNewFile,BufFilePre,BufRead *.less set filetype=less
augroup END

augroup fix_whitespace_save
  let blacklist = ['markdown']
  autocmd BufWritePre * if index(blacklist, &ft) < 0 | execute ':FixWhitespace'
augroup END
" }}}
" Plugin settings ----------------- {{{
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2
let g:vim_markdown_folding_disabled=1
" }}}
