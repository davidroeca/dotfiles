filetype plugin indent on
" Vim-Plug {{{
call plug#begin()
Plug 'NLKNguyen/papercolor-theme' " color scheme
"Plug 'tomasr/molokai'
Plug 'itchyny/lightline.vim' " Airline/Powerline replacement
Plug 'rust-lang/rust.vim' " Rust highlights
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " everything go-related
Plug 'derekwyatt/vim-scala' " Scala highlights
Plug 'rgrinberg/vim-ocaml' " ocaml highlights
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
" Waiting on https://github.com/leafgarland/typescript-vim/pull/176
"Plug 'leafgarland/typescript-vim' " ts syntax
Plug 'pappasam/typescript-vim', {
      \ 'branch': 'INDENT_CORRECTLY_MULTILINE_GENERICS'
      \ }
" TSX
Plug 'peitalin/vim-jsx-typescript'
Plug 'evanleck/vim-svelte' "svelte highlights
Plug 'posva/vim-vue' " vue js setup
Plug 'tpope/vim-ragtag' " html tag management
Plug 'jparise/vim-graphql' " graphql highlights
Plug 'groenewege/vim-less'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'airblade/vim-rooter' " roots directory at git repo
Plug 'scrooloose/nerdtree' " file browsing
Plug 'ctrlpvim/ctrlp.vim' " fuzzy file search (like find)
Plug 'dkprice/vim-easygrep' " find/replace across files (like grep/awk)
Plug 'wincent/ferret' " find/replace
" tbone vs slime
Plug 'tpope/vim-tbone'
Plug 'jpalardy/vim-slime'

Plug 'othree/eregex.vim' " needed for perl usage
" Autocompletion installs
"Plug 'davidhalter/jedi-vim' " Python autocompletion
Plug 'jmcantrell/vim-virtualenv' " Python-venv autocompletion
Plug 'racer-rust/vim-racer' " rust autocompletion
"Plug 'ternjs/tern_for_vim', { 'do': 'npm install' } " for js

" For writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" For autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

if has('nvim')
  Plug 'pappasam/vim-filetype-formatter' " running code formatters
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
set exrc

" Combining these two commands sets number for current line and rnu for the
" rest
set number " show line number
set relativenumber " show relative numbers

let &colorcolumn=join(range(80, 5000), ",") " highlight line 81-on
let mapleader="," " change command leader from \ to ,
let maplocalleader="-" " set local command leader to -
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
" Key Remappings {{{
" Defines key remppings as a function that can be called again if need be
function! GlobalKeyRemap()
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

  " Remove highlights after hitting escape
  nnoremap <silent> <Esc> :noh<CR><Esc>

  " Move current line down
  nnoremap <Leader>- ddp
  " Move current line up
  nnoremap <Leader>_ kddpk

  " Capitalize current word in insert mode
  inoremap <c-u> <esc>ebgUeea

  " Mapping to source vimrc
  nnoremap <Leader>sv :source $MYVIMRC<cr>

  " mapping to edit vimrc
  nnoremap <Leader>ev :edit $MYVIMRC<cr>

  " mapping to run goyo
  nnoremap <Leader>go :Goyo<cr>:Limelight!!0.8<cr>

  " Remap H and L to go to beginning and end of line
  nnoremap H 0
  nnoremap L $

  " Remove arrow keys
  nnoremap <Up> <nop>
  nnoremap <Down> <nop>
  nnoremap <Left> <nop>
  nnoremap <Right> <nop>
  inoremap <Up> <nop>
  inoremap <Down> <nop>
  inoremap <Left> <nop>
  inoremap <Right> <nop>
  vnoremap <Up> <nop>
  vnoremap <Down> <nop>
  vnoremap <Left> <nop>
  vnoremap <Right> <nop>

  " Selected search
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

  " Filetype format mappings
  nnoremap <Leader>f :FiletypeFormat<CR>
  vnoremap <Leader>f :FiletypeFormat<CR>
  " NERDTree mappings
  nnoremap <silent> <space>j :NERDTreeToggle %<CR>
endfunction

call GlobalKeyRemap()
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
" TSX is pretty broken for this plugin
let g:vim_jsx_pretty_disable_tsx = v:true
" Used for vim-jsx-prettier
let g:vim_jsx_pretty_colorful_config = 1


" }}}
" Vim Python {{{
let g:python_highlight_space_errors = 0
let g:python_highlight_all = 1
" }}}
" Vim Markdown ----------------- {{{
let g:markdown_frontmatter = v:true
let g:markdown_toml_frontmatter = v:true
let g:markdown_json_frontmatter = v:true
let g:vim_markdown_strikethrough = v:true
let g:no_default_key_mappings = v:true

let g:vim_markdown_folding_disabled = v:true
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
" }}}
" CTRLP {{{
let g:ctrlp_working_path_mode = 'rw' " start from cwd
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" open first in current window and others as hidden
let g:ctrlp_open_multiple_files = '1r'
let g:ctrlp_use_caching = 0
" }}}
" Ragtag {{{

" Load mappings on every filetype
let g:ragtag_global_maps = 1

" Additional files for whice ragtag will initialize
augroup ragtag_config
  autocmd!
  autocmd FileType javascript call RagtagInit()
  autocmd FileType svelte call RagtagInit()
augroup end

" }}}
" Slime {{{
let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
" }}}
" Auto-completion configuration {{{
" Remapping - defenition jump = <C-]>
" Return - <C-o>
" Rust/Racer config
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1
" }}}
" Language Server Configuration {{{

" For coc
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"let g:LanguageClient_serverCommands = {
      "\ 'ocaml': ['ocaml-language-server --stdio'],
      "\ 'python': ['jedi-language-server'],
      "\ 'rust': ['rls'],
      "\ 'javascript': ['npx', 'flow', 'lsp'],
      "\ 'javascript.jsx': ['npx', 'flow', 'lsp'],
      "\ 'typescript': ['npx', 'typescript-language-server', '--stdio'],
      "\ 'typescript.tsx': ['npx', 'typescript-language-server', '--stdio'],
      "\ 'svelte': ['svelteserver'],
      "\ }
"let g:LanguageClient_autoStart = 1
"let g:LanguageClient_hoverPreview = 'Auto'
"let g:LanguageClient_diagnosticsEnable = 0

"function! ConfigureLanguageClient()
  "if has_key(g:LanguageClient_serverCommands, &filetype)
    "nnoremap <buffer> <C-]> :call LanguageClient#textDocument_definition()<CR>
    "nnoremap <buffer> <leader>sd :call LanguageClient#textDocument_hover()<CR>
    "nnoremap <buffer> <leader>sr :call LanguageClient#textDocument_rename()<CR>
    "nnoremap <buffer> <leader>su :call LanguageClient#textDocument_references()<CR>
    "setlocal omnifunc=LanguageClient#complete
  "endif
"endfunction

"augroup language_servers
  "autocmd FileType * call ConfigureLanguageClient()
"augroup END

" }}}
" easy grep {{{
let g:EasyGrepCommand = 1 " use grep, NOT vimgrep
let g:EasyGrepJumpToMatch = 0 " Do not jump to the first match
let g:EasyGrepPerlStyle = 1
" }}}
" eregex {{{
let g:eregex_default_enable = 0
" }}}
 "Filetype-specific settings {{{

augroup js_recognition
  autocmd!
  autocmd BufNewFile,BufFilePre,BufRead *.gs set filetype=javascript
  autocmd BufNewFile,BufFilePre,BufRead *.js.flow set filetype=javascript
augroup END
augroup jsx_recognition
  autocmd!
  autocmd BufNewFile,BufFilePre,BufRead *.jsx set filetype=javascript.jsx
augroup END
augroup tsx_recognition
  autocmd!
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
augroup END
augroup c_inc_recognition
  autocmd!
  autocmd BufNewFile,BufFilePre,BufRead *.c.inc set filetype=c
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

augroup less_filetype
  autocmd!
  autocmd BufNewFile,BufFilePre,BufRead *.less set filetype=less
augroup END

" Finds headers in markdown and restructured text
augroup md_rst_header
  autocmd!
  autocmd FileType markdown,rst onoremap ih :<c-u>execute "normal! ?^[=-][=-]\\+$\r:nohlsearch\rkvg_"<cr>
  autocmd FileType markdown,rst onoremap ah :<c-u>execute "normal! ?^[=-][=-]\\+$\r:nohlsearch\rg_vk0"<cr>
augroup END
augroup writing
  autocmd!
  autocmd FileType markdown,rst,text,gitcommit setlocal wrap linebreak nolist
augroup END
augroup marker_folding
  autocmd!
  autocmd Filetype vim setlocal foldmethod=marker
  autocmd Filetype zsh setlocal foldmethod=marker
augroup END
" Fix 'comments' for typescript. Fixes the >>>>> bug for generics.
augroup ts_generics_comments_bug
  autocmd!
  autocmd FileType typescript.tsx,typescript
        \ setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
augroup END

augroup indentation_DR
  autocmd!
  autocmd Filetype python setlocal shiftwidth=4 softtabstop=4 tabstop=4
  autocmd Filetype c setlocal shiftwidth=4 softtabstop=4 tabstop=4
  autocmd Filetype terraform setlocal shiftwidth=4 softtabstop=4 tabstop=4
  autocmd Filetype dot setlocal autoindent cindent
augroup END

augroup fix_whitespace_save
  autocmd!
  let blacklist = ['markdown', 'markdown.pandoc']
  autocmd BufWritePre * if index(blacklist, &ft) < 0 | execute ':FixWhitespace'
augroup END
" }}}
" {{{
" Prevents .nvimrcs and .exrcs from running not as the user
set secure
" }}}
