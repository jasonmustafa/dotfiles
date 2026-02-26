vim.lsp.enable({ "lua_ls", "ty" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local buf = event.buf

		-- Find references for the word under your cursor
		vim.keymap.set("n", "grr", function()
			Snacks.picker.lsp_references()
		end, { buffer = buf, desc = "[G]oto [R]eferences" })
	end,
})
-- vim.lsp.config("lua_ls", { settings = { Lua = { workspace = { library = vim.api.nvim_get_runtime_file("", true) } } } })
