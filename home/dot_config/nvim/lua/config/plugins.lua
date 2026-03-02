vim.pack.add({
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
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
	{ src = "https://github.com/nvim-mini/mini.pairs" },
	{ src = "https://github.com/nvim-mini/mini.surround" },
	{ src = "https://github.com/NMAC427/guess-indent.nvim" },
	{ src = "https://github.com/nvim-mini/mini.ai" },

	-- LSP & completion
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" }, -- for blink snippets
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
	integrations = {
		snacks = {
			enabled = true,
		},
	},
})
require("mini.icons").setup()
require("mini.notify").setup()

-- local statusline = require("mini.statusline")
-- statusline.setup()
-- statusline.section_location = function() return "%2l:%-2v" end

-- sections = {
--     lualine_a = {'mode'},
--     lualine_b = {'branch', 'diff', 'diagnostics'},
--     lualine_c = {'filename'},
--     lualine_x = {'encoding', 'fileformat', 'filetype'},
--     lualine_y = {'progress'},
--     lualine_z = {'location'}
--   },

require("lualine").setup({
	options = {
		component_separators = "",
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { { "mode", separator = { left = "" } } },
		lualine_b = { "branch" },
		lualine_c = { "progress", "location", { "filename", path = 1 }, "diff", "diagnostics" },
		lualine_x = { "lsp_status", "encoding", "fileformat", "filetype" },
		lualine_z = { { "location", separator = { right = "" } } },
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

-- Better Around/Inside textobjects
-- Examples:
-- - va)  - [V]isually select [A]round [)]paren
-- - yinq - [Y]ank [I]nside [Next] [Q]uote
-- - ci'  - [C]hange [I]nside [']quote
require("mini.ai").setup({ n_lines = 500 })

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
require("nvim-treesitter").setup({
	callback = function()
		local parsers = {
			"bash",
			"c",
			"diff",
			"dockerfile",
			"html",
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
		require("nvim-treesitter").install(parsers)
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

				-- optional: enable treesitter based folds
				--

				-- enables treesitter based indentation
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
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
})

require("cord").setup({
	text = {
		editing = "Editing file",
		workspace = "",
	},
})
