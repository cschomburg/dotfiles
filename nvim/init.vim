set showmatch					"  Show matching brackets

set encoding=utf-8				" Unicode support
"set t_Co=256					" Enable 256-color support
set novisualbell				" Don't blink

" Indent
set autoindent					" Auto indenting
set smartindent					" Smart indenting
set backspace=indent,eol,start	" Make  backspace work as usual
set tabstop=4					" an indentation every 4 columns
set shiftwidth=4				" Use indents of 4 spaces
set softtabstop=-1				" spaces for editing
set noexpandtab                 " do not insert spaces when tab pressed

" Status line
set showcmd					" Show (partial) command in status line
set noshowmode					" Show mode in status line
set cmdheight=1					" Set height of command
set laststatus=2				" Always show status line

" Search
set hlsearch					" Highlight the string we searched
set incsearch					" Incremental search: Highlight the searched string while typing
set ignorecase					" Case-insensitive search
set smartcase					" Upper-case sensitive search
set wrapscan					" searches wrap back to the top of file

" Other stuff
set mat=5						" How many tenth of a second to blink matching brackets for
set foldmethod=marker			" Auto-folding in files with markers
set fileformats=unix,dos,mac	" Support in this order
set ruler
set wrap						" Don't wrap long lines to fit terminal width
set nobackup					" Disable backup
set backupcopy=yes				" Overwrite files for live reloading
set noswapfile
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
set fillchars+=vert:\ 
set previewheight=20
set mouse=

let mapleader = " "

" Completion
set pumheight=5
set completeopt+=longest		" only complete longest match
set completeopt+=menuone        " show popup menu even for single matches

" NetRW
let g:netrw_liststyle=3

" GUI options
set guioptions-=m				" Remove menu bar
set guioptions-=T				" Remove toolbar
set guioptions-=r				" Remove right-hand scroll bar

" Keep selection after indent
vmap > >gv
vmap < <gv

" Yank from the cursor to the end of the line, to be consistent with C and D
nnoremap Y y$

" X clipboard cut/paste
" map <C-V> "+gP
" cmap <C-V> <C-R>+
vnoremap <C-C> "+y

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

" allow using repeat operator with a visual selection
vnoremap . :normal .<CR>

" necessary on some Linux distros to properly load bundles
filetype off

call plug#begin('~/.config/nvim/bundle')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'

Plug 'sheerun/vim-polyglot'
Plug 'bling/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'justinmk/vim-sneak'
Plug 'junegunn/vim-easy-align'
Plug 'airblade/vim-gitgutter'
Plug 'kshenoy/vim-signature'
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-two-firewatch'
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'

Plug 'joonty/vdebug',     { 'for': 'php' }
Plug 'fatih/vim-go',      { 'for': 'go' }
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

"Plug 'shawncplus/phpcomplete.vim'
Plug 'captbaritone/better-indent-support-for-php-with-html'
Plug 'motus/pig.vim'
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'

call plug#end()

" Custom filetype settings
autocmd FileType text setlocal nobreakindent showbreak= nolist linebreak
autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType haskell setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType ruby setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType yaml setlocal expandtab tabstop=4 shiftwidth=2
autocmd FileType php setlocal expandtab tabstop=4 shiftwidth=4 commentstring=//\ %s
autocmd FileType vue setlocal expandtab tabstop=4 shiftwidth=2
autocmd FileType javascript setlocal expandtab tabstop=4 shiftwidth=4

" FZF
nmap <Leader>e :Buffers<CR>
nmap <Leader>f :Files<CR>

" Go programming language
if !empty($GOPATH)
	let g:go_fmt_command = "goimports"
	let g:go_highlight_functions = 1
	let g:go_highlight_methods = 1
	let g:go_highlight_structs = 1

	au FileType go nmap <Leader>i <Plug>(go-info)
	au FileType go nmap <Leader>gd <Plug>(go-doc-vertical)
	au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
	au FileType go nmap <Leader>t <Plug>(go-test)
endif

" PHP
let g:vdebug_options = {
			\ 'path_maps': {"var/cakephp3/ProjectManagement": "/home/xconstruct/code/energieheld/projectmanagement"},
			\ 'server': '0.0.0.0'
			\}

" Airline
let g:airline_theme='gruvbox'
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

" Syntastic
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=1
let g:syntastic_mode_map = { 'mode': 'active',
			\ 'active_filetypes': [],
			\ 'passive_filetypes': ['cpp', 'html'] }

" Easy Align
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

" Syntax

let php_sql_query = 1
let php_html_in_strings = 1
let php_var_selector_is_identifier = 1
let g:polyglot_disabled = [ 'javascript' ]

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

" load ftplugins and indent files
filetype plugin on
filetype indent on

" turn on syntax highlighting
syntax on

" Colorscheme
set background=dark
colorscheme gruvbox
