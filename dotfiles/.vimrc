filetype plugin indent on
" Vim-Plug {{{
call plug#begin()
Plug 'NLKNguyen/papercolor-theme' " color scheme
"Plug 'tomasr/molokai'
Plug 'itchyny/lightline.vim' " Airline/Powerline replacement
Plug 'rust-lang/rust.vim' " Rust highlights
Plug 'derekwyatt/vim-scala' " Scala highlights
Plug 'cespare/vim-toml'
Plug 'elzr/vim-json'
Plug 'autowitch/hive.vim'
Plug 'scrooloose/nerdcommenter' " for quick commenting
Plug 'hashivim/vim-terraform' " for terraform highlights
Plug 'pearofducks/ansible-vim' " Ansible highlights
Plug 'godlygeek/tabular' " needed for vim-markdown
Plug 'plasticboy/vim-markdown'
Plug 'martinda/Jenkinsfile-vim-syntax' " For jenkinsfiles
Plug 'vim-scripts/groovyindent-unix' " For groovy indentation

Plug 'ekalinin/Dockerfile.vim' " docker highlights
Plug 'vim-python/python-syntax' " Python highlight improvements
Plug 'Vimjas/vim-python-pep8-indent' " For python
Plug 'bronson/vim-trailing-whitespace' " Highlight trailing whitespace;
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty' " jsx highlights
Plug 'jparise/vim-graphql' " graphql highlights
Plug 'mattn/emmet-vim' " auto-close html and jsx tags
Plug 'groenewege/vim-less'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'airblade/vim-rooter' " roots directory at git repo
Plug 'scrooloose/nerdtree' " file browsing
Plug 'ctrlpvim/ctrlp.vim' " fuzzy file search (like find)
Plug 'dkprice/vim-easygrep' " find/replace across files (like grep/awk)
Plug 'wincent/ferret' " find/replace

Plug 'othree/eregex.vim' " needed for perl usage
" Autocompletion installs
"Plug 'davidhalter/jedi-vim' " Python autocompletion
Plug 'jmcantrell/vim-virtualenv' " Python-venv autocompletion
Plug 'racer-rust/vim-racer' " rust autocompletion
"Plug 'ternjs/tern_for_vim', { 'do': 'npm install' } " for js

if has('nvim')
  Plug 'pappasam/vim-filetype-formatter' " running code formatters
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
endif

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
" Colorschemes {{{
syntax enable
set t_Co=256 " sets color count for terminal
set background=dark
let g:PaperColor_Theme_Options = {
  \ 'theme': {
  \   'default.dark': {
  \     'override': {
  \       'color00': ['#000a1c', ''],
  \       'linenumber_bg': ['#000a1c', ''],
  \     }
  \   }
  \ },
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
" lightline config {{{
let g:lightline = {
  \ 'colorscheme': 'PaperColor'
  \ }
" }}}
" Vim terraform {{{
let g:terraform_align = 1
" }}}
" Vim JS {{{
let g:javascript_plugin_flow = 1
let g:used_javascript_libs = 'jquery,requirejs,react'
" Used for vim-jsx-prettier
let g:vim_jsx_pretty_colorful_config = 1
" emmet configuration
let g:user_emmet_settings = {
  \ 'javascript': {
  \   'extends': 'jsx',
  \ },
  \}

" }}}
" Vim Python {{{
let g:python_highlight_space_errors = 0
let g:python_highlight_all = 1
" }}}
" Vim Markdown ----------------- {{{
let g:vim_markdown_folding_disabled=1
" }}}
" Vim Rooter {{{
" silence the cwd
let g:rooter_silent_chdir = 1
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
"let g:jedi#smart_auto_mappings = 0
"let g:jedi#popup_on_dot = 0
"let g:jedi#show_call_signatures = 0
"let g:jedi#auto_vim_configuration = 0
"let g:jedi#goto_command = "<C-]>"
" Rust/Racer config
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1

" Javascript edits
"let g:tern_show_signature_in_pum = 1

"augroup javascript_complete
  "autocmd!
  "autocmd FileType javascript nnoremap <buffer> <C-]> :TernDef<CR>
"augroup END
" }}}
" Language Server Configuration {{{
" deoplete will asynchronously add autocompletion popups
" TODO: it's mildly annoying but the only thing that works with flow lsp
let g:deoplete#enable_at_startup = 1
let g:LanguageClient_serverCommands = {
      \ 'python': ['pyls'],
      \ 'javascript': ['flow', 'lsp'],
      \ 'javascript.jsx': ['flow', 'lsp'],
      \ }
let g:LanguageClient_autoStart = 1
let g:LanguageClient_hoverPreview = 'Auto'
let g:LanguageClient_diagnosticsEnable = 0

function! ConfigureLanguageClient()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <buffer> <C-]> :call LanguageClient#textDocument_definition()<CR>
    nnoremap <buffer> <leader>sd :call LanguageClient#textDocument_hover()<CR>
    nnoremap <buffer> <leader>sr :call LanguageClient#textDocument_rename()<CR>
    nnoremap <buffer> <leader>su :call LanguageClient#textDocument_references()<CR><Paste>
    setlocal omnifunc=LanguageClient#complete
  endif
endfunction

augroup language_servers
  autocmd FileType * call ConfigureLanguageClient()
augroup END

" }}}
" Key Remappings {{{
nnoremap tn :tabnext<CR>
nnoremap tp :tabprev<CR>
nnoremap tc :tabnew<CR>
nnoremap td :tabclose<CR>
" Omnicompletion
" <C-@> actually means ctrl+space
inoremap <C-@> <C-x><C-o>
" Needed for neovim
inoremap <C-space> <C-x><C-o>
inoremap <silent> <C-c> <Esc>:pclose <BAR> helpclose<CR>a
nnoremap <silent> <C-c> :pclose <BAR> helpclose<CR>
inoremap <silent> <C-c> <Esc>:cclose <BAR> lclose<CR>a
nnoremap <silent> <C-c> :cclose <BAR> lclose<CR>

" Remove highlights after hitting escape
nnoremap <silent> <Esc> :noh<CR><Esc>

" }}}
" easy grep {{{
let g:EasyGrepCommand = 1 " use grep, NOT vimgrep
let g:EasyGrepJumpToMatch = 0 " Do not jump to the first match
let g:EasyGrepPerlStyle = 1
" }}}
" eregex {{{
let g:eregex_default_enable = 0
" }}}
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

" Combining these two commands sets number for current line and rnu for the
" rest
set number " show line number
set relativenumber " show relative numbers

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
" disable swap files until https://github.com/neovim/neovim/issues/8137
set noswapfile
" }}}
 "Filetype-specific settings {{{

augroup js_recognition
  autocmd!
  autocmd BufNewFile,BufFilePre,BufRead *.gs set filetype=javascript
augroup END
augroup jsx_recognition
  autocmd!
  autocmd BufNewFile,BufFilePre,BufRead *.jsx set filetype=javascript.jsx
augroup END
augroup c_inc_recognition
  autocmd!
  autocmd BufNewFile,BufFilePre,BufRead *.c.inc set filetype=c
augroup END
augroup marker_folding
  autocmd!
  autocmd Filetype vim setlocal foldmethod=marker
  autocmd Filetype zsh setlocal foldmethod=marker
augroup END


augroup indentation_DR
  autocmd!
  autocmd Filetype python setlocal shiftwidth=4 softtabstop=4 tabstop=4
  autocmd Filetype c setlocal shiftwidth=4 softtabstop=4 tabstop=4
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
  autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
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
