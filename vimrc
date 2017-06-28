execute pathogen#infect()

" General {{{

" set shell for adec computer
set shell=/bin/sh

syntax enable

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
let mapleader = "/"
let g:mapleader = "/"

" Leader key timeout
set tm=2000

" Allow the normal use of "," by pressing it twice
" Don't need this since chenged leader to /
"noremap // /

" Use par for prettier line formatting
set formatprg="PARINIT='rTbgqR B=.,?_A_a Q=_s>|' par\ -w72"

" Kill the damned Ex mode.
nnoremap Q <nop>

" Easier navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

" }}}

" VIM user interface {{{

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on vim-airline at start
set laststatus=2

" Use powerline font for vim-airline
let g:airline_powerline_fonts = 1

" airline smarter tabline
let g:airline#extensions#tabline#enabled = 1

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

" Highlight 80 column
let &colorcolumn="80"
" .join(range(120,500),",")

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
"set mouse=a
" }}}

" Colors and Fonts {{{

" solarized colorscheme
set termguicolors
set background=light
colorscheme gruvbox
" let g:solarized_termtrans=1

" Set airline theme
let g:airline_theme='gruvbox'

" Enable syntax highlighting
syntax enable

" Adjust signscolumn and syntastic to match wombat
"hi! link SignColumn LineNr
"hi! link SyntasticErrorSign ErrorMsg
"hi! link SyntasticWarningSign WarningMsg

" Use pleasant but very visible search hilighting
"hi Search ctermfg=white ctermbg=173 cterm=none guifg=#ffffff guibg=#e5786d gui=none
"hi! link Visual Search

" Fix indent-guide colors
let indent_guides_auto_colors = 0
if 'dark' == &background
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=grey ctermbg=black
"  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=green
else
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=grey ctermbg=0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=0
endif

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

" Indent guide
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2

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

" Spell checking {{{

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Change default dictionary
set spelllang=pl_pl
" }}}

" Slime {{{

vmap <silent> <Leader>rs <Plug>SendSelectionToTmux
nmap <silent> <Leader>rs <Plug>NormalModeSendToTmux
nmap <silent> <Leader>rv <Plug>SetTmuxVars

" }}}

" NERDTree {{{

" Close nerdtree after a file is selected
let NERDTreeQuitOnOpen = 1

function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! ToggleFindNerd()
  if IsNERDTreeOpen()
    exec ':NERDTreeToggle'
  else
    exec ':NERDTreeFind'
  endif
endfunction

" If nerd tree is closed, find current file, if open, close it
nmap <silent> <leader>f <ESC>:call ToggleFindNerd()<CR>
nmap <silent> <leader>F <ESC>:NERDTreeToggle<CR>

" }}}

" Alignment {{{

" Stop Align plugin from forcing its mappings on us
let g:loaded_AlignMapsPlugin=1
" Align on equal signs
map <Leader>a= :Align =<CR>
" Align on commas
map <Leader>a, :Align ,<CR>
" Align on pipes
map <Leader>a<bar> :Align <bar><CR>
" Prompt for align character
map <leader>ap :Align

" }}}

" Ledger {{{
au BufNewFile,BufRead *.ldg,*.ledger,*.journal setf ledger | comp ledger

let g:ledger_bin = "hledger"

" }}}

" Haskell {{{

autocmd Filetype haskell
  \ set tabstop=2 |
  \ set softtabstop=2 |
  \ set shiftwidth=2 |
  \ set textwidth=79

" Align on haskell related symobls
" Align on arrows ->
map <Leader>a- :Align -><CR>
"Align on ::
map <Leader>a; :Align ::<CR>

" Recognize *.y as happy syntax, not yacc
au BufRead,BufNewFile *.y set filetype=happy

let haskell_config_dir = $HOME . "/.vim"
let haskell_config = expand(resolve(haskell_config_dir . "/vimrc.haskell"))
" autocmd FileType haskell 
execute 'source '. haskell_config

" }}}

" Scala {{{

autocmd Filetype scala
  \ set tabstop=2 |
  \ set softtabstop=2 |
  \ set shiftwidth=2 |
  \ set textwidth=79

let scala_config_dir = $HOME . "/.vim" |
let scala_config = expand(resolve(scala_config_dir . "/vimrc.scala")) |
au Filetype scala execute 'source '. scala_config

" }}}

" JavaScript {{{

" set syntastic checker
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'

" highlight flow type checker syntax
let g:javascript_plugin_flow = 1

" it is slow and buggy
let g:flow#enable = 0

" prefer local eslint over global one
let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint_d')
let b:syntastic_javascript_eslint_exec = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')

" use locally installed flow
" let local_flow = finddir('PATH=$(npm bin):$PATH && which flow')
" let g:flow#flowpath = local_flow

" }}}

" C++ {{{

" set syntastic checker
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler = ' -std=c++14 -stdlib=libc++'

" let g:syntastic_cpp_checker = ['clang-check', 'clang-tidy']

" }}}

" Tags {{{

let g:tagbar_type_systemverilog = {
  \ 'ctagstype'   : 'SystemVerilog',
  \ 'kinds'       : [
    \ 'b:blocks:1:1',
    \ 'c:constants:1:0',
    \ 'e:events:1:0',
    \ 'f:functions:1:1',
    \ 'm:modules:0:1',
    \ 'n:nets:1:0',
    \ 'p:ports:1:0',
    \ 'r:registers:1:0',
    \ 't:tasks:1:1',
    \ 'A:assertions:1:1',
    \ 'C:classes:0:1',
    \ 'V:covergroups:0:1',
    \ 'I:interfaces:0:1',
    \ 'M:modport:0:1',
    \ 'K:packages:0:1',
    \ 'P:programs:0:1',
    \ 'R:properties:0:1',
    \ 'T:typedefs:0:1'
  \ ],
  \ 'sro'         : '.',
  \ 'kind2scope'  : {
    \ 'm' : 'module',
    \ 'b' : 'block',
    \ 'r' : 'registers',
    \ 't' : 'task',
    \ 'f' : 'function',
    \ 'C' : 'class',
    \ 'V' : 'covergroup',
    \ 'I' : 'interface',
    \ 'K' : 'package',
    \ 'P' : 'program',
    \ 'R' : 'property'
  \ },
\ }

map <leader>tt :TagbarToggle<CR>

" }}}

" Ag {{{

let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

" }}}
