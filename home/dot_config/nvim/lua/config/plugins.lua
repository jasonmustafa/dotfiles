vim.pack.add({
	-- Dependencies
	{ src = "https://github.com/MunifTanjim/nui.nvim" }, -- for neo-tree
	{ src = "https://github.com/nvim-lua/plenary.nvim" }, -- for neo-tree

	-- Theme & UI
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/nvim-mini/mini.icons" }, -- for mini.statusline
	{ src = "https://github.com/nvim-mini/mini.notify" },
	{ src = "https://github.com/nvim-mini/mini.statusline" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/nvim-mini/mini.cursorword" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
	{ src = "https://github.com/nvim-mini/mini.indentscope" },

	-- Editing & navigation
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-mini/mini.files" },
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
	{ src = "https://github.com/nvim-mini/mini.pairs" },
	{ src = "https://github.com/nvim-mini/mini.surround" },
	{ src = "https://github.com/NMAC427/guess-indent.nvim" },
	{ src = "https://github.com/nvim-mini/mini.ai" },
	{ src = "https://github.com/mfussenegger/nvim-lint" },

	-- LSP & completion
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" }, -- for blink snippets
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/aznhe21/actions-preview.nvim" },

	-- Tooling & misc
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/nvim-mini/mini.clue" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	{ src = "https://github.com/vyfor/cord.nvim" },
	-- TODO: setup
	-- { src = "https://github.com/xvzc/chezmoi.nvim" },
})

-- Theme & UI
require("catppuccin").setup({
	transparent_background = true,
	float = { transparent = true },
	integrations = {
		snacks = {
			enabled = true,
		},
	},
})
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()
require("mini.notify").setup()

local mode_map = {
	["NORMAL"] = " N",
	["O-PENDING"] = "󰇘 N?",
	["INSERT"] = " I",
	["VISUAL"] = " V",
	["V-BLOCK"] = " VB",
	["V-LINE"] = " VL",
	["V-REPLACE"] = " VR",
	["REPLACE"] = "󰬸 R",
	["COMMAND"] = " !",
	["SHELL"] = " SH",
	["TERMINAL"] = " T",
	["EX"] = "󰆍 X",
	["S-BLOCK"] = "󰓡 SB",
	["S-LINE"] = "󰓡 SL",
	["SELECT"] = "󰓡 S",
	["CONFIRM"] = " Y",
	["MORE"] = "󰇙 M",
}

local catppuccin_mocha = {
	rosewater = "#f5e0dc",
	blue = "#89b4fa",
	lavender = "#b4befe",
	green = "#a6e3a1",
	teal = "#94e2d5",
	mauve = "#cba6f7",
	peach = "#fab387",
	red = "#f38ba8",
	maroon = "#eba0ac",
	flamingo = "#f2cdcd",
	text = "#cdd6f4",
	base = "#1e1e2e",
	mantle = "#181825",
	surface0 = "#313244",
	surface1 = "#45475a",
	overlay0 = "#6c7086",
}

local C = catppuccin_mocha
local custom_theme = {
	normal = {
		a = { bg = C.lavender, fg = C.mantle, gui = "bold" },
		b = { bg = C.surface0, fg = C.lavender },
		c = { bg = "NONE", fg = C.text },
		y = { bg = C.maroon, fg = C.mantle, gui = "bold" },
		z = { bg = C.flamingo, fg = C.mantle, gui = "bold" },
	},
	insert = {
		a = { bg = C.teal, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.teal },
		y = { bg = C.maroon, fg = C.mantle, gui = "bold" },
		z = { bg = C.flamingo, fg = C.mantle, gui = "bold" },
	},
	terminal = {
		a = { bg = C.green, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.green },
		y = { bg = C.maroon, fg = C.mantle, gui = "bold" },
		z = { bg = C.flamingo, fg = C.mantle, gui = "bold" },
	},
	command = {
		a = { bg = C.peach, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.peach },
		y = { bg = C.maroon, fg = C.mantle, gui = "bold" },
		z = { bg = C.flamingo, fg = C.mantle, gui = "bold" },
	},
	visual = {
		a = { bg = C.mauve, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.mauve },
		y = { bg = C.maroon, fg = C.mantle, gui = "bold" },
		z = { bg = C.flamingo, fg = C.mantle, gui = "bold" },
	},
	replace = {
		a = { bg = C.red, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.red },
		y = { bg = C.maroon, fg = C.mantle, gui = "bold" },
		z = { bg = C.flamingo, fg = C.mantle, gui = "bold" },
	},
	inactive = {
		a = { bg = "NONE", fg = C.lavender },
		b = { bg = "NONE", fg = C.surface1, gui = "bold" },
		c = { bg = "NONE", fg = C.overlay0 },
	},
}

require("lualine").setup({
	options = {
		theme = custom_theme,
		globalstatus = true,
		component_separators = "",
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function(s) return mode_map[s] or s end,
				separator = { left = "", right = "" },
				right_padding = 2,
			},
		},
		lualine_b = { "branch" },
		lualine_c = {
			{ "diff", diff_color = { added = { fg = C.green }, modified = { fg = C.rosewater } } },
			{ "diagnostics", diagnostics_color = { warn = { fg = C.flamingo } } },
		},
		lualine_x = { "lsp_status", "progress", { "filetype", icon_only = true, icon = { align = "right" } } },
		lualine_y = { "location" },
		lualine_z = { { "filename", separator = { left = "", right = "" }, left_padding = 2 } },
	},
})

require("mini.cursorword").setup()
require("todo-comments").setup({ signs = false })
require("mini.indentscope").setup()

-- Editing & navigation
require("mini.pairs").setup()

-- Add/delete/replace surroundings (brackets, quotes, etc.)
-- Examples:
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require("mini.surround").setup()

-- require("oil").setup({
-- 	lsp_file_methods = { autosave_changes = true },
-- 	columns = { "permissions", "icon" },
-- 	view_options = { show_hidden = true },
-- 	delete_to_trash = true,
-- 	float = { max_width = 0.9, max_height = 0.9, border = "rounded" },
-- })

require("mini.files").setup({
	options = { permanent_delete = false, use_as_default_explorer = false },
	windows = { preview = true },
})

require("neo-tree").setup({
	filesystem = { window = { mappings = { ["\\"] = "close_window" } } },
	window = { position = "float" },
	popup_border_style = "",
})

require("toggleterm").setup({
	open_mapping = [[<c-\>]],
	direction = "float",
	float_opts = { border = "rounded" },
})

require("guess-indent").setup({})

-- Better Around/Inside textobjects
-- Examples:
-- - va)  - [V]isually select [A]round [)]paren
-- - yinq - [Y]ank [I]nside [Next] [Q]uote
-- - ci'  - [C]hange [I]nside [']quote
require("mini.ai").setup({ n_lines = 500 })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	callback = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			dockerfile = { "hadolint" },
			typescript = { "eslint" },
			zsh = { "zsh" },
		}

		-- Only run the linter in buffers that can be modified
		if vim.bo.modifiable then
			lint.try_lint()
		end
	end,
})

local Snacks = require("snacks")
Snacks.setup({
	picker = {},
})

-- LSP & completion
require("mason").setup()

require("blink.cmp").setup({
	appearance = { nerd_font_variant = "normal" },
	sources = { default = { "lsp", "path", "snippets" } },
	-- To install rust fuzzy finder:
	-- cd $HOME/.local/share/nvim/site/pack/core/opt/blink.cmp
	-- cargo +nightly build --release
	fuzzy = { implementation = "rust" },
	signature = { enabled = true },
})

-- Tooling & misc

-- Highlight, edit, and navigate code
-- :TSUpdate to update parsers
local ts_parsers = {
	"bash",
	"c",
	"diff",
	"dockerfile",
	"html",
	"json",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"typescript",
	"vim",
	"vimdoc",
	"zsh",
}
require("nvim-treesitter").install(ts_parsers)
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local buf, filetype = args.buf, args.match

		local language = vim.treesitter.language.get_lang(filetype)
		if not language then
			return
		end

		-- check if parser exists and load it
		if not vim.treesitter.language.add(language) then
			return
		end

		-- enables syntax highlighting and other treesitter features
		vim.treesitter.start(buf, language)

		-- enables treesitter based indentation
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format" },
	},
})

local miniclue = require("mini.clue")
miniclue.setup({
	triggers = {
		-- Leader triggers
		{ mode = { "n", "x" }, keys = "<Leader>" },
		-- `[` and `]` keys
		{ mode = "n", keys = "[" },
		{ mode = "n", keys = "]" },
		-- Built-in completion
		{ mode = "i", keys = "<C-x>" },
		-- `g` key
		{ mode = { "n", "x" }, keys = "g" },
		-- Marks
		{ mode = { "n", "x" }, keys = "'" },
		{ mode = { "n", "x" }, keys = "`" },
		-- Registers
		{ mode = { "n", "x" }, keys = '"' },
		{ mode = { "i", "c" }, keys = "<C-r>" },
		-- Window commands
		{ mode = "n", keys = "<C-w>" },
		-- `z` key
		{ mode = { "n", "x" }, keys = "z" },
	},
	clues = {
		-- Enhance this by adding descriptions for <Leader> mapping groups
		miniclue.gen_clues.square_brackets(),
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
		{ mode = { "n", "x" }, keys = "<Leader>p", desc = "+vim.pack" },
	},
	window = { delay = 0 },
})

require("render-markdown").setup({
	-- Makes headings render with highlighted blocks rather than full width blocks
	heading = { width = "block", left_pad = 2, right_pad = 4 },
	-- Keeps lines around rendered code blocks for opening and closing triple backticks
	code = { border = "thick" },
	-- Renders tables with rounded corners
	pipe_table = { preset = "round" },
})

require("cord").setup({
	text = {
		editing = "Editing file",
		workspace = "",
	},
})
