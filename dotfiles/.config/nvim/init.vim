filetype plugin indent on
" Require packages {{{
lua require('initlua')
lua require('packages')
" }}}
command! UpdateAll execute ':PaqUpdate' | execute ':TSUpdate'
"Non-Plugin Personal Customization {{{
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

  " Provides additional info for message output
  set cmdheight=2

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

  " Remove arrow keys - currently cannot remove them because claude code needs
  " them
  "nnoremap <Up> <nop>
  "nnoremap <Down> <nop>
  "nnoremap <Left> <nop>
  "nnoremap <Right> <nop>
  "inoremap <Up> <nop>
  "inoremap <Down> <nop>
  "inoremap <Left> <nop>
  "inoremap <Right> <nop>
  "vnoremap <Up> <nop>
  "vnoremap <Down> <nop>
  "vnoremap <Left> <nop>
  "vnoremap <Right> <nop>

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
  nnoremap <silent> <space>j :NvimTreeToggle<CR>

  " lsp mappings
  nnoremap <Leader>d <Cmd>lua vim.diagnostic.enable(not vim.diagnostic.is_enabled())<CR>

  " fzf
  nnoremap <C-\> <Cmd>lua require"fzf-lua".buffers()<CR>
  nnoremap <C-k> <Cmd>lua require"fzf-lua".builtin()<CR>
  nnoremap <C-p> <Cmd>lua require"fzf-lua".files()<CR>
  nnoremap <C-l> <Cmd>lua require"fzf-lua".live_grep_glob()<CR>
  nnoremap <C-g> <Cmd>lua require"fzf-lua".grep_project()<CR>
  nnoremap <F1> <Cmd>lua require"fzf-lua".help_tags()<CR>

  " claudecode
  " Waiting on https://github.com/coder/claudecode.nvim/issues/100
  nnoremap <Leader>ac <cmd>CustomClaudeCode<cr>
  nnoremap <Leader>af <cmd>ClaudeCodeFocus<cr>
  nnoremap <Leader>ar <cmd>ClaudeCode --resume<cr>
  nnoremap <Leader>aC <cmd>ClaudeCode --continue<cr>
  nnoremap <Leader>am <cmd>ClaudeCodeSelectModel<cr>
  nnoremap <Leader>ab <cmd>ClaudeCodeAdd %<cr>
  xnoremap <Leader>as <cmd>ClaudeCodeSend<cr>
  nnoremap <Leader>aa <cmd>ClaudeCodeDiffAccept<cr>
  nnoremap <Leader>ad <cmd>ClaudeCodeDiffDeny<cr>
  " Deviates from standard docs
  nnoremap <Leader>at <cmd>ClaudeCodeTreeAdd<cr>
endfunction

call GlobalKeyRemap()
" }}}
" Vim Rooter {{{
" silence the cwd
"let g:rooter_silent_chdir = 1
let g:rooter_patterns = ['Cargo.toml', 'package.json', 'pyproject.toml', 'setup.py', 'requirements.txt', '.git', '.git/']
" }}}
" NvimTree {{{
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
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
" Filetype formatter {{{
"
function s:formatter_python()
  return printf(
        \ 'ruff check --unsafe-fixes -q --fix-only --stdin-filename="%1$s" - | ' ..
        \ 'ruff format -q --stdin-filename="%1$s" -',
        \ expand('%:p'))
endfunction
let g:vim_filetype_formatter_commands = {
      \ 'python':  function('s:formatter_python')
      \ }
" }}}
" Buffer reloads {{{
au FocusGained,BufEnter * :checktime
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
