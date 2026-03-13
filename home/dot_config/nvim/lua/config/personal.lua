vim.pack.add({
	{ src = "https://github.com/vyfor/cord.nvim" },
})

require("cord").setup({
	variables = { filename = "a file", workspace = "workspace" },
	text = { editing = "Editing a ${filetype} file", workspace = "" },
	display = { theme = "catppuccin" },
})

vim.lsp.config("ty", {})
vim.lsp.enable("ty")
