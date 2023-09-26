filetype plugin indent on
"  Vim-Packager {{{
"
function s:init_packages() abort
  packadd vim-packager
  call packager#init()
  call packager#add('git@github.com:kristijanhusak/vim-packager', {'type': 'opt'})

  call packager#add('git@github.com:tpope/vim-scriptease.git') " color scheme debugging
  call packager#add('git@github.com:tpope/vim-fugitive.git') " git management
  call packager#add('git@github.com:itchyny/lightline.vim.git') " Airline/Powerline replacement
  call packager#add('git@github.com:pangloss/vim-javascript.git') " JS/JSX support
  call packager#add('git@github.com:peitalin/vim-jsx-typescript.git') " TSX support
  call packager#add('git@github.com:rust-lang/rust.vim.git') " Rust highlights
  call packager#add('git@github.com:derekwyatt/vim-scala.git') " Scala highlights
  call packager#add('git@github.com:rgrinberg/vim-ocaml.git') " ocaml highlights
  call packager#add('git@github.com:cespare/vim-toml.git', {'branch': 'main'})
  call packager#add('git@github.com:neoclide/jsonc.vim.git')
  call packager#add('git@github.com:autowitch/hive.vim.git')
  call packager#add('git@github.com:scrooloose/nerdcommenter.git') " for quick commenting
  call packager#add('git@github.com:hashivim/vim-terraform.git') " for terraform highlights
  call packager#add('git@github.com:pearofducks/ansible-vim.git') " Ansible highlights
  call packager#add('git@github.com:martinda/Jenkinsfile-vim-syntax.git') " For jenkinsfiles
  call packager#add('git@github.com:vim-scripts/groovyindent-unix.git') " For groovy indentation

  call packager#add('git@github.com:Vimjas/vim-python-pep8-indent.git') " For python
  call packager#add('git@github.com:ntpeters/vim-better-whitespace.git') " Highlight trailing whitespace;

  call packager#add('git@github.com:evanleck/vim-svelte.git', { 'requires': [
        \ 'https://github.com/pangloss/vim-javascript.git',
        \ 'https://github.com/othree/html5.vim.git',
        \ ]})
  call packager#add('git@github.com:tpope/vim-ragtag.git') " html tag management
  call packager#add('git@github.com:jparise/vim-graphql.git') " graphql highlights
  call packager#add('git@github.com:groenewege/vim-less.git')
  call packager#add('git@github.com:cakebaker/scss-syntax.vim.git')
  call packager#add('git@github.com:airblade/vim-rooter.git') " roots directory at git repo
  call packager#add('git@github.com:scrooloose/nerdtree.git') " file browsing
  call packager#add('git@github.com:ctrlpvim/ctrlp.vim.git') " fuzzy file search (like find)
  call packager#add('git@github.com:wincent/ferret.git') " find/replace

  call packager#add('git@github.com:pappasam/nvim-repl.git', { 'branch': 'main' }) " REPLs

  call packager#add('git@github.com:othree/eregex.vim.git') " needed for perl usage

  " Autocompletion installs
  call packager#add('git@github.com:jmcantrell/vim-virtualenv.git') " Python-venv autocompletion
  call packager#add('git@github.com:racer-rust/vim-racer.git') " rust autocompletion

  " For writing
  call packager#add('git@github.com:junegunn/goyo.vim.git')
  call packager#add('git@github.com:junegunn/limelight.vim.git')

  " For autocompletion
  call packager#add('git@github.com:neoclide/coc.nvim.git', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'})

  call packager#add('git@github.com:pappasam/vim-filetype-formatter.git', { 'branch': 'main' }) " running code formatters

  " Plugins for plantuml
  call packager#add('git@github.com:aklt/plantuml-syntax.git')
  call packager#add('git@github.com:tyru/open-browser.vim.git')
  call packager#add('git@github.com:weirongxu/plantuml-previewer.vim.git')

  " Nginx
  call packager#add('git@github.com:nginx/nginx.git', { 'rtp': 'contrib/vim' })

  " Vagrant
  call packager#add('git@github.com:hashivim/vim-vagrant.git')

  " Syntax highlight support, as well as text objects, etc.
  call packager#add('git@github.com:nvim-treesitter/nvim-treesitter.git')
  call packager#add('git@github.com:nvim-treesitter/playground.git')
  call packager#add('git@github.com:pappasam/papercolor-theme-slim', { 'branch': 'main' }) " color scheme
endfunction

command!       PackInstall call s:init_packages() | call packager#install()
command! -bang PackUpdate  call s:init_packages() | call packager#update({ 'force_hooks': '<bang>' })
command!       PackClean   call s:init_packages() | call packager#clean()
command!       PackStatus  call s:init_packages() | call packager#status()
command! -bang PU          call s:init_packages() | call packager#clean() | call packager#update({ 'force_hooks': '<bang>' })
command!       UpdateAll execute ':PackUpdate' | execute ':CocUpdate' | execute ':TSUpdate'

" }}}
 "Non-Plugin Personal Customization {{{
helptags ~/.config/nvim/doc
let &colorcolumn=join(range(80, 5000), ",") " highlight line 81-on
let mapleader="," " change command leader from \ to ,
let maplocalleader="-" " set local command leader to -
function! ConfigureGlobal()
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
  set exrc " can handle local vimrc/init.vim

  " https://github.com/neoclide/coc.nvim/issues/649
  set nobackup
  set nowritebackup

  " Provides additional info for message output
  set cmdheight=2

  " Helps with diagnostic messages in coc.nvim
  set updatetime=300

  " don't give |ins-completion-menu| messages.
  set shortmess+=c

  " Always show signcolumns - prevents shifting when lint errors pop up
  set signcolumn=yes

  " Combining these two commands sets number for current line and rnu for the
  " rest
  set number " show line number
  set relativenumber " show relative numbers

  " Powerline
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
  set laststatus=2
  " easygrep
  set grepprg=git\ grep\ -n\ $*
  set completeopt=menuone,longest,preview " for jedi vim to turn off auto config
  " Helps keep buffers around when abandoned; helps with plugins that edit
  " multiple buffers such as coc.nvim
  set hidden
  " disable swap files until https://github.com/neovim/neovim/issues/8137
  set noswapfile
endfunction

call ConfigureGlobal()

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
  " NERDTree mappings
  nnoremap <silent> <space>j :NERDTreeToggle %<CR>
  " coc settings
  nnoremap <silent> <C-k> :call <SID>show_documentation()<CR>
  nmap <silent> <C-]> <Plug>(coc-definition)
  nmap <silent> <Leader>st <Plug>(coc-type-definition)
  nmap <silent> <Leader>si <Plug>(coc-implementation)
  nmap <silent> <Leader>su <Plug>(coc-references)
  nmap <silent> <Leader>sr <Plug>(coc-rename)
  " Next and previous items in list
  nnoremap <silent> <Leader>sn :<C-u>CocNext<CR>
  nnoremap <silent> <Leader>sp :<C-u>CocPrev<CR>
  nnoremap <silent> <Leader>sl :<C-u>CocListResume<CR>
  " Show commands
  nnoremap <silent> <Leader>sc :<C-u>CocList commands<CR>
  " Find symbol in current document
  nnoremap <silent> <Leader>ss :<C-u>CocList outline<CR>
  " Search workspace symbols
  nnoremap <silent> <Leader>sw :<C-u>CocList -I symbols<CR>

  " Use <c-space> to trigger completion
  inoremap <silent><expr> <c-space> coc#refresh()

  " Expand snippet
  imap <silent> <expr> <C-l> coc#expandable() ? "<Plug>(coc-snippets-expand)" : "\<C-y>"
  let g:coc_global_extensions = [
        \ 'coc-angular',
        \ 'coc-markdownlint',
        \ 'coc-texlab',
        \ 'coc-go',
        \ 'coc-html',
        \ 'coc-css',
        \ 'coc-json',
        \ 'coc-rls',
        \ 'coc-snippets',
        \ 'coc-tsserver',
        \ 'coc-yaml',
        \ 'coc-jedi',
        \ ]
endfunction

call GlobalKeyRemap()
" }}}
" lightline config {{{
"let g:lightline = {
  "\ 'colorscheme': 'sonokai'
  "\ }
" }}}
" Vim terraform {{{
let g:terraform_align = 1
" }}}
" Vim Python {{{
let g:python_highlight_space_errors = 0
let g:python_highlight_all = 1
" }}}
" Vim Rooter {{{
" silence the cwd
"let g:rooter_silent_chdir = 1
let g:rooter_patterns = ['Cargo.toml', 'package.json', 'pyproject.toml', 'setup.py', 'requirements.txt', '.git', '.git/']
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

" }}}
" easy grep {{{
let g:EasyGrepCommand = 1 " use grep, NOT vimgrep
let g:EasyGrepJumpToMatch = 0 " Do not jump to the first match
let g:EasyGrepPerlStyle = 1
" }}}
" eregex {{{
let g:eregex_default_enable = 0
" }}}
" Filetype formatter {{{
function! s:formatter_python()
  let filename = expand('%:p')
  return printf(
        \ 'ruff check -q --fix-only --stdin-filename="%s" - ' .
        \ '| black -q --stdin-filename="%s" - ' .
        \ '| isort -q --filename="%s" - ' .
        \ '| docformatter -',
        \ filename, filename, filename
        \ )
endfunction
let g:vim_filetype_formatter_commands = {
      \ 'python': funcref('s:formatter_python')
      \ }

" }}}
 "Filetype-specific settings {{{

augroup c_inc_recognition
  autocmd!
  autocmd BufEnter *.c.inc set filetype=c
augroup END
augroup hive_files
  autocmd!
  autocmd BufEnter *.hql set filetype=hive expandtab
  autocmd BufEnter *.q set filetype=hive expandtab
augroup END

augroup mermaid
  autocmd!
  autocmd BufEnter *.mmd,*.mmdc,*.mermaid set filetype=mermaid
augroup END

augroup less_filetype
  autocmd!
  autocmd BufEnter *.less set filetype=less
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
"augroup ts_generics_comments_bug
  "autocmd!
  "autocmd FileType typescript.tsx,typescript,typescriptreact
        "\ setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
"augroup END

augroup indentation_DR
  autocmd!
  autocmd Filetype python setlocal shiftwidth=4 softtabstop=4 tabstop=4
  autocmd Filetype c setlocal shiftwidth=4 softtabstop=4 tabstop=4
  autocmd Filetype dot setlocal autoindent cindent
augroup END

" }}}
" setting secure {{{
" Prevents .nvimrcs and .exrcs from running not as the user
set secure
" }}}
" Vim Better Whitespace {{{

let g:better_whitespace_filetypes_blacklist = [
      \ 'diff',
      \ 'git',
      \ 'gitcommit',
      \ 'unite',
      \ 'qf',
      \ 'help',
      \ 'markdown',
      \ 'markdown.pandoc',
      \ 'fugitive'
      \ ]

let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save = 0

augroup strip_whitespace
  autocmd! BufWritePre * if index(g:better_whitespace_filetypes_blacklist, &ft) < 0 | execute ':StripWhitespace'
augroup END

" }}}
" VimEnter call {{{

function! HandleVimEnter()
lua <<EOF
require('nvim-treesitter.configs').setup({
  highlight = { enable = true },
  ensure_installed = {
    'css',
    'dockerfile',
    'graphql',
    'html',
    'javascript',
    'rust',
    'tsx',
    'svelte',
    'json',
    'jsdoc',
    'typescript',
    'query',
    'markdown',
    'mermaid',
  },
})
EOF
endfunction
augroup vimenter
  autocmd! VimEnter * call HandleVimEnter()
augroup END
function! HandleSyntaxSetup()
  syntax enable
  set t_Co=256 " sets color count for terminal
  if has('termguicolors')
    set termguicolors
  endif
  "let g:sonokai_enable_italic = 1
  "let g:sonokai_transparent_background = 1
  "colorscheme sonokai

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

  colorscheme PaperColorSlim
  "colorscheme PaperColor
  " vim-better-whitespace highlight config, after paper color setup
  highlight ExtraWhitespace guibg='Red'
endfunction
augroup syntax_setup
  autocmd! VimEnter * call HandleSyntaxSetup()
augroup END
" }}}
" Disable mouse {{{
set mouse=
" }}}
