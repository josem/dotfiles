
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'

Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'flazz/vim-colorschemes'

Plugin 'scrooloose/nerdtree'

Plugin '2072/PHP-Indenting-for-VIm'

Bundle 'scrooloose/syntastic'

Plugin 'christoomey/vim-tmux-navigator'

Plugin 'dkprice/vim-easygrep'

Plugin 'vitalk/vim-simple-todo'

Plugin 'JazzCore/ctrlp-cmatcher'

Plugin 'tpope/vim-unimpaired'

Plugin 'airblade/vim-gitgutter'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


let g:neocomplete#enable_at_startup = 1
let g:neocomplete#disable_auto_complete=1

let g:airline_powerline_fonts = 1
set laststatus=2
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_symbols.space = "\ua0"
set background=dark         " Assume a dark background
filetype plugin indent on   " Automatically detect file types.
syntax on                   " Syntax highlighting
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
scriptencoding utf-8

set autowrite                       " Automatically write a file when leaving a modified buffer
set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character
set history=1000                    " Store a ton of history (default is 20)
set spell                           " Spell checking on
set hidden                          " Allow buffer switching without saving
set iskeyword-=.                    " '.' is an end of word designator
set iskeyword-=#                    " '#' is an end of word designator
set iskeyword-=-                    " '-' is an end of word designator


" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

set showmode                    " Display the current mode

set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

set nowrap                      " Do not wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set pastetoggle=<F11>           " pastetoggle (sane indentation on pastes)

" PHP
let g:syntastic_php_checkers = ['php']


" NerdTree {
if isdirectory(expand("~/.vim/bundle/nerdtree"))
    map <C-e> <plug>NERDTreeTabsToggle<CR>
    map <leader>e :NERDTreeFind<CR>
    nmap <leader>nt :NERDTreeFind<CR>

    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeMouseMode=2
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
    let g:nerdtree_tabs_open_on_gui_startup=0
endif
" }

" JSON {
nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
let g:vim_json_syntax_conceal = 0
" }

 " ctrlp {
if isdirectory(expand("~/.vim/bundle/ctrlp.vim/"))
    let g:ctrlp_working_path_mode = 'ra'
    nnoremap <silent> <D-t> :CtrlP<CR>
    nnoremap <silent> <D-r> :CtrlPMRU<CR>
    let g:ctrlp_custom_ignore = {
	\ 'dir':  '\.git$\|\.hg$\|\.svn$',
	\ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

    if executable('ag')
	let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
    elseif executable('ack-grep')
	let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
    elseif executable('ack')
	let s:ctrlp_fallback = 'ack %s --nocolor -f'
    " On Windows use "dir" as fallback command.
    elseif WINDOWS()
	let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
    else
	let s:ctrlp_fallback = 'find %s -type f'
    endif
    if exists("g:ctrlp_user_command")
	unlet g:ctrlp_user_command
    endif
    let g:ctrlp_user_command = {
	\ 'types': {
	    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
	    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
	\ },
	\ 'fallback': s:ctrlp_fallback
    \ }

    if isdirectory(expand("~/.vim/bundle/ctrlp-funky/"))
	" CtrlP extensions
	let g:ctrlp_extensions = ['funky']

	"funky
	nnoremap <Leader>fu :CtrlPFunky<Cr>
    endif
endif
"}

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> {Left-mapping} :TmuxNavigateLeft<cr>
nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>


" Ignore things
" complete#enable_at_startup = 1
let NERDTreeIgnore = ['\.DS_Store$', '\.git$', '\.hg$']
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap

noremap <silent> ,h :wincmd h<CR>
noremap <silent> ,j :wincmd j<CR>
noremap <silent> ,k :wincmd k<CR>
noremap <silent> ,l :wincmd l<CR>
noremap <silent> ,sb :wincmd p<CR>

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

set splitbelow
set splitright

let g:indent_guides_enable_on_vim_startup=0

set nolist

set t_ut= " For Tmux http://superuser.com/a/562423

set directory=.,$TEMP

set backup
set backupdir=~/.vim/backups

set nospell

autocmd BufRead,BufNewFile *.php set shiftwidth=4

let g:syntastic_php_checkers = ["php", "phpmd"]

colorscheme molokai
color molokai

map <F15> mzgg=G`z

let g:ctrlp_map = '<c-p>'

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
 endif

set nofoldenable                " disable code folding
let g:DisableAutoPHPFolding = 1 " disable PIV's folding

" This makes VIM faster
set nocursorline
set nocursorcolumn

noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }

set autoread 

let g:syntastic_enable_signs=0
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set clipboard=unnamed

" Jump to last cursor position unless it's invalid or in an event handler
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif

" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

set title  " Show file name in title bar
