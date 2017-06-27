if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'vim-scripts/LustyJuggler'
Plug 'mileszs/ack.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'edkolev/tmuxline.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'derekwyatt/vim-scala'
Plug 'pangloss/vim-javascript'
Plug 'othree/html5.vim'
Plug 'elzr/vim-json'
Plug 'chrisbra/csv.vim'
Plug 'autowitch/hive.vim'
Plug 'keith/tmux.vim'
call plug#end()

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

" Edit the vimrc file
nmap <silent> <leader>v :vsplit $MYVIMRC<CR>


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

set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class,.svn,.git,*.flac,*.mp3,*.m4a

set encoding=utf-8

set title
set visualbell
set noerrorbells

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

" Invisibles
set listchars=tab:▸\ ,eol:¬

" Tab completion
set wildmode=list:longest,list:full
set complete=.,w,t
imap <Tab> <C-P>

if has("autocmd")
  au! BufWritePost .vimrc,_vimrc,vimrc source $MYVIMRC | AirlineRefresh
  au FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
  au FileType xhtml,html,css,scss,ruby,yaml,coffee,vim setlocal ts=2 sts=2 sw=2 expandtab
  au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,config.ru,.caprc,.irbrc,Vagrantfile} set ft=ruby
  au BufRead,BufNewFile *.avsc set ft=json
  au BufNewFile,BufRead *.hql set ft=hive expandtab
endif


" netrw
" -------------------------------------------------------------------------
map <C-d> :Lexplore<CR>
"let g:netrw_liststyle = 3
let g:netrw_winsize = 35
let g:netrw_browse_split = 4
let g:netrw_altv = 1

" Airline
" -------------------------------------------------------------------------
let g:airline_powerline_fonts = 1
let g:airline#extensions#tmuxline#enabled = 0

" base16-vim
" -------------------------------------------------------------------------
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
  let base16colorspace=256
endif



" Ack
" -------------------------------------------------------------------------
nnoremap <leader>a :Ack
set grepprg=ack\ -a\ -H\ --nocolor\ --nogroup


" Ultisnips
" -------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsEditSplit = "vertical"


" LustyJuggler
" -------------------------------------------------------------------------
let g:LustyJugglerSuppressRubyWarning = 1


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

