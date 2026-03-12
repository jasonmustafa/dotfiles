local servers = {
	lua_ls = {
		-- For Neovim config files
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
				runtime = { version = "LuaJIT", path = { "lua/?.lua", "lua/?/init.lua" } },
				workspace = {
					checkThirdParty = false,
					library = vim.tbl_extend(
						"force",
						vim.api.nvim_get_runtime_file("", true),
						{ "${3rd}/luv/library" }
					),
				},
			})
		end,
		settings = { Lua = {} },
	},
}

if vim.env.WORK then
	servers.pyright = {}
else
	servers.ty = {}
end

for name, server in pairs(servers) do
	vim.lsp.config(name, server)
	vim.lsp.enable(name)
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- Find references for the word under your cursor
		map("grr", function() Snacks.picker.lsp_references() end, "[G]oto [R]eferences")

		-- Jump to the implementation of the word under your cursor
		map("gri", function() Snacks.picker.lsp_implementations() end, "[G]oto [I]mplementation")

		-- Fuzzy find all the symbols in your current document
		map("gO", function() Snacks.picker.lsp_symbols() end, "Open LSP document symbols")

		-- Fuzzy find all the symbols in your current workspace
		map("gW", function() Snacks.picker.lsp_workspace_symbols() end, "Open LSP Workspace Symbols")

		-- Jump to the type of word under your cursor
		map("grt", function() Snacks.picker.lsp_type_definitions() end, "[G]oto [T]ype Definitions")

		-- Rename the variable under your cursor
		map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

		-- Execute a code action
		map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

		-- Go to Declaration
		map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		-- Toggle inlay hints if the language server supports them
		if client and client:supports_method("textDocument/inlayHint", event.buf) then
			map(
				"<leader>th",
				function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })) end,
				"[T]oggle Inlay [H]ints"
			)
		end
	end,
})
