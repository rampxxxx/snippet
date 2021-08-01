" ini : format
" -IN FRR KERNEL COD STYLE- set tabstop=2 shiftwidth=4 expandtab " tab as 4 spaces"
set colorcolumn=80
set equalprg=clang-format\ --style='file' " Use .clang-format conf file"

"mouse setting, avoid mouse changes to visual mode
set mouse=

" end : format

set wildmenu "autocompletar visual en comandos vim
"set cursorline "Print a line at current position
"set cursorcolumn "Print a column at current position
" hi CursorColumn ctermbg=8 "Change color but default seems ok.

" ini : netrw
let g:netrw_browse_split = 4 " open to previous window
let g:netrw_liststyle = 3    " tree list of files.
let g:netrw_winsize = 10
" end : netrw


set laststatus=2 "allways show status line
set nocompatible
set incsearch
set hlsearch
set nu
set cindent
set autoindent
set smartindent
set showmatch
set wildmenu
set showmode
set list
"set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵ "Show chars if 'set list' "
"set listchars=eol:$,tab:>-,trail:-,nbsp:_ "No so fancy chars but faster
set listchars=eol:$,tab:>->,trail:-,nbsp:_ "No so fancy chars but faster

"" default colorscheme blue match better with all ring&bells.
"colorscheme morning  " white bg 
colorscheme shine " white bg
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
nmap <F12> gg=G<C-o><C-o> " Go init, go end, format,back,back"
nnoremap n nzz
set cscopequickfix=s-,c-,d-,i-,t-,e- " Lista en ventana copen
set cscopetag " Utilizar cscope y luego tags en ctrl-]
" end: cscope



let g:airline_powerline_fonts = 1 " Airline plugin, populate symbols"
set t_Co=256 " set proper term to allow bg col in airline"
" Don't want git info in airline
"let g:airline_section_b ='b'
"let g:airline_section_x ='x'
"let g:airline_section_z ='z'
"let g:airline_section_warning ='w'

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
let g:syntastic_sparse_config_file = '.clang_tidy' " for cpp_config
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
"It seems that cpp options apply to .h and '-*' doesn't work
let g:syntastic_cpp_clang_tidy_args='clang-analyzer-*,-clang-analyzer-cplusplus*,-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling,clang-analyzer-security.insecureAPI.bzero,-clang-analyzer-security.insecureAPI.strcpy,-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling'
" yang checker
let g:syntastic_yang_checkers = ["pyang"]
""pyang -p yang:yang/ietf:YANG/yang/standard/ietf/RFC yang/frr-isisd.yang
let g:syntastic_yang_pyang_args='-p yang:yang/ietf:YANG/yang/standard/ietf/RFC'

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
let g:clang_c_completeopt = 'longest,menuone'
let g:clang_cpp_completeopt = 'longest,menuone' " as header are type cpp
" split SCREEN horizontally, with new split on the top
let g:clang_diagsopt = '' " Disable clang diagnostics, no to clash with syntastic.
let g:clang_pwheight = 4
let g:clang_verbose_pmenu = 1 " popup very verbose
""""""""let g:clang_compilation_database='./compile_commands.json'
let g:clang_check_syntax_auto = 0 " avoid automatic syntax check on write.
" END : clang complete
" INIT : vim clang (https://github.com/xavierd/clang_complete)
" let g:clang_use_library=1
" let g:clang_library_path='/path/to/lib'
" END  : vim clang
"
" INIT supertab
let g:SuperTabDefaultCompletionType = "context"
" For c files use clang complete which use omni instead <C-P>
autocmd FileType c let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
autocmd FileType vim let g:SuperTabDefaultCompletionType = "<c-x><c-p>"
" END supertab

"INIT python mode
let g:pymode_python = 'python3'
"let g:pymode_rope = 0 " rope slows down vim at save time.
" Override go-to.definition key shortcut to Ctrl-]
let g:pymode_rope_goto_definition_bind = "<C-]>"

" END python mode

" Init : pathogen
filetype on
execute pathogen#infect()
execute pathogen#helptags()

syntax on
filetype plugin indent on
" End : pathogen
"
"
"
"
"
"   Hard way https://github.com/rampxxxx/snippet.git
"nnoremap <leader>ev :split $MYVIMRC<cr>
"nnoremap <leader>sv :source $MYVIMRC<cr>
"vnoremap xx <Esc>`>a"<Esc>`<i"<Esc>
"vnoremap qq <Esc>`>a'<Esc>`<i'<Esc>
:onoremap p i() "operator pending, for 'pa'rameters"


function MiBusca()
	let g:MiBusca_pastCurrentLine = get(g:, 'MiBusca_pastCurrentLine', 0)
	if g:MiBusca_pastCurrentLine == line(".")
		echom "Nothing, same line"
		return
	else
		echom "New line, lets work"
	endif
	echom "Running ramp miBusca on:" expand("<cword>")
	let miTag = trim(execute("TagbarCurrentTag"))
	let miTagSinParentesis = substitute(miTag, '()', '', '')
	let miWord = expand("<cword>")          " get the word under cursor
	let miWORD = expand("<cWORD>")          " get the word under cursor
	let miFile = expand("<afile>")          " get the word under cursor
	let miFileEscaped = substitute(miFile, '/','\\/','g')
	let miFuncScope = "| sed -n \'/" . miFileEscaped . "/,//p\' | sed -n \'/FunctionDecl.*" . miTagSinParentesis . "/,/FunctionDecl/p\'"
	let miLimpiaColorChars = "| sed 's/\x1b\[[0-9;]*m//g'"
	if miWord =~ '\a'                       " if the word contains a letter
		"if strlen(expand("<cword>")) > 0
		"echom "miWord " . miWord
		let decl_command_scoped = "clang-check " . miFile  . " -ast-dump  2>/dev/null  " . miFuncScope . "| grep  \"VarDecl\\|FunctionDecl\" | grep -v Parm | " . "grep -w " . miWord . " | head -1" . miLimpiaColorChars
		"echom decl_command_scoped
		let show_string_clang = trim(system(decl_command_scoped))
		if strlen(show_string_clang) > 0
" Local definition
			"echo show_string_clang
			let show_string_clang=miTag . " " . show_string_clang
		else
" Global definition
			let decl_command_global = "clang-check " . miFile  . " -ast-dump  2>/dev/null  | grep  \"VarDecl\\|FunctionDecl\" | grep -v Parm | " . "grep -w " . miWord . " | head -1" . miLimpiaColorChars
			let show_string_clang = trim(system(decl_command_global))
			"echo show_string_clang
		endif
		let show_string_clang=miFile . " " . show_string_clang


		"echom "miTagSinParentesis" . miTagSinParentesis
		if miWORD =~ '('
			"let cscopeCmd = "cscope -L -1 " . miWord " good for functions
			let cscopeCmd = "cscope -L -1 " . miWord . " | head -1"
		else
			"let cscopeCmd = "cscope -L -0 " . miWord . " |grep \"" . miTagSinParentesis  .  "\" |head -1"
			let cscopeCmd = "cscope -L -0 " . miWord . " |grep \"" . miFileEscaped  .  "\" |grep " . miTagSinParentesis . " |head -1"
		endif
		echom "Mi cscope cmd : " . cscopeCmd
		let cscopeRes = system(cscopeCmd)
		"echom "cscopeRes:(" . cscopeRes . ")"
		let show_string_cscope=''
		if strlen(cscopeRes) > 0
			echom "Try cscope"
		if cscopeRes =~ '('
			"echom " El res: " . cscopeRes . " ¡es una funcion!"

			let miFileDefFunctionCmd = " echo \"" . cscopeRes . "\" |awk \'{print $1}\'"
			let miLineDefFunctionCmd = " echo \"" . cscopeRes . "\" |awk \'{print $3}\'"
			"echom "miFileDefFunctionCmd:" . miFileDefFunctionCmd
			let miFileDefFunction = system(miFileDefFunctionCmd)
			let miLineDefFunction = system(miLineDefFunctionCmd)
			let miFileDefFunction=substitute(miFileDefFunction,'\n','','g')
			let miLineDefFunction=substitute(miLineDefFunction,'\n','','g')
			"echom "miFileDefFunction:".miFileDefFunction
			let miCmdTrozoFile="cat " . miFileDefFunction . " |sed -n \'" . miLineDefFunction . ",/^}/p\'"
			"echom miCmdTrozoFile
			let cscopeRes=system(miCmdTrozoFile)
			let show_string_cscope=substitute(cscopeRes, '\n','','')
		else
			let show_string_cscope=cscopeRes
		endif
	else
		echom "Try tags"
		let miTagCmdForFile = "grep " . miWord . " tags |awk \'{print $2}\'"
		let miTagFile = system(miTagCmdForFile)
		let miTagFile=substitute(miTagFile, '\n','','')
		let miCmdTrozoFile="cat " . miTagFile . " |sed -n \'/" . miWord . "/,/^}/p\'"
		"echom "miCmdTrozoFile:" . miCmdTrozoFile
		let tagRes=system(miCmdTrozoFile)
		"echom "tagRes:" . tagRes
		let show_string_cscope=substitute(tagRes, '\n','','')
	endif

		let l:command = "silent! pedit! +setlocal\\ " .
					\ "buftype=nofile\\ nobuflisted\\ " .
					\ "noswapfile\\ nonumber\\ " .
					\ "filetype=c mipreview"
		exe l:command

		if strlen(show_string_clang) > 0
			call setbufline("mipreview",1,show_string_clang)
		endif
		if strlen(show_string_cscope) > 0

			let cscopeResMulLine = split(show_string_cscope,"\n")
			"call popup_atcursor(cscopeResMulLine, #{ line: 5, col: 10, highlight: 'WildMenu', border: [] } )
			"silent! pedit filetype=c mipreview
			"call setbufline("mipreview",1,cscopeResMulLine)


			call setbufline("mipreview",2,cscopeResMulLine)
		endif


	endif
	let g:MiBusca_pastCurrentLine = line(".")
endfunction

set updatetime=1000 " run every second
"au! CursorHold *.[ch] nested silent! call MiBusca() " silent
"au! CursorHold *.[ch] nested call MiBusca() " show messages

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



" Speel check
setlocal spell spelllang=en_us



