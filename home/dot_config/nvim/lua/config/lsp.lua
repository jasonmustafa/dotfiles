local servers = {
	ty = {},
	lua_ls = {
		on_init = function(client)
			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if
					path ~= vim.fn.stdpath("config")
					and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
				then
					return
				end
			end

			client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
				runtime = {
					version = "LuaJIT",
					path = { "lua/?.lua", "lua/?/init.lua" },
				},
				workspace = {
					checkThirdParty = false,
					-- NOTE: this is a lot slower and will cause issues when working on your own configuration.
					--  See https://github.com/neovim/nvim-lspconfig/issues/3189
					library = vim.tbl_extend("force", vim.api.nvim_get_runtime_file("", true), {
						"${3rd}/luv/library",
						"${3rd}/busted/library",
					}),
				},
			})
		end,
		settings = {
			Lua = {},
		},
	},
}

-- vim.lsp.enable({ "lua_ls", "ty" })

for name, server in pairs(servers) do
	vim.lsp.config(name, server)
	vim.lsp.enable(name)
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		-- Find references for the word under your cursor
		vim.keymap.set("n", "grr", function() Snacks.picker.lsp_references() end, { desc = "[G]oto [R]eferences" })

		-- Jump to the implementation of the word under your cursor
		-- Useful when your language has ways of declaring types without an actual implementation
		vim.keymap.set(
			"n",
			"gri",
			function() Snacks.picker.lsp_implementations() end,
			{ desc = "[G]oto [I]mplementation" }
		)

		-- Fuzzy find all the symbols in your current workspace
		-- Symbols are things like variables, functions, types, etc.
		vim.keymap.set("n", "gO", function() Snacks.picker.lsp_symbols() end, { desc = "Open LSP document symbols" })

		-- Fuzzy find all the symbols in your current workspace
		-- Similar to document symbols, except searches over your entire project
		vim.keymap.set(
			"n",
			"gW",
			function() Snacks.picker.lsp_workspace_symbols() end,
			{ desc = "Open LSP Workspace Symbols" }
		)

		-- Jump to the type of word under your cursor
		-- Useful when you're not sure what type a variable is and you want to see
		-- the definition of its *type*, not where it was *defined*
		vim.keymap.set(
			"n",
			"grt",
			function() Snacks.picker.lsp_type_definitions() end,
			{ desc = "[G]oto [T]ype Definitions" }
		)
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- Rename the variable under your cursor
		map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

		-- Execute a code action, usually your cursor needs to be on top of an error
		-- or a suggestion from your LSP for this to activate
		map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

		-- WARN: This is not Goto Definition, this is Goto Declaration
		-- For example, in C this takes you to the header
		map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		-- Toggle inlay hints in your code, if the language server you are using supports them
		if client and client:supports_method("textDocument/inlayHint", event.buf) then
			map(
				"<leader>th",
				function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })) end,
				"[T]oggle Inlay [H]ints"
			)
		end
	end,
})

-- TODO: fix maybe
-- vim.lsp.config("lua_ls", { settings = { Lua = { workspace = { library = vim.api.nvim_get_runtime_file("", true) } } } })
