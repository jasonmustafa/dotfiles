vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/aznhe21/actions-preview.nvim" },
	{ src = "https://github.com/nvim-mini/mini.icons" }, -- for mini.pick
	{ src = "https://github.com/nvim-mini/mini.pick" }, -- requires mini.icons, ripgrep
	{ src = "https://github.com/nvim-mini/mini.pairs" },
	{ src = "https://github.com/nvim-mini/mini.surround" },
	{ src = "https://github.com/nvim-mini/mini.statusline" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/vyfor/cord.nvim" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
	{ src = "https://github.com/folke/trouble.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/nvim-mini/mini.extra" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/nvim-mini/mini.notify" },
})
require("mini.icons").setup()
require("trouble").setup()

require("toggleterm").setup({
	open_mapping = [[<c-\>]],
	direction = "float",
	float_opts = {
		border = "rounded",
	},
})

require("blink.cmp").setup({
	-- To install rust fuzzy finder:
	-- cd $HOME/.local/share/nvim/site/pack/core/opt/blink.cmp
	-- cargo build --release
	fuzzy = { implementation = "rust" },
})

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

require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.statusline").setup()

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

require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "-" },
		changedelete = { text = "~" },
	},
})

require("mason").setup()
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format" },
	},
})

require("catppuccin").setup({
	transparent_background = true,
	float = { transparent = true },
})

require("cord").setup({
	text = {
		editing = "Editing file",
		workspace = "",
	},
})

require("mini.notify").setup()

require("mini.extra").setup()
