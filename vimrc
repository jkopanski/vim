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
" noremap ,, ,

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

" Use powerline font for vim-airline
let g:airline_powerline_fonts = 1

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
let &colorcolumn="80,".join(range(120,500),",")

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
set background=dark
colorscheme solarized
let g:solarized_termtrans=1

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
" set t_Co=256

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

" Haskell {{{

" Use stylish haskell instead of par for haskell buffers
autocmd FileType haskell let &formatprg="stylish-haskell"

" ghc-mode code completion capabilities
map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>
map <silent> tc :GhcModCheck<CR>

" Align on haskell related symobls
" Align on arrows ->
map <Leader>a- :Align -><CR>
"Align on ::
map <Leader>a; :Align ::<CR>

" Enable some tabular presets for Haskell
let g:haskell_tabular = 1

" Recognize *.y as happy syntax, not yacc
au BufRead,BufNewFile *.y set filetype=happy

" }}}

" JavaScript {{{

" set syntastic checker
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint'

" prefer local eslint over global one
" let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint_d')
" let b:syntastic_javascript_eslint_exec = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')

" }}}

" Tags {{{

set tags=tags;/,codex.tags;/

let g:tagbar_type_haskell = {
  \ 'ctagsbin'  : 'hasktags',
  \ 'ctagsargs' : '-x -c -o-',
  \ 'kinds'     : [
    \ 'm:modules:0:1',
    \ 'd:data: 0:1',
    \ 'd_gadt: data gadt:0:1',
    \ 't:type names:0:1',
    \ 'nt:new types:0:1',
    \ 'c:classes:0:1',
    \ 'cons:constructors:1:1',
    \ 'c_gadt:constructor gadt:1:1',
    \ 'c_a:constructor accessors:1:1',
    \ 'ft:function types:1:1',
    \ 'fi:function implementations:0:1',
    \ 'o:others:0:1'
  \ ],
  \ 'sro'        : '.',
  \ 'kind2scope' : {
    \ 'module'   : 'm',
    \ 'class'    : 'c',
    \ 'data'     : 'd',
    \ 'type'     : 't'
  \ },
  \ 'scope2kind' : {
    \ 'module'   : 'm',
    \ 'class'    : 'c',
    \ 'data'     : 'd',
    \ 'type'     : 't'
  \}
\ }

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

" Generate haskell tags with codex and hscope
 map <leader>tg :!codex update --force<CR>:call system("git-hscope -X TemplateHaskell")<CR><CR>:call LoadHscope()<CR>

map <leader>tt :TagbarToggle<CR>

set csprg=hscope
set csto=1 " search codex tags first
set cst
set csverb
nnoremap <silent> <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>
" Automatically make cscope connections
function! LoadHscope()
  let db = findfile("hscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/hscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /*.hs call LoadHscope()

" }}}
