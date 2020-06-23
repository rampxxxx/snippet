" ~/.vimrc (configuration file for vim only)

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
colorscheme evening

"set path+=/usr/src/linux/include
"set path+=/usr/src/linux/include/linux
" ~/.vimrc ends here
":set tags=/home/ramp/pruebas/nouveau/xf86-video-nouveau/tags

"map <C-F11> : :TlistToggle<CR>

filetype on
filetype plugin on "needed for snipets plugin 

let g:clang_complete_copen=1 "abre copen si hay error
let g:clang_user_options='|| exit 0'
"let g:clang_user_options='-std=c++14'
let g:clang_complete_auto = 1 "completa tras ->, ., ::
let g:clang_hl_errors = 1 "highlight on errors and warnings
let g:clang_periodic_quickfix = 1 "actualiza quicfix periodicamente
let g:clang_snippets = 1

set tags=tags

nmap <C-Right> gt<CR>
nmap <C-Left> gT<CR>



"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']

