" EnDocBrowse {{{
" Opens the documentation for the symbol under the cursor
nnoremap <silent> <leader>hh :EnDocBrowse<CR>

" }}}

" Tags {{{

" set tags+=codex.tags;/

" let g:tagbar_type_haskell = {
"     \ 'ctagsbin'  : 'hasktags',
"     \ 'ctagsargs' : '-x -c -o-',
"     \ 'kinds'     : [
"         \  'm:modules:0:1',
"         \  'd:data: 0:1',
"         \  'd_gadt: data gadt:0:1',
"         \  't:type names:0:1',
"         \  'nt:new types:0:1',
"         \  'c:classes:0:1',
"         \  'cons:constructors:1:1',
"         \  'c_gadt:constructor gadt:1:1',
"         \  'c_a:constructor accessors:1:1',
"         \  'ft:function types:1:1',
"         \  'fi:function implementations:0:1',
"         \  'o:others:0:1'
"     \ ],
"     \ 'sro'        : '.',
"     \ 'kind2scope' : {
"         \ 'm' : 'module',
"         \ 'c' : 'class',
"         \ 'd' : 'data',
"         \ 't' : 'type'
"     \ },
"     \ 'scope2kind' : {
"         \ 'module' : 'm',
"         \ 'class'  : 'c',
"         \ 'data'   : 'd',
"         \ 'type'   : 't'
"     \ }
" \ }

" " Generate haskell tags with codex and hscope
" map <leader>tg :!codex update --force<CR>:call system("git-hscope -X TemplateHaskell")<CR><CR>:call LoadHscope()<CR>

" set csprg=hscope
" set csto=1 " search codex tags first

" nnoremap <silent> <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>
" " Automatically make cscope connections
" function! LoadHscope()
"   let db = findfile("hscope.out", ".;")
"   if (!empty(db))
"     let path = strpart(db, 0, match(db, "/hscope.out$"))
"     set nocscopeverbose " suppress 'duplicate connection' error
"     exe "cs add " . db . " " . path
"     set cscopeverbose
"   endif
" endfunction
" au BufEnter /*.hs call LoadHscope()

" }}}

"Completion, Syntax check, Lint & Refactor {{{

augroup scala
  autocmd!
  autocmd BufWritePost *.scala silent :EnTypeCheck
augroup END

" Type of expression under cursor
nmap <silent> <leader>ht :EnType<CR>
" Insert type of expression under cursor
nmap <silent> <leader>hT :EnInspectType<CR>
" GHC errors and warnings
nmap <silent> <leader>hc :Neomake ghcmod<CR>

" open the neomake error window automatically when an error is found
let g:neomake_open_list = 2

" Fix path issues from vim.wikia.com/wiki/Set_working_directory_to_the_current_file
let s:default_path = escape(&path, '\ ') " store default value of 'path'
" Always add the current file's directory to the path and tags list if not
" already there. Add it to the beginning to speed up searches.
autocmd BufRead *
      \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
      \ exec "set path-=".s:tempPath |
      \ exec "set path-=".s:default_path |
      \ exec "set path^=".s:tempPath |
      \ exec "set path^=".s:default_path

" Haskell Lint
" nmap <silent> <leader>hl :Neomake hlint<CR>

" }}}
