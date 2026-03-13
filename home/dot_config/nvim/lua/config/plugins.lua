vim.pack.add({
	-- Theme & UI
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/echasnovski/mini.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/folke/todo-comments.nvim" },

	-- Editing & navigation
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
	{ src = "https://github.com/NMAC427/guess-indent.nvim" },
	{ src = "https://github.com/mfussenegger/nvim-lint" },

	-- LSP & completion
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/aznhe21/actions-preview.nvim" },

	-- Tooling & misc
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/xvzc/chezmoi.nvim" },
	{ src = "https://github.com/alker0/chezmoi.vim" },
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

require("config.lualine")

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

require("mini.files").setup({
	options = { permanent_delete = false, use_as_default_explorer = false },
	windows = { preview = true },
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
	picker = {
		sources = {
			explorer = { layout = { preset = "default" } },
		},
	},
	explorer = {},
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

		-- chezmoi.vim handles template syntax; treesitter can't parse them
		if filetype:find("chezmoitmpl") then
			return
		end

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

require("mini.diff").setup({ view = { style = "sign", signs = { add = "+", change = "~", delete = "_" } } })

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
		{ mode = { "n", "x" }, keys = "<Leader>g", desc = "+git" },
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

require("chezmoi").setup({})
