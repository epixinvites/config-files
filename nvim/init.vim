" neovide configuration
set guifont=Iosevka:h6
let g:neovide_cursor_animation_length=0.0

" Plugin initialization
call plug#begin('~/.config/nvim/plugged')
Plug 'olimorris/onedarkpro.nvim'
Plug 'tabnine/YouCompleteMe', { 'do': './install.py' }
Plug 'cohama/lexima.vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ntpeters/vim-better-whitespace' " :StripWhitespace
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'folke/which-key.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'
Plug 'kyazdani42/nvim-tree.lua' " https://github.com/kyazdani42/nvim-tree.lua
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 's1n7ax/nvim-search-and-replace' " https://github.com/s1n7ax/nvim-search-and-replace
Plug 'nvim-lua/popup.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'mzlogin/vim-markdown-toc'
Plug 's1n7ax/nvim-terminal'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
Plug 'ahmedkhalf/project.nvim'
Plug 'rhysd/vim-clang-format'
Plug 'antoyo/vim-licenses'
Plug 'mfussenegger/nvim-dap'
call plug#end()

syntax on

set clipboard+=unnamedplus
set nocompatible            	" disable compatibility to old-time vi
set showmatch               	" show matching brackets.
set hlsearch                	" highlight search results
set autoindent              	" indent a new line the same amount as the line just typed
set number                  	" add line numbers
set wildmode=longest,list  	    " get bash-like tab completions
set cc=200                 	    " set colour columns for good coding style
set tabstop=4					" number of columns occupied by a tab character
set shiftwidth=4				" width for autoindents
set autowriteall
set autoread
set signcolumn=yes
set ssop+=folds

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
set foldenable

let g:ycm_key_list_stop_completion = ['<C-x>']
let g:ycm_filetype_whitelist = { 'cpp':1 }
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf = 0                 " Don't confirm python conf
let g:ycm_always_populate_location_list = 1      " Always populae diagnostics list
let g:ycm_enable_diagnostic_signs = 1            " Enable line highligting diagnostics
let g:ycm_open_loclist_on_ycm_diags = 1          " Open location list to view diagnostics
let g:ycm_update_diagnostics_in_insert_mode = 1  " Start diagnostics in insert mode
let g:ycm_max_num_candidates = 5                " Max number of completion suggestions
let g:ycm_max_num_identifier_candidates = 3     " Max number of identifier-based suggestions
let g:ycm_auto_trigger = 1                       " Enable completion menu
let g:ycm_show_diagnostic_ui = 1                 " Show diagnostic display features
let g:ycm_enable_diagnostic_signs = 1            " Display icons in Vim's gutter, error, warnings
let g:ycm_enable_diagnostic_highlighting = 1     " Highlight regions of diagnostic text
let g:ycm_echo_current_diagnostic = 1            " Echo line's diagnostic that cursor is on
let g:ycm_max_diagnostics_to_display = 0

let g:lexima_enable_basic_rules = 1
let g:lexima_enable_newline_rule = 1

let g:airline_powerline_fonts = 1
let g:airline_theme = 'deus'
let g:airline#extensions#ycm#enabled = 1

let g:better_whitespace_enabled = 1
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 0
let g:strip_whitelines_at_eof = 1

let g:nvim_tree_quit_on_open = 1

let g:vmt_auto_update_on_save = 1

let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 1
let g:clang_format#auto_format_on_insert_leave = 1
let g:clang_format#auto_filetypes = ["cpp", "c"]
let g:clang_format#enable_fallback_style = 0

let g:licenses_copyright_holders_name = 'Zhi Ping, Ooi <epixunknown@protonmail.com>'
let g:licenses_default_commands = ['gpl']

lua << EOF
local function restore_nvim_tree()
    local nvim_tree = require('nvim-tree')
    nvim_tree.change_dir(vim.fn.getcwd())
    -- nvim_tree.refresh()
end

vim.o.background = "dark" -- to load onedark
require("onedarkpro").load{}

require("bufferline").setup{
    options = {
        show_buffer_icons = true, -- Change to false if Nerd Font fuckery doesn't work
        show_buffer_close_icons = false,
        show_close_icon = false,
        always_show_bufferline = true
    }
}

require("which-key").setup{}

vim.g.nvim_tree_respect_buf_cwd = 1
require("nvim-tree").setup{
	update_cwd = true,
  		update_focused_file = {
    	enable = true,
    	update_cwd = true
  	},
}

require("indent_blankline").setup{}

require("nvim-treesitter.configs").setup {
  	highlight = {
    	enable = true,
    	additional_vim_regex_highlighting = false,
  	},
}

require("nvim-search-and-replace").setup{}

vim.o.hidden = true
require("nvim-terminal").setup{
    window = {
        -- Do `:h :botright` for more information
        -- NOTE: width or height may not be applied in some "pos"
        position = 'botright',

        -- Do `:h split` for more information
        split = 'sp',

        -- Width of the terminal
        width = 50,

        -- Height of the terminal
        height = 15,
    },

    -- keymap to disable all the default keymaps
    disable_default_keymaps = false,

    -- keymap to toggle open and close terminal window
    toggle_keymap = '<leader>;',

    -- increase the window height by when you hit the keymap
    window_height_change_amount = 2,

    -- increase the window width by when you hit the keymap
    window_width_change_amount = 2,

    -- keymap to increase the window width
    increase_width_keymap = '<leader><leader>+',

    -- keymap to decrease the window width
    decrease_width_keymap = '<leader><leader>-',

    -- keymap to increase the window height
    increase_height_keymap = '<leader>+',

    -- keymap to decrease the window height
    decrease_height_keymap = '<leader>-',

    terminals = {
        -- keymaps to open nth terminal
        {keymap = '<leader>1'},
        {keymap = '<leader>2'},
        {keymap = '<leader>3'},
        {keymap = '<leader>4'},
        {keymap = '<leader>5'},
    },
}

-- temporary fix file folding
local telescope_actions = require("telescope.actions.set")
local fixfolds = {
	hidden = true,
	attach_mappings = function(_)
		telescope_actions.select:enhance({
			post = function()
				vim.cmd(":normal! zx")
			end,
		})
		return true
	end,
}
require("telescope").setup{
	pickers = {
		buffers = fixfolds,
		find_files = fixfolds,
		git_files = fixfolds,
		grep_string = fixfolds,
		live_grep = fixfolds,
		oldfiles = fixfolds,
	},
}

require("project_nvim").setup{
	patterns = { ".git", "build", ".project_root", "README*" },
}
require("telescope").load_extension('projects')

local dap = require('dap')
dap.adapters.cppdbg = {
  	id = 'cppdbg',
  	type = 'executable',
  	command = '/home/arch-angel/.config/nvim/nvim-dap-extensions/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7',
}
dap.configurations.cpp = {
	{
    	name = "Launch file",
    	type = "cppdbg",
    	request = "launch",
    	program = function()
      		return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    	end,
    	cwd = '${workspaceFolder}',
    	stopOnEntry = true,
		setupCommands = {
  			{
     			text = '-enable-pretty-printing',
     			description =  'enable pretty printing',
     			ignoreFailures = false
  			},
		},
	},
}
EOF

function! s:JbzCppMan()
    let old_isk = &iskeyword
    setl iskeyword+=:
    let str = expand("<cword>")
    let &l:iskeyword = old_isk
    execute 'vertical rightbelow Man ' . str
endfunction
command! JbzCppMan :call s:JbzCppMan()

au FileType cpp nnoremap <buffer><silent><C-s>k	:JbzCppMan<CR>
au FileType cpp nnoremap <buffer><C-s>b			:Dispatch! cd build/ && cmake .. && make -j6<CR>

nnoremap	<leader>G			:Gpl<CR>

nnoremap	<C-s>B				:!cmp-cpp --silent
nnoremap 	<silent><C-s>t		:NvimTreeToggle<CR>
nnoremap    <silent><C-s>s      :Telescope projects<CR>
nnoremap 	<silent><C-s>w		:StripWhitespace<CR>
nnoremap	<silent><C-s>f		:FormatWrite<CR>

nnoremap	<silent>]b  		:BufferLineCycleNext<CR>
nnoremap	<silent>[b  		:BufferLineCyclePrev<CR>
nnoremap	<silent><C-x>}  	:BufferLineMoveNext<CR>
nnoremap	<silent><C-x>{  	:BufferLineMovePrev<CR>
nnoremap	<silent><C-x>p  	:BufferLinePick<CR>
nnoremap	<silent><C-x>c  	:BufferLinePickClose<CR>
nnoremap	<silent><C-x>E  	:BufferLineSortByExtension<CR>
nnoremap	<silent><C-x>D  	:BufferLineSortByDirectory<CR>
nnoremap 	<silent><C-x>1 		:BufferLineGoToBuffer 1<CR>
nnoremap 	<silent><C-x>2 		:BufferLineGoToBuffer 2<CR>
nnoremap 	<silent><C-x>3 		:BufferLineGoToBuffer 3<CR>
nnoremap 	<silent><C-x>4 		:BufferLineGoToBuffer 4<CR>
nnoremap 	<silent><C-x>5 		:BufferLineGoToBuffer 5<CR>
nnoremap 	<silent><C-x>6 		:BufferLineGoToBuffer 6<CR>
nnoremap 	<silent><C-x>7 		:BufferLineGoToBuffer 7<CR>
nnoremap 	<silent><C-x>8 		:BufferLineGoToBuffer 8<CR>
nnoremap 	<silent><C-x>9 		:BufferLineGoToBuffer 9<CR>
