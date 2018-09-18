filetype plugin indent on
 "Non-Plugin Personal Customization {{{
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab " tabs are spaces
set ruler " shows line and column number
set showcmd " show previous command
set cursorline  " highlights current line
set incsearch " search as characters are entered
set hlsearch " highlight matches
set virtualedit=onemore " gives you access to one more space on a line
set wildmenu " allows graphical cycling through command options
set lazyredraw " redraw screen only when necessary
set showmatch " highlight matching [{()}]
set number " show line number
let &colorcolumn=join(range(80, 5000), ",") " highlight line 81-on
let mapleader="," " change command leader from \ to ,
" Powerline
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2
" easygrep
set grepprg=git\ grep\ -n\ $*
set completeopt=menuone,longest,preview " for jedi vim to turn off auto config
" For rust-racer
set hidden
" }}}
" Vim-Plug {{{
call plug#begin()
Plug 'NLKNguyen/papercolor-theme' " color scheme
"Plug 'tomasr/molokai'
Plug 'powerline/powerline' " Airline replacement
Plug 'rust-lang/rust.vim' " Rust highlights
Plug 'derekwyatt/vim-scala' " Scala highlights
Plug 'cespare/vim-toml'
Plug 'elzr/vim-json'
Plug 'autowitch/hive.vim'
Plug 'scrooloose/nerdcommenter' " for quick commenting
Plug 'hashivim/vim-terraform' " for terraform highlights
Plug 'pearofducks/ansible-vim' " Ansible highlights
"Plug 'godlygeek/tabular' " needed for vim-markdown
"Plug 'plasticboy/vim-markdown'
Plug 'martinda/Jenkinsfile-vim-syntax' " For jenkinsfiles
Plug 'vim-scripts/groovyindent-unix' " For groovy indentation
Plug 'ekalinin/Dockerfile.vim' " docker highlights
Plug 'hdima/python-syntax' " Python highlight improvements
Plug 'hynek/vim-python-pep8-indent' " For python
Plug 'bronson/vim-trailing-whitespace' " Highlight trailing whitespace;
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'jparise/vim-graphql' " graphql highlights
Plug 'groenewege/vim-less'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'airblade/vim-rooter' " roots directory at git repo
Plug 'scrooloose/nerdtree' " file browsing
Plug 'ctrlpvim/ctrlp.vim' " fuzzy file search (like find)
Plug 'dkprice/vim-easygrep' " find/replace across files (like grep/awk)
Plug 'othree/eregex.vim' " needed for perl usage
" Autocompletion installs
Plug 'davidhalter/jedi-vim' " Python autocompletion
Plug 'jmcantrell/vim-virtualenv' " Python-venv autocompletion
Plug 'racer-rust/vim-racer' " rust autocompletion
Plug 'vim-pandoc/vim-pandoc-syntax' " pandoc syntax  highlighting
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' } " for js
" Plugins for plantuml
Plug 'aklt/plantuml-syntax'
Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'

" Nginx
Plug 'nginx/nginx', { 'rtp': 'contrib/vim' }

" Vagrant
Plug 'hashivim/vim-vagrant'

" FixWhitespace fixes this
call plug#end()
" }}}
" Command aliases {{{
cabbrev bt tab sb
cabbrev bv vert sb
cabbrev bs sbuffer

" move tab to number
cabbrev t tabn
"  close help menu
cabbrev hc helpclose
" }}}
" Selected search {{{
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <expr> // 'y/\V'.escape(@",'\').'<CR>'
" }}}
" Key Remappings {{{
nnoremap tn :tabnext<CR>
nnoremap tp :tabprev<CR>
nnoremap tc :tabnew<CR>
nnoremap td :tabclose<CR>
" Omnicompletion
" <C-@> actually means ctrl+space
inoremap <C-@> <C-x><C-o>
inoremap <silent> <C-c> <Esc>:pclose <BAR> helpclose<CR>a
nnoremap <silent> <C-c> :pclose <BAR> helpclose<CR>
inoremap <silent> <C-c> <Esc>:cclose <BAR> lclose<CR>a
nnoremap <silent> <C-c> :cclose <BAR> lclose<CR>

" }}}
" Colorschemes {{{
syntax enable
set t_Co=256 " sets color count for terminal
set background=dark
let g:PaperColor_Theme_Options = {
      \ 'language': {
      \   'python': {
      \     'highlight_builtins': 1
      \    }
      \  }
      \ }

colorscheme PaperColor

" Old molokai stuff
"let g:molokai_original = 1
"let g:rehash256 = 1
"colorscheme molokai
" }}}
 "Filetype-specific settings {{{

 " Terraform globals
let g:terraform_align = 1

 " JS globals
let g:javascript_plugin_flow = 1
let g:used_javascript_libs = 'jquery,requirejs,react'
let g:jsx_ext_required = 0

augroup jsx_recognition
  autocmd!
  autocmd BufNewFile,BufFilePre,BufRead *.jsx set filetype=javascript.jsx
augroup END
augroup marker_folding
  autocmd!
  autocmd Filetype vim setlocal foldmethod=marker
  autocmd Filetype zsh setlocal foldmethod=marker
augroup END

augroup indentation_DR
  autocmd!
  autocmd Filetype python setlocal shiftwidth=4 softtabstop=4 tabstop=4
  autocmd Filetype terraform setlocal shiftwidth=4 softtabstop=4 tabstop=4
  autocmd Filetype dot setlocal autoindent cindent
augroup END

augroup hive_files
  autocmd!
  autocmd BufNewFile,BufFilePre,BufRead *.hql set filetype=hive expandtab
  autocmd BufNewFile,BufFilePre,BufRead *.q set filetype=hive expandtab
augroup END

augroup md_markdown
  autocmd!
  autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

augroup md_less
  autocmd!
  autocmd BufNewFile,BufFilePre,BufRead *.less set filetype=less
augroup END

augroup fix_whitespace_save
  let blacklist = ['markdown', 'markdown.pandoc']
  autocmd BufWritePre * if index(blacklist, &ft) < 0 | execute ':FixWhitespace'
augroup END
" }}}
" Plugin settings ----------------- {{{
let g:vim_markdown_folding_disabled=1
" }}}
" NERDTree {{{
let g:NERDTreeMapOpenInTab = '<C-t>'
let g:NERDTreeMapOpenSplit = '<C-s>'
let g:NERDTreeMapOpenVSplit = '<C-v>'
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeCaseSensitiveSort = 0
let g:NERDTreeWinPos = 'left'
let g:NERDTreeWinSize = 31
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeIgnore=['venv$[[dir]]', '__pycache__$[[dir]]', 'node_modules$[[dir]]']
nnoremap <silent> <space>j :NERDTreeToggle %<CR>
" }}}
" CTRLP {{{
let g:ctrlp_working_path_mode = 'rw' " start from cwd
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" open first in current window and others as hidden
let g:ctrlp_open_multiple_files = '1r'
let g:ctrlp_use_caching = 0
" }}}
" Auto-completion configuration {{{
" Remapping - defenition jump = <C-]>
" Return - <C-o>
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 0
"let g:jedi#auto_close_doc = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#goto_command = "<C-]>"
"let g:jedi#virtualenv_auto_activate = 1
" Rust/Racer config
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1
" }}}
" easy grep {{{
let g:EasyGrepCommand = 1 " use grep, NOT vimgrep
let g:EasyGrepJumpToMatch = 0 " Do not jump to the first match
let g:EasyGrepPerlStyle = 1
" }}}
" eregex {{{
let g:eregex_default_enable = 0
" }}}
" Pre-startup commands {{{
function! StartUp()
endfunction
autocmd VimEnter * call StartUp()
" }}}
