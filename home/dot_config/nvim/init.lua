vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.plugins")
require("config.lsp")
require("config.keymaps")

-- Autocommands

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('highlight-yank', {clear = true}),
	callback = function() vim.hl.on_yank() end,
})

vim.cmd.colorscheme("catppuccin-mocha")
