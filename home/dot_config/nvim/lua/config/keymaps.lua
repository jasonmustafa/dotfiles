local map = vim.keymap.set

-- Helpers used by keymaps below.
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

local function language_format()
	local formatted = require("conform").format()

	if formatted then
		local filename = vim.fn.expand("%:t")
		if filename == "" then
			filename = "[No Name]"
		end

		vim.notify(("Formatted %s"):format(filename), vim.log.levels.INFO)
	end
end

-- File and session.
map("n", "<leader>w", "<cmd>write<CR>")
map({ "n", "v", "x" }, "<leader>o", "<cmd>update<CR> :source<CR>")
map({ "n", "v", "x" }, "<leader>O", "<cmd>restart<CR>", { desc = "Restart vim" })

-- Clipboard and editing.
map({ "n", "v", "x" }, "<leader>y", '"+y<CR>')
map({ "n", "v", "x" }, "<leader>d", '"+d<CR>')
map({ "n", "v", "x" }, "<C-s>", [[:s/\V]], { desc = "Enter substitute mode in selection" })

-- Search and pickers.
map("n", "<leader>f", "<cmd>Pick files<CR>")
map("n", "<leader>g", "<cmd>Pick grep_live<CR>")
map("n", "<leader>b", "<cmd>Pick buffers<CR>")
map("n", "<leader>h", "<cmd>Pick help<CR>")
map("n", "<leader>ss", "<cmd>Pick buf_lines scope=current<CR>", { desc = "Fuzzy find in current buffer" })
map("n", "<leader>sk", "<cmd>Pick keymaps<CR>")
map("n", "<leader>sd", function()
	MiniExtra.pickers.diagnostic({ scope = "current" })
end, { desc = "Search diagnostics" })

-- Explorer.
map("n", "<leader>e", function()
	require("oil").open_float()
end)

-- LSP and diagnostics.
map("n", "<leader>sa", function()
	require("actions-preview").code_actions()
end, { desc = "Code actions preview" })
map("n", "<leader>lf", language_format, { desc = "Format buffer" })
map("n", "<leader>q", "<cmd>Trouble diagnostics toggle<CR>")

-- Plugin maintenance.
map("n", "<leader>pc", pack_clean, { desc = "Remove unused plugins" })

-- Keep search and paging context centered.
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
