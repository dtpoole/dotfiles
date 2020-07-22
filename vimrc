let mapleader=","

imap jj <Esc>

if has('nvim')
  tnoremap jj <C-\><C-n>
endif

" Windows / Splits
" ctrl-jklm  changes to that split
nnoremap <M-h> <c-w>h
nnoremap <M-j> <c-w>j
nnoremap <M-k> <c-w>k
nnoremap <M-l> <c-w>l

nmap <silent> <leader>/ :nohlsearch<CR>

" switch buffers quickly
nnoremap <leader><leader> <c-^>
nnoremap <c-g> :bn<CR>

" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" improve up/down movement on wrapped lines
nnoremap j gj
nnoremap k gk

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

cmap w!! w !sudo tee % >/dev/null

nmap <leader>l :set list!<CR>
nmap <leader>n :set number!<CR>

nmap <silent> <leader>v :vsplit $MYVIMRC<CR>

" Editor

" Line breaks
set wrap linebreak nolist

" Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

set backspace=indent,eol,start

set mat=5

set cursorline
set showmatch     " set show matching parenthesis

" Searching
set ignorecase
set smartcase
set hlsearch
set incsearch

set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class,.svn,.git,*.flac,*.mp3,*.m4a

set encoding=utf-8

set title
set visualbell
set noerrorbells

" Backups
set nobackup
set nowritebackup
silent execute '!mkdir -p ~/.vim/swap'
set directory=~/.vim/swap//

set splitright
set splitbelow

set pastetoggle=<F2>

set nrformats=

set listchars=tab:▸\ ,eol:¬  " invisibles


" Tab completion
set wildmode=list:longest,list:full
set complete=.,w,t

augroup me
  autocmd!
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType xhtml,html,css,scss,ruby,yaml,coffee,vim,vimrc setlocal ts=2 sts=2 sw=2 expandtab
  autocmd BufRead,BufNewFile {Vagrantfile} set ft=ruby
  autocmd BufRead,BufNewFile *.avsc set ft=json

  autocmd BufWritePost init.vim,.vimrc,_vimrc,vimrc source $MYVIMRC

  autocmd BufWritePre /tmp/* setlocal noundofile
augroup end


" persist undos
silent execute '!mkdir -p ~/.vim/undo'
set undofile
set undodir=~/.vim/undo//

""" netrw
map <C-d> :Lexplore<CR>
let g:netrw_liststyle = 3
let g:netrw_winsize = 35
let g:netrw_browse_split = 4
let g:netrw_altv = 1

""" fzf
if ! empty(glob('~/.fzf'))
  set rtp+=~/.fzf
  nnoremap <leader>b :Buffers<CR>
  nnoremap <leader>f :<C-u>FZF<CR>
  nnoremap <C-p> :<C-u>FZF<CR>
endif

""" Grepper
let g:grepper = {}
let g:grepper.tools = ['rg', 'grep', 'git']
let g:grepper.next_tool = '<leader>g'
" Search for the current word
nnoremap <Leader>* :Grepper -cword -noprompt<CR>

" Search for the current selection
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)
nnoremap <leader>g :Grepper<cr>

""" python mode
let g:pymode_python = 'python3'
let g:pymode_options_colorcolumn = 0

""" go
let g:go_version_warning = 0

""" ALE
" Disable linting for all minified JS files.
let g:ale_pattern_options = {'\.min.js$': {'ale_enabled': 0}}

let g:ale_linters = {
      \   'javascript': ['standard'],
      \   'vim': ['vint'],
      \}

let g:ale_fixers = {
      \  '*': ['remove_trailing_lines', 'trim_whitespace'],
      \'javascript': ['standard'],
      \}
let g:ale_fix_on_save = 1

""" vim-markdown
let g:vim_markdown_folding_disabled = 1

""" Custom Functions
function! Preserve(command)
  let l:save = winsaveview()
  execute a:command
  call winrestview(l:save)
endfunction

command! TrimTrailingWhitespace call Preserve("%s/\\s\\+$//e")
nmap _$ :TrimTrailingWhitespace<CR>

command! FormatFile call Preserve("normal gg=G")
nmap _= :FormatFile<CR>


""" Colors / Display
set background=dark
colorscheme hybrid
"let g:hybrid_custom_term_colors = 1
set cursorline
set fillchars=vert:│
set laststatus=2
set lazyredraw
set showmode

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif


""" Status Line
"""" Status Colors
hi User1 ctermfg=253 ctermbg=24
hi User2 ctermfg=239 ctermbg=235
hi User3 ctermfg=245 ctermbg=237
hi User4 ctermfg=24 ctermbg=237

function! Status(winnum)
  let active = a:winnum == winnr()
  if active
    let stat = "%1*"
  else
    let stat = "%2*"
  endif
  let stat .= "[%n]\ %<%.99f\ %h%w%m%r%{exists('*FugitiveStatusline')?FugitiveStatusline():''}%y "
  if active
    let stat .= "%4*%3*"
  end
  let stat .= "%=%-16(\ %l,%c%V\ %)%P" " Right
  return stat
endfunction

function! s:RefreshStatus()
  for nr in range(1, winnr('$'))
    call setwinvar(nr, '&statusline', '%!Status(' . nr . ')')
  endfor
endfunction

augroup status
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * call <SID>RefreshStatus()
augroup END

"let g:hybrid_custom_term_colors=1


" minpac
function! PackInit() abort
  packadd minpac
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-vinegar')
  call minpac#add('scrooloose/nerdcommenter')
  call minpac#add('mhinz/vim-grepper')
  call minpac#add('pangloss/vim-javascript')
  call minpac#add('python-mode/python-mode')
  call minpac#add('fatih/vim-go')
  call minpac#add('elzr/vim-json')
  call minpac#add('chrisbra/csv.vim')
  call minpac#add('dtpoole/vim-hybrid')
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('w0rp/ale')
  call minpac#add('isobit/vim-caddyfile')
  call minpac#add('stephpy/vim-yaml')
  call minpac#add('plasticboy/vim-markdown')
  call minpac#add('ekalinin/Dockerfile.vim')
endfunction

command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()
