""" vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'scrooloose/nerdcommenter'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'nathanaelkane/vim-indent-guides'
Plug 'derekwyatt/vim-scala'
Plug 'pangloss/vim-javascript'
Plug 'python-mode/python-mode'
Plug 'othree/html5.vim'
Plug 'elzr/vim-json'
Plug 'chrisbra/csv.vim'
Plug 'autowitch/hive.vim'
Plug 'w0ng/vim-hybrid'
Plug 'junegunn/fzf.vim'
call plug#end()

let mapleader=","

imap jj <Esc>

" Windows / Splits
" ctrl-jklm  changes to that split
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

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

" Backups
set nobackup
set nowritebackup
silent execute '!mkdir -p ~/.vim_swap'
set directory=~/.vim_swap//

set splitright
set splitbelow

set pastetoggle=<F2>

set nrformats=

set listchars=tab:▸\ ,eol:¬  " invisibles


" Tab completion
set wildmode=list:longest,list:full
set complete=.,w,t

if has("autocmd")
    au! BufWritePost init.vim,.vimrc,_vimrc,vimrc source $MYVIMRC | AirlineRefresh
    au FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
    au FileType xhtml,html,css,scss,ruby,yaml,coffee,vim setlocal ts=2 sts=2 sw=2 expandtab
    au BufRead,BufNewFile {Vagrantfile} set ft=ruby
    au BufRead,BufNewFile *.avsc set ft=json
    au BufNewFile,BufRead *.hql set ft=hive expandtab
endif


""" netrw
map <C-d> :Lexplore<CR>
let g:netrw_liststyle = 3
let g:netrw_winsize = 35
let g:netrw_browse_split = 4
let g:netrw_altv = 1

""" fzf
if ! empty(glob('~/.fzf'))
    set rtp+=~/.fzf
endif
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :<C-u>FZF<CR>
nnoremap <C-p> :<C-u>FZF<CR>

""" IndentGuides
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=1
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=8

""" Colors / Display
set background=dark
colorscheme hybrid
set cursorline
set fillchars=vert:│
set lazyredraw
" custom current line number highlight
au VimEnter,Colorscheme * :hi CursorLineNR ctermfg=8

""" Airline
let g:airline_theme='hybrid'
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline_mode_map = {
            \ '__' : '-',
            \ 'n'  : 'N',
            \ 'i'  : 'I',
            \ 'R'  : 'R',
            \ 'c'  : 'C',
            \ 'v'  : 'V',
            \ 'V'  : 'V',
            \ '' : 'V',
            \ 's'  : 'S',
            \ 'S'  : 'S',
            \ '' : 'S',
            \ }

""" Ultisnips
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsEditSplit = "vertical"


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
