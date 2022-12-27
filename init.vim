" INI The Classics
set nocompatible "nvim is always nocompatible
set showmatch
set hlsearch
set incsearch
set number
set autoindent
set wildmode=longest, list
set cc=80
set clipboard=unnamedplus
set ttyfast
set backup
augroup DynamicNumber " Number in current split only, save space.
    autocmd WinEnter * set number
    autocmd WinLeave * set nonumber
augroup END
set ignorecase " This case combination config seems util
set smartcase  " This case combination config seems util
" END The Classics


" PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
" Start Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim' " Pictogram in for lsp Maybe clash with lsp_signature
Plug 'ray-x/lsp_signature.nvim' " signature as you type

" End Completion
Plug 'fatih/vim-go'
Plug 'morhetz/gruvbox'
Plug 'ervandew/supertab'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'sebdah/vim-delve' " Better delve integration that vim-go
Plug 'preservim/tagbar'
Plug 'dominikduda/vim_current_word' " Highlight current word
" Init nsnip
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip' " the snippets itself
" End nsnip
Plug 'mfussenegger/nvim-lint' " Linter for nvim
"
"
" Init : Rust
Plug 'simrat39/rust-tools.nvim'
" End : Rust

" Init : treesitter
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'rose-pine/neovim'
" End : treesitter
"
" Init : telescope (fd and ripgrep are dependencies commands)
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim' " native sorter for performance
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
" or                                , { 'branch': '0.1.x' }
" End : telescope

Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " Here avoid class with LSP maps, in particular 'gd'

call plug#end()

" INIT formatting
autocmd FileType json setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType c,c++ set equalprg=clang-format\ --style='file' " Use .clang-format conf file"
autocmd FileType rust set equalprg=rustfmt
autocmd BufWritePre *.rs call FormatOnSaveRust()
function! FormatOnSaveRust()
	let cursor_position = getpos('.')
	:%!rustfmt
	if v:shell_error > 0 
		silent undo
	endif
	call setpos('.', cursor_position)
endfunction
" END formatting


" INIT make command
autocmd FileType rust set makeprg=cargo\ build
" END make command


" INIT color
colorscheme rose-pine
" END color

" INIT global status line
set laststatus=3 "Starting nvim 0.7 global status line
" Set line separator between split less wide with "highlight Win... "
" highlight WinSeparator guibg=None " Not needed as colorscheme do that.
" END global status line

" Active de english dictionary ([s,]s and 'Z=')
setlocal spell spelllang=en_us

set completeopt=menu,menuone,noselect

" INIT supertab
let g:SuperTabDefaultCompletionType = "context"
" END supertab
" For c files use clang complete which use omni instead <C-P>
autocmd FileType yaml let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
autocmd FileType yaml set omnifunc=v:lua.vim.lsp.omnifunc completeopt=noinsert,menuone
autocmd FileType c,go let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
autocmd FileType vim let g:SuperTabDefaultCompletionType = "<c-x><c-p>"

autocmd FileType sh let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
autocmd FileType py let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
" END supertab

" INIT tab
nmap <gt> :tabnext<CR>
nmap <gT> :tabprev<CR>
" END tab
"
nmap <F6> :cprev<CR>
nmap <F7> :cnext<CR>

" INIT key mappings
nmap <F1> :call MyGrep()<CR>
function! MyGrep()
	let myExtension = '*.' . expand('%:e')
	:execute 'silent grep -R <cword> --include ' . myExtension . ' .'
	copen
endfunction
function! MyGrepParam()
	let myExtension = '*.' . expand('%:e')
	let name = input('Search for: ')
	:execute 'silent grep -R ' . name . ' --include ' . myExtension . ' .'
	copen
endfunction
nmap <F2> gg=G<C-o><C-o> " Go init, go end, format,back,back"
nmap <F3> :call MyGrepParam()<CR>
nmap <F4> :GitGutterFold <CR>
nmap <F5> :GitGutterUndoHunk <CR>
nmap <F6> :cprev <CR>
nmap <F7> :cnext <CR>
nmap <F8> :TagbarToggle<CR>
nmap <F9> :TagbarCurrentTag p  <CR>
nmap <F10> :lua require('lint').try_lint() <CR>
nmap <F12> :GitGutterPreviewHunk <CR>
" END key mappings



" From the github tagbar comments on issues
let g:tagbar_type_go = {  
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }
" END tagbar

" INIT Easy,simple autocomplete
"set completeopt-=preview " Avoid scratch  split WANT see doc
set completeopt=menu,menuone,noselect " From yamlls github
set pumheight=5 " Limit menu size to allow see scratch with doc
" END Easy,simple autocomplete


" INI Move blocks
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
" END Move blocks




" INIT : LUA CONFIG
lua << EOF

-- INIT debuggin
vim.lsp.set_log_level("debug") -- check ~/.cache/nvim/lsp.log
-- END debuggin

-- INIT nvim-lint
require('lint').linters_by_ft = {
  go = {'golangcilint',},
  sh = {'shellcheck',},
  c = {'clangtidy'}
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
-- END nvim-lint

servers = { 'pyright', 'bashls', 'clangd', 'gopls','yamlls'} --, 'rust-analyzer' }


-- INIT lsp_signature
 cfg = {
  debug = false, -- set to true to enable debug logging
  log_path = "debug_log_file_path", -- debug log path
  verbose = false, -- show debug line number

  bind = true, -- This is mandatory, otherwise border config won't get registered.
               -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode, it does not affect signature help in normal
                 -- mode, 10 by default

  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap
  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🔭", --🐼 ",  -- Panda for parameter
  hint_scheme = "String",
  use_lspsaga = false,  -- set to true if you want to use lspsaga popup
  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                   -- to view the hiding contents
  max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  handler_opts = {
    border = "rounded"   -- double, rounded, single, shadow, none
  },

  always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

  transparency = nil, -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = nil -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
}

-- recommanded:
require'lsp_signature'.setup(cfg) -- no need to specify bufnr if you don't use toggle_key

-- You can also do this inside lsp on_attach
-- note: on_attach deprecated
--require'lsp_signature'.on_attach(cfg, bufnr) -- no need to specify bufnr if you don't use toggle_key
-- END lsp_signature



-- END lsp_signature


-- INI Setup lsp

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
capabilities=capabilities -- Is this the correct possition :-\
    }
  }
end

-- INIT Setup rust-analyzer , it seems rust is bit special.
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})
-- END Setup rust-analyzer




-- END Setup lsp







-- INIT . yaml
  local custom_lsp_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end
nvim_lsp.yamlls.setup {
	on_attach = custom_lsp_attach,
	flags = {
		debounce_text_changes = 150,
		},
	settings = {
		yaml = {
			trace = {                                                                                                                                                                                       
				server = "verbose"                                                                                                                                                                          
				},  
			hover = {"enable"},
			schemas = {
				["kubernetes"] = "/*.yaml" ,
				--["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.yaml"
				--["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
				--["../path/relative/to/file.yml"] = "/.github/workflows/*",
				--["/path/from/root/of/project"] = "/.github/workflows/*"
				},
			schemaStore = {
				url = "https://www.schemastore.org/api/json/catalog.json",
			enable = true,
			}
		},
	}
}
-- END . yaml

  -- INIT Setup luasnip
 local luasnip = require 'luasnip'
  -- END Setup luasnip

  -- INIT Setup nvim-cmp.
local cmp = require("cmp")

cmp.setup{
        snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                path = "[Path x]",
                buffer = "[Buffer x]",
                nvim_lsp = "[LSP x]",
                luasnip = "[SNIP x]",
                nvim_lua = "[Lua x]",
            })[entry.source.name]
            vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. "🔭" .. vim_item.kind
            vim_item.abbr = string.sub(vim_item.abbr, 1, 50)
            return vim_item
        end
    },
    window = {
        documentation = cmp.config.window.bordered()
    },
mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
},
    sources = cmp.config.sources({
      { name = 'luasnip' }, -- For luasnip users.
      { name = 'nvim_lsp' },
      --{ name = 'vsnip' }, -- For vsnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  }

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({'/','?'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['gopls'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach
    }
    end

  -- END Setup nvim-cmp.

EOF




lua << EOF
-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'bash', 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'help' },

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']]'] = '@function.outer',
        [']m'] = '@class.outer',
      },
      goto_next_end = {
        [']['] = '@function.inner',
        [']M'] = '@class.outer',
      },
      goto_previous_start = {
        ['[['] = '@function.outer',
        ['[m'] = '@class.outer',
      },
      goto_previous_end = {
        ['[]'] = '@function.outer',
        ['[M'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}


EOF

lua << EOF
-- INIT : Telescope setup
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fg', builtin.grep_string, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- END : Telescope setup
EOF
