set nocompatible
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
set swapfile
set updatecount=2000
set directory=$HOME/.config/nvim/tmp
set ttyfast						" tell vim we're using a fast terminal for redraws
set autoread					" Reload file if vim detects it changed elsewhere
set history=23					" Lines of command history
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
set listchars=trail:·,precedes:«,extends:»,tab:·\ ,eol:↲
set hidden                      " allow unsaved changes in hidden buffers
set pastetoggle=<F12>			" sane indentation on pastes
set lazyredraw
set breakindent
set showbreak=\ ↪\ 
set fillchars+=vert:\ 
set previewheight=20

let mapleader = " "

" Completion
set pumheight=5
set completeopt+=longest		" only complete longest match
set completeopt+=menuone        " show popup menu even for single matches

" Persistent undo
set undofile
set undolevels=1000
set undoreload=10000
set undodir=$HOME/.config/nvim/tmp

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

" very magic regexes per default
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %s/\v
cnoremap >s/ >smagic/

autocmd FileType text setlocal nobreakindent showbreak= nolist linebreak
autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType haskell setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType ruby setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType yaml setlocal expandtab tabstop=4 shiftwidth=2
autocmd FileType php setlocal expandtab tabstop=4 shiftwidth=4

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
Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'junegunn/vim-easy-align'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim'
Plug 'airblade/vim-gitgutter'
Plug 'kshenoy/vim-signature'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

Plug 'joonty/vdebug',     { 'for': 'php' }
Plug 'fatih/vim-go',      { 'for': 'go' }
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

"Plug 'shawncplus/phpcomplete.vim'
Plug 'captbaritone/better-indent-support-for-php-with-html'
Plug 'LnL7/vim-nix'
Plug 'motus/pig.vim'

call plug#end()

" Unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
nnoremap <leader>e :Unite -no-split -buffer-name=buffer -start-insert buffer<cr>
nnoremap <leader>f :Unite -no-split -buffer-name=file -start-insert file_rec/async:!<cr>
nnoremap <leader>t :Unite -no-split -buffer-name=tags outline<cr>
nnoremap <leader>g :<C-u>Unite -no-split grep:. -buffer-name=search-buffer<cr>
if executable('ag')
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts = '--nogroup --nocolor'
	let g:unite_source_grep_recursive_opt = ''
	let g:unite_source_grep_encoding = 'utf-8'
endif

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

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" YouCompleteMe
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

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

" Hardtime
let g:hardtime_default_on = 0
let g:hardtime_maxcount = 1
let g:hardtime_timeout = 2000

let php_sql_query = 1
let php_html_in_strings = 1
let php_var_selector_is_identifier = 1

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

" GPG config
set backupskip+=*.gpg
set viminfo=

augroup encrypted
  au!
  autocmd BufReadPre,FileReadPre *.gpg
    \ setlocal noswapfile bin
  autocmd BufReadPost,FileReadPost *.gpg
    \ execute "'[,']!gpg --decrypt --default-recipient-self" |
    \ setlocal nobin |
    \ execute "doautocmd BufReadPost " . expand("%:r")
  autocmd BufWritePre,FileWritePre *.gpg
    \ setlocal bin |
    \ '[,']!gpg --encrypt --default-recipient-self
  autocmd BufWritePost,FileWritePost *.gpg
    \ silent u |
    \ setlocal nobin
augroup END

" load ftplugins and indent files
filetype plugin on
filetype indent on

" turn on syntax highlighting
syntax on

" Colorscheme
set background=dark
colorscheme gruvbox
