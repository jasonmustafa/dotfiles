vim.pack.add({
	-- Theme & UI
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/nvim-mini/mini.icons" }, -- for mini.pick
	{ src = "https://github.com/nvim-mini/mini.notify" },
	{ src = "https://github.com/nvim-mini/mini.statusline" },
	{ src = "https://github.com/nvim-mini/mini.cursorword" },

	-- Editing & navigation
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
	{ src = "https://github.com/nvim-mini/mini.pairs" },
	{ src = "https://github.com/nvim-mini/mini.surround" },
	{ src = "https://github.com/NMAC427/guess-indent.nvim" },

	-- Search & pickers
	{ src = "https://github.com/nvim-mini/mini.pick" }, -- for full exp: mini.icons + ripgrep
	{ src = "https://github.com/nvim-mini/mini.extra" },

	-- LSP & completion
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/aznhe21/actions-preview.nvim" },
	-- { src = "https://github.com/folke/trouble.nvim" }, -- i got weird behavior (probably skill issue)

	-- Tooling & misc
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/nvim-mini/mini.clue" },
	{ src = "https://github.com/vyfor/cord.nvim" },
})

-- Theme & UI
require("catppuccin").setup({
	transparent_background = true,
	float = { transparent = true },
})
require("mini.icons").setup()
require("mini.notify").setup()
require("mini.statusline").setup()
require("mini.cursorword").setup()

-- Editing & navigation
require("mini.pairs").setup()
require("mini.surround").setup()

require("oil").setup({
	lsp_file_methods = { autosave_changes = true },
	columns = { "permissions", "icon" },
	view_options = { show_hidden = true },
	delete_to_trash = true,
	float = {
		max_width = 0.9,
		max_height = 0.9,
		border = "rounded",
	},
})

require("toggleterm").setup({
	open_mapping = [[<c-\>]],
	direction = "float",
	float_opts = { border = "rounded" },
})

require("guess-indent").setup({})

-- Search & pickers
require("mini.pick").setup({
	window = {
		config = function()
			local height = math.floor(0.9 * vim.o.lines)
			local width = math.floor(0.9 * vim.o.columns)
			return {
				anchor = "NW",
				height = height,
				width = width,
				row = math.floor(0.5 * (vim.o.lines - height)),
				col = math.floor(0.5 * (vim.o.columns - width)),
			}
		end,
	},
})
require("mini.extra").setup()

local Snacks = require("snacks")
Snacks.setup({
	picker = {},
})

-- LSP & completion
require("mason").setup()
require("blink.cmp").setup({
	-- To install rust fuzzy finder:
	-- cd $HOME/.local/share/nvim/site/pack/core/opt/blink.cmp
	-- cargo +nightly build --release
	fuzzy = { implementation = "rust" },
})
-- require("trouble").setup()

-- Tooling & misc
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
})

require("cord").setup({
	text = {
		editing = "Editing file",
		workspace = "",
	},
})
