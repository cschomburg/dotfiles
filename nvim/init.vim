set showmatch					"  Show matching brackets

set encoding=utf-8				" Unicode support
set novisualbell				" Don't blink

set termguicolors

" Indent
set autoindent					" Auto indenting
set smartindent					" Smart indenting
set backspace=indent,eol,start	" Make  backspace work as usual
set tabstop=4					" an indentation every 4 columns
set shiftwidth=4				" Use indents of 4 spaces
set softtabstop=-1				" spaces for editing
set expandtab					" insert spaces when tab pressed

" Status line
set showcmd					" Show (partial) command in status line
set noshowmode					" Show mode in status line
set cmdheight=1					" Set height of command
set laststatus=3				" Always show global status line

" Search
set hlsearch					" Highlight the string we searched
set incsearch					" Incremental search: Highlight the searched string while typing
set ignorecase					" Case-insensitive search
set smartcase					" Upper-case sensitive search
set wrapscan					" searches wrap back to the top of file

" Other stuff
set mat=5						" How many tenth of a second to blink matching brackets for
set foldmethod=indent
set foldlevelstart=20
set fileformats=unix,dos,mac	" Support in this order
set ruler
set wrap						" Don't wrap long lines to fit terminal width
set nobackup					" Disable backup
set backupcopy=yes				" Overwrite files for live reloading
set noswapfile
set updatetime=100
set directory=$HOME/.config/nvim/tmp
set autoread					" Reload file if vim detects it changed elsewhere
set title						" Set window title with the vim files
set wildmode=longest:full,full	" Bash-like tab completion list
set wildmenu
set formatoptions-=o			" don't continue comments when pushing o/O
set scrolljump=5				" lines to scroll when cursor leaves screen
set scrolloff=5					" minimum lines to keep above and below cursor
set gdefault					" the /g flag on :s substitutions by default
set cursorline                  " Highlight current line
set colorcolumn=80				" Mark 80px column
set conceallevel=2				" Conceal
set list                        " show special chars
set listchars=trail:·,precedes:«,extends:»,tab:·\ 
set hidden                      " allow unsaved changes in hidden buffers
set pastetoggle=<F12>			" sane indentation on pastes
set lazyredraw
set breakindent
set showbreak=\ ↪\ 
"set fillchars+=vert:\ 
set previewheight=20
set mouse=
set splitright
set diffopt=filler,internal,algorithm:histogram,indent-heuristic

if exists('&inccommand')
	set inccommand=split
endif

let mapleader = " "

" Completion
set pumheight=5
" set completeopt+=longest		" only complete longest match
" set completeopt+=menuone        " show popup menu even for single matches
" set completeopt-=preview        " Disable preview window
set completeopt=menuone,noselect

" Keep selection after indent
vmap > >gv
vmap < <gv

" Yank from the cursor to the end of the line, to be consistent with C and D
nnoremap Y y$

" X clipboard cut/paste
" map <C-V> "+gP
" cmap <C-V> <C-R>+
vnoremap <C-C> "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+gP

" For when you forget to sudo.. Really write the file
cmap w!! w !sudo tee % >/dev/null

" Wrapped lines go down/up to next row, rather than next line in file
noremap j gj
noremap k gk

" toggle search highlighting
nmap <silent> <leader>/ :set invhlsearch<CR>

nnoremap <leader>j :%!python -m json.tool<CR>
nnoremap <leader>h :%!xxd<CR>
nnoremap <leader>H :%!xxd -r<CR>
nnoremap <leader>n :NV<CR>

function! PrettySql()
	execute 's/\v<(FROM|WHERE|LEFT|INNER|GROUP|ORDER|LIMIT)>/MEOWTWO\1'
	execute 's/\v,/,MEOWTWO    '
	execute 's/\v<(AND|OR|ON)>/MEOWTWO    \1'
	execute 's/MEOWTWO/\r'
endfunction

" allow using repeat operator with a visual selection
vnoremap . :normal .<CR>

" necessary on some Linux distros to properly load bundles
filetype off

" Lua init
lua require('init')

" Custom filetype settings
let g:vue_disable_pre_processors=1
autocmd FileType text setlocal nobreakindent showbreak= nolist linebreak
autocmd FileType markdown setlocal nobreakindent showbreak= nolist linebreak
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2
autocmd FileType nix setlocal tabstop=2 shiftwidth=2
autocmd FileType php setlocal commentstring=//\ %s
autocmd FileType vue setlocal tabstop=4 shiftwidth=4
autocmd FileType vue.html.javascript.css setlocal tabstop=4 shiftwidth=4
autocmd FileType graphql setlocal tabstop=2 shiftwidth=2

" fuzzy finder
nmap <Leader>e :Buffers<CR>
nmap <Leader>f :Files<CR>
" nmap <Leader>e <cmd>Telescope buffers<cr>
" nmap <Leader>f <cmd>Telescope find_files<cr>

" Go programming language
if !empty($GOPATH)
	au FileType go nmap <Leader>i <Plug>(go-info)
	au FileType go nmap <Leader>gd <Plug>(go-doc-vertical)
	au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
	au FileType go nmap <Leader>t <Plug>(go-test)
endif

" PHP
autocmd FileType php let b:surround_45 = "__('\r')"
nmap <leader>g cs'-

" Easy Align
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
let g:easy_align_delimiters = {
  \ ';': { 'pattern': ';', 'left_margin': 0, 'right_margin': 1, 'stick_to_left': 1 } }

nnoremap <leader>u :MundoToggle<CR>
nnoremap <leader>s :e ~/.scratchpad.md<CR>

" bracketed paste mode
let &t_ti = &t_ti . "\e[?2004h"
let &t_te = "\e[?2004l" . &t_te
function XTermPasteBegin(ret)
	set pastetoggle=<Esc>[201~
	set paste
	return a:ret
endfunction
map <expr> <Esc>[200~ XTermPasteBegin("i")
imap <expr> <Esc>[200~ XTermPasteBegin("")
cmap <Esc>[200~ <nop>
cmap <Esc>[201~ <nop>

" Ripgrep
if executable('rg') 
	set grepprg=rg\ --vimgrep\ --hidden
endif

" load ftplugins and indent files
filetype plugin on
filetype indent on

" turn on syntax highlighting
syntax on

" Colorscheme
set background=light
colorscheme zenbones
