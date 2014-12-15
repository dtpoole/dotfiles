set nocompatible

" -- Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'gmarik/vundle'

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-dispatch'
Plugin 'plasticboy/vim-markdown'
Plugin 'blueyed/vim-colors-solarized'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'vim-scripts/LustyJuggler'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'othree/html5.vim'
Plugin 'chrisbra/csv.vim'

call vundle#end()
filetype plugin indent on

let mapleader=","

" Shortcuts
" ------------------------------------------------------------------------
imap jj <Esc>

" Windows / Splits
" ctrl-jklm  changes to that split
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" show the registers from things cut/yanked
nmap <leader>r :registers<CR>

" map the various registers to a leader shortcut for pasting from them
nmap <leader>0 "0p
nmap <leader>1 "1p
nmap <leader>2 "2p
nmap <leader>3 "3p
nmap <leader>4 "4p
nmap <leader>5 "5p
nmap <leader>6 "6p
nmap <leader>7 "7p
nmap <leader>8 "8p
nmap <leader>9 "9p

nmap <silent> ,/ :nohlsearch<CR>

"nmap <C-N><C-N> :set invnumber<CR>

" switch buffers quickly
nnoremap <leader><leader> <c-^>

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

nnoremap <leader>a :Ack

" Edit the vimrc file
nmap <silent> <leader>v :vsplit $MYVIMRC<CR>

map <C-d> :NERDTreeToggle<CR>
" Editor
" -------------------------------------------------------------------------

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

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class,.svn,.git,*.flac,*.mp3,*.m4a

set encoding=utf-8

set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

set showcmd
set ruler
set laststatus=2
set hidden


" Backups
set nobackup
set nowritebackup
"silent execute '!mkdir -p ~/.vim_backups'
"set backupdir=~/.vim_backups//
silent execute '!mkdir -p ~/.vim_swap'
set directory=~/.vim_swap//

set splitright
set splitbelow

set pastetoggle=<F2>

set nrformats=

if executable("ack")
  set grepprg=ack\ -a\ -H\ --nocolor\ --nogroup
endif

" Invisibles
set listchars=tab:▸\ ,eol:¬

" Tab completion
set wildmode=list:longest,list:full
set complete=.,w,t
imap <Tab> <C-P>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

if has("autocmd")
  au! BufWritePost .vimrc,_vimrc,vimrc source $MYVIMRC | AirlineRefresh
  au FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
  au FileType xhtml,html,css,scss,ruby,yaml,coffee,vim setlocal ts=2 sts=2 sw=2 expandtab
  au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby
  au BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux

  augroup filetypedetect
    au! BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
    au! BufNewFile,BufRead *.csv setf csv
  augroup END
endif


" Airline
" -------------------------------------------------------------------------
let g:airline_powerline_fonts = 1

set timeoutlen=1000 ttimeoutlen=50

" UltiSnips
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsEditSplit  = "vertical"

" CtrlP
" -------------------------------------------------------------------------
let g:ctrlp_max_files = 10000

" Optimize file searching
if has("unix")
  let g:ctrlp_user_command = {
        \   'types': {
        \       1: ['.git/', 'cd %s && git ls-files']
        \   },
        \   'fallback': 'find %s -type f | head -' . g:ctrlp_max_files
        \ }
endif

" Colors
" -------------------------------------------------------------------------
syntax enable
set t_Co=256
set background=dark
silent! colorscheme solarized


" Trailing Space / Indent
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap _= :call Preserve("normal gg=G")<CR>

