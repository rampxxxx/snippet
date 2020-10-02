" ini : format
" -IN FRR KERNEL COD STYLE- set tabstop=2 shiftwidth=4 expandtab " tab as 4 spaces"
set colorcolumn=80
" end : format

set wildmenu "autocompletar visual en comandos vim
set cursorline "Print a line at current position
set cursorcolumn "Print a column at current position
" hi CursorColumn ctermbg=8 "Change color but default seems ok.

" ini : netrw
let g:netrw_browse_split = 4 " open to previous window
let g:netrw_liststyle = 3    " tree list of files.
let g:netrw_winsize = 10
" end : netrw


set number
"set relativenumber "line number relative to possition"
set hlsearch
set incsearch
"" default colorscheme blue match better with all ring&bells.
colorscheme morning  " white bg 
"colorscheme shine " white bg
"colorscheme blue
"colorscheme darkblue
let g:airline_theme='ayu_light'

" Clashes with screen 'previous screen' nnoremap <C-a>   :tabnext<CR>
nnoremap <C-t>   :tabnext<CR>
nmap <F8> :TagbarToggle<CR>
"nnoremap <C-|> :pop<CR> " As the <C-t> is used and <C-O> load prev. file not tags.
"
" ini: cscope
set nocscopeverbose " Avoid cscope dup ddbb msg"
map <F5> :!~/bin/miCscope_gen.sh<CR>:cs reset<CR><CR>
nmap <F6> :cprev <CR>
nmap <F7> :cnext <CR>
nmap <F9> :GitGutterNextHunk <CR>
nmap <F10> :GitGutterPrevHunk <CR>
set cscopequickfix=s-,c-,d-,i-,t-,e- " Lista en ventana copen
set cscopetag " Utilizar cscope y luego tags en ctrl-]
" end: cscope



let g:airline_powerline_fonts = 1 " Airline plugin, populate symbols"
set t_Co=256 " set proper term to allow bg col in airline"

set path+=** " add recursive dir to find files."

" take out 'i' for not searching in include file when tab (supertab) is
" pressed.
"set complete=.,w,b,u,t,i
set complete=.,w,b,u,t


" Init : syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_config_file = '.clang_tidy' " for cpp_config
let g:syntastic_clang_check_config_file='.clang_tidy' " for clang_check"
let g:syntastic_clang_tidy_config_file='.clang_tidy' "for clang_tidy"


"" Disable, so no check automatically.
let g:syntastic_mode_map = { 'mode': 'passive',
                            \ 'active_filetypes': ['sin_lenguage_aqui'],
                            \ 'passive_filetypes': ['cc', 'c','sh'] }

" Override default cpp checker list to have clang_tidy as default.
let g:syntastic_cpp_checkers = ["clang_tidy"]
let g:syntastic_c_cppcheck_args =''


"let g:syntastic_c_clang_tidy_args='clang-analyzer-*,clang-analyzer-cplusplus*'
"let g:syntastic_cpp_clang_tidy_args='clang-analyzer-*,-clang-analyzer-cplusplus*' "Suppose to set all checkers cc and c
" PARA C no funciona -* , dar error al lanzar el ':SyntasticCheck clang_tidy'
"let g:syntastic_c_clang_tidy_args=''
"let g:syntastic_c_clang_tidy_args='clang-analyzer-*,-clang-analyzer-cplusplus*,-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling,clang-analyzer-security.insecureAPI.bzero,-clang-analyzer-security.insecureAPI.strcpy'
let g:syntastic_c_clang_tidy_args='clang-analyzer-*,-clang-analyzer-cplusplus*,-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling,clang-analyzer-security.insecureAPI.bzero,-clang-analyzer-security.insecureAPI.strcpy,-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling'
let g:syntastic_cpp_clang_tidy_args='-*,clang-analyzer-*,-clang-analyzer-cplusplus*,-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling,clang-analyzer-security.insecureAPI.bzero,-clang-analyzer-security.insecureAPI.strcpy,-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling'
" yang checker
let g:syntastic_yang_checkers = ["pyang"]
let g:syntastic_yang_cppcheck_args =''
let g:syntastic_cpp_pyang_args='-f tree'

"let g:syntastic_debug = 1
"let g:syntastic_config_debug = 1

" All checkers errors together.
let g:syntastic_aggregate_errors = 1
"let g:syntastic_cpp_clang_tidy_sort = 0

let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_c_remove_include_errors = 1 " try not so slow"
" not needeed    let g:syntastic_cpp_compiler = "g++"
" End  : syntastic

" INIT : clang complete (https://github.com/justmao945/vim-clang)
" path
let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
" C, kernel,etc
let g:clang_c_options = '-std=gnu11'
let g:clang_c_completeopt = 'longest,menuone,preview'
" split SCREEN horizontally, with new split on the top
"let g:clang_diagsopt = '' " Disable clang diagnostics, no to clash with syntastic.
let g:clang_diagsopt = 'botright'
let g:clang_pwheight = 4
let g:clang_verbose_pmenu = 1 " popup very verbose
let g:clang_compilation_database='./compile_commands.json'
let g:clang_check_syntax_auto=0 " avoid automatic syntax check on write.
" END : clang complete
" INIT : vim clang (https://github.com/xavierd/clang_complete)
" let g:clang_use_library=1
" let g:clang_library_path='/path/to/lib'
" END  : vim clang

"INIT python mode
let g:pymode_python = 'python3'
"let g:pymode_rope = 0 " rope slows down vim at save time.
" Override go-to.definition key shortcut to Ctrl-]
let g:pymode_rope_goto_definition_bind = "<C-]>"

" END python mode

" Init : pathogen
filetype off
execute pathogen#infect()
execute pathogen#helptags()

filetype plugin indent on
syntax on
" End : pathogen
"
"
"
"
"
"   Hard way
"nnoremap <leader>ev :split $MYVIMRC<cr>
"nnoremap <leader>sv :source $MYVIMRC<cr>
"vnoremap xx <Esc>`>a"<Esc>`<i"<Esc>
"vnoremap qq <Esc>`>a'<Esc>`<i'<Esc>
:onoremap p i() "operator pending, for 'pa'rameters"




au CursorHold *c,*h echo "Ping! " . expand("<cword>") . " " . expand("<afile>")

"" START : Help conf python_mode plugin
"
"python3 << EOF
"import vim
"import git
"def is_git_repo():
"   try:
"       _ = git.Repo('.', search_parent_directories=True).git_dir
"       return "1"
"   except:
"       return "0"
"vim.command("let g:pymode_rope = " + is_git_repo())
"EOF
"
" " END : Help conf python_mode plugin






