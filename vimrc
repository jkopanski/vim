execute pathogen#infect()

" General {{{

syntax enable

" solarized colorscheme
set background=dark
colorscheme solarized

" use indentation for folds
set foldmethod=indent
set foldnestmax=5
set foldlevelstart=99
set foldcolumn=0

augroup vimrcFold
  " fold vimrc itself by categories
  autocmd!
  autocmd FileType vim set foldmethod=marker
  autocmd FileType vim set foldlevel=0
augroup END

" Sets how many lines of history VIM has to remember
set history=700

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Leader key timeout
set tm=2000

" Allow the normal use of "," by pressing it twice
noremap ,, ,

" Use par for prettier line formatting
set formatprg="PARINIT='rTbgqR B=.,?_A_a Q=_s>|' par\ -w72"

" Use stylish haskell instead of par for haskell buffers
autocmd FileType haskell let &formatprg="stylish-haskell"

" Kill the damned Ex mode.
nnoremap Q <nop>

" }}}

" VIM user interface {{{

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on vim-airline at start
set laststatus=2

" Turn on the WiLd menu
set wildmenu
" Tab-complete files up to longest unambiguous prefix
set wildmode=list:longest,full

" Always show current position
set ruler
set number

" Show trailing whitespace
set list
" But only interesting whitespace
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Height of the command bar
set cmdheight=1

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set vb t_vb=

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" Force redraw
map <silent> <leader>r :redraw!<CR>

" Turn mouse mode on
nnoremap <leader>ma :set mouse=a<cr>

" Turn mouse mode off
nnoremap <leader>mo :set mouse=<cr>

" Default to mouse mode on
set mouse=a
" }}}

" Colors and Fonts {{{

" solarized colorscheme
set background=dark
colorscheme solarized

" Enable syntax highlighting
syntax enable

" Adjust signscolumn and syntastic to match wombat
"hi! link SignColumn LineNr
"hi! link SyntasticErrorSign ErrorMsg
"hi! link SyntasticWarningSign WarningMsg

" Use pleasant but very visible search hilighting
"hi Search ctermfg=white ctermbg=173 cterm=none guifg=#ffffff guibg=#e5786d gui=none
"hi! link Visual Search

" Enable filetype plugins
filetype plugin on
filetype indent on

" Match wombat colors in nerd tree
"hi Directory guifg=#8ac6f2

" Searing red very visible cursor
"hi Cursor guibg=red

" Use same color behind concealed unicode characters
hi clear Conceal

" Don't blink normal mode cursor
"set guicursor=n-v-c:block-Cursor
"set guicursor+=n-v-c:blinkon0

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set guitablabel=%M\ %t
endif
set t_Co=256

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Use large font by default in MacVim
"set gfn=Monaco:h19

" }}}

" Text, tab and indent related {{{

" " Use spaces instead of tabs
set expandtab

" " Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Indentation setup per language
" Python
autocmd Filetype python
  \ set tabstop=4 |
  \ set softtabstop=4 |
  \ set shiftwidth=4 |
  \ set textwidth=79

" Pretty unicode haskell symbols
let g:haskell_conceal_wide = 1
let g:haskell_conceal_enumerations = 1
let hscoptions="STEMxRtBD"

" }}}
