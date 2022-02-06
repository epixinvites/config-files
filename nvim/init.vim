" neovide configuration
set guifont=Iosevka:h6
let g:neovide_cursor_animation_length=0.0

" Plugin initialization
call plug#begin('~/.config/nvim/plugged')
Plug 'olimorris/onedarkpro.nvim'
Plug 'tabnine/YouCompleteMe', { 'do': './install.py' } " switch to coc.nvim after this breaks
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'jdhao/whitespace.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'
Plug 'folke/which-key.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'
Plug 'kyazdani42/nvim-tree.lua' " https://github.com/kyazdani42/nvim-tree.lua
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/popup.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'mzlogin/vim-markdown-toc'
Plug 's1n7ax/nvim-terminal'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
Plug 'ahmedkhalf/project.nvim'
Plug 'rhysd/vim-clang-format'
Plug 'antoyo/vim-licenses'
Plug 'mfussenegger/nvim-dap'
Plug 'renerocksai/telekasten.nvim'
Plug 'renerocksai/calendar-vim'
Plug 'brooth/far.vim'		" Search and replace -- https://github.com/brooth/far.vim
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

let g:ycm_min_num_of_chars_for_completion = 3
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

let g:nvim_tree_quit_on_open = 1

let g:vmt_auto_update_on_save = 1

let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 1
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

require("nvim-autopairs").setup{
	enable_check_bracket_line = true,
	check_ts = true,
	fast_wrap = {
		map = '<M-e>',
		offset = 0
	}
}

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

require("statusline-config")

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
  	extensions = {
    	media_files = {
      		-- filetypes whitelist
      		-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      		filetypes = {"png", "webp", "jpg", "jpeg"},
      		find_cmd = "rg" -- find command (defaults to `fd`)
    	}
  	},
}

require("project_nvim").setup{
	patterns = { ".git", "build", ".project_root", "README*" },
}
require("telescope").load_extension("projects")
require("telescope").load_extension("dap")
require("telescope").load_extension("media_files")

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

local home = vim.fn.expand("~/zettelkasten")
require("telekasten").setup{
	home = home,
	take_over_my_home = true,
	auto_set_filetype = true,
	dailies = home .. '/' .. 'daily',
	weeklies = home .. '/' .. 'weekly',
	templates = home .. '/' .. 'templates',
	image_subdir = "img",
	extension = ".md",
	follow_creates_nonexisting = true,
	dailies_create_nonexisting = true,
	weeklies_create_nonexisting = true,
	template_new_note = nil,
	template_new_daily = nil,
	template_new_weekly = nil,
	image_link_style = "markdown",
	plug_into_calendar = true,
	calendar_opts = {
		weeknm = 4,
		calendar_monday = 0,
		calendar_mark = 'left-fit',
	},
    close_after_yanking = false,
    insert_after_inserting = true,
	tag_notation = "#tag",
	command_palette_theme = "dropdown",
	show_tags_theme = "dropdown",
	subdirs_in_links = true,
	template_handling = "always_ask",
	new_note_location = "prefer_home",
	rename_update_links = true,
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

autocmd BufWritePost * StripTrailingWhitespace

au FileType cpp nnoremap 	<buffer><silent><C-s>k	:JbzCppMan<CR>
au FileType cpp nnoremap 	<buffer><C-s>b			:Dispatch! cd build/ && cmake .. && make -j6<CR>
au FileType cpp nnoremap 	<buffer><F5>			:lua require("dap").continue()<CR>
au FileType cpp nnoremap 	<buffer><silent><F11>	:lua require("dap").toggle_breakpoint()<CR>
au FileType cpp nnoremap 	<buffer><silent><F12>	:lua require("dap").repl.open()<CR>
au FileType cpp nnoremap	<buffer><leader>G		:Gpl<CR>
au FileType cpp inoremap 	<buffer><silent><C-f>	<Esc> l :lua require("nvim-autopairs.fastwrap").show()<CR>
au FileType cpp nnoremap	<C-s>B					:!cmp-cpp --silent

nnoremap	<silent><C-s>T		:Telekasten panel<CR>
nnoremap 	<silent><C-s>t		:NvimTreeToggle<CR>
nnoremap    <silent><C-s>s      :Telescope projects<CR>
nnoremap 	<silent><C-s>w		:StripTrailingWhitespace<CR>
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
