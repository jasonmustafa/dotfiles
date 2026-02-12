vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.wrap = false

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true

vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.incsearch = true
vim.o.winborder = "rounded"

vim.g.mapleader = " "

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>o', '<cmd>update<CR> :source<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, "<leader>O", "<cmd>restart<CR>", { desc = "Restart vim" })
vim.keymap.set({ "n", "v", "x" }, "<C-s>", [[:s/\V]], { desc = "Enter substitue mode in selection" })
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')


vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')

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
})

require 'mini.icons'.setup()

vim.keymap.set({ "n" }, "<leader>sa", require("actions-preview").code_actions)

require "trouble".setup()

require "toggleterm".setup {
	open_mapping = [[<c-\>]],
	direction = "float",
	float_opts = {
		border = "rounded",
	},
}

-- Remove unused plugins
local function pack_clean()
	local active_plugins = {}
	local unused_plugins = {}

	for _, plugin in ipairs(vim.pack.get()) do
		active_plugins[plugin.spec.name] = plugin.active
	end

	for _, plugin in ipairs(vim.pack.get()) do
		if not active_plugins[plugin.spec.name] then
			table.insert(unused_plugins, plugin.spec.name)
		end
	end

	if #unused_plugins == 0 then
		print("No unused plugins.")
		return
	end

	local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
	if choice == 1 then
		vim.pack.del(unused_plugins)
	end
end

require "blink.cmp".setup {
	-- To install rust fuzzy finder
	-- cd $HOME/.local/share/nvim/site/pack/core/opt/blink.cmp
	-- cargo build --release
	fuzzy = { implementation = "rust" }
}

require "mini.pick".setup {
	window = {
		config = function()
			local height = math.floor(0.618 * vim.o.lines)
			local width = math.floor(0.618 * vim.o.columns)
			return {
				anchor = "NW",
				height = height,
				width = width,
				row = math.floor(0.5 * (vim.o.lines - height)),
				col = math.floor(0.5 * (vim.o.columns - width)),
			}
		end,
	},
}

require "mini.pairs".setup()
require "mini.surround".setup()
require "mini.statusline".setup()

require "oil".setup {
	lsp_file_methods = { autosave_changes = true },
	columns = { "permissions", "icon" },
	view_options = { show_hidden = true },
	float = {
		max_width = 0.3,
		max_height = 0.6,
		border = "rounded",
		win_options = { winblend = 20 }
	},
}

require "gitsigns".setup {
	signs = {
		add = { text = '+' },
		change = { text = '~' },
		delete = { text = '_' },
		topdelete = { text = '-' },
		changedelete = { text = '~' },
	}
}

require "mason".setup()
require "catppuccin".setup {
	transparent_background = true,
	float = { transparent = true },
}

require "cord".setup {
	text = {
		editing = 'Editing file',
		workspace = '',
	}
}

require 'mini.extra'.setup()

vim.keymap.set('n', '<leader>f', "<cmd>Pick files<CR>")
vim.keymap.set('n', '<leader>g', "<cmd>Pick grep_live<CR>")
vim.keymap.set('n', '<leader>b', "<cmd>Pick buffers<CR>")

vim.keymap.set('n', '<leader>e', require("oil").open_float)
vim.keymap.set('n', '<leader>h', "<cmd>Pick help<CR>")
vim.keymap.set('n', '<leader>sk', '<cmd>Pick keymaps<CR>')

vim.keymap.set("n", "<leader>sd", function() MiniExtra.pickers.diagnostic({ scope = "current" }) end,
	{ desc = "Search diagnostics" })

vim.lsp.enable({ "lua_ls", "ty" })

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true)
			}
		}
	}
})

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>pc', pack_clean)
vim.keymap.set('n', '<leader>q', ":Trouble diagnostics toggle<CR>")

-- center screen after scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- center screen after jumping between search matches
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.cmd("colorscheme catppuccin-mocha")
