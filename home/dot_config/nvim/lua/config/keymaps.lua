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

-- Clear highlights on search when pressing <ESC> in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Search and pickers. (Mini Pick)
-- map("n", "<leader>f", "<cmd>Pick files<CR>", { desc = "TODO pick files" })
-- map("n", "<leader>g", "<cmd>Pick grep_live<CR>")
-- map("n", "<leader>b", "<cmd>Pick buffers<CR>")
-- map("n", "<leader>h", "<cmd>Pick help<CR>")
-- map("n", "<leader>ss", "<cmd>Pick buf_lines scope=current<CR>", { desc = "Fuzzy find in current buffer" })
-- map("n", "<leader>sk", "<cmd>Pick keymaps<CR>")

-- map("n", "<leader>sd", function()
-- 	MiniExtra.pickers.diagnostic({ scope = "current" })
-- end, { desc = "Search diagnostics" })

map("n", "<leader>sf", function()
	Snacks.picker.smart()
end, { desc = "Smart Find Files" })

map({ "n", "x" }, "<leader>sw", function()
	Snacks.picker.grep_word()
end, { desc = "[S]earch current [W]ord" })

map("n", "<leader>sg", function()
	Snacks.picker.grep()
end, { desc = "[S]earch [G]rep" })

map("n", "<leader>sd", function()
	Snacks.picker.diagnostics()
end, { desc = "[S]earch [D]iagnostics" })

map("n", "<leader>sr", function()
	Snacks.picker.resume()
end, { desc = "[S]earch [R]esume" })

map("n", "<leader>s.", function()
	Snacks.picker.recent()
end, { desc = 'Search Recent Files ("." for recent)' })

map("n", "<leader>sc", function()
	Snacks.picker.command_history()
end, { desc = "[S]earch [C]ommands" })

map("n", "<leader><leader>", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })

map("n", "<leader>/", function()
	Snacks.picker.lines()
end, { desc = "[/] Fuzzily search in current buffer" })

map("n", "<leader>sk", function()
	Snacks.picker.keymaps()
end, { desc = "Keymaps" })

map("n", "<leader>sh", function()
	Snacks.picker.help()
end, { desc = "Help Pages" })

-- TODO: live grep

-- Explorer
map("n", "<leader>e", function()
	require("oil").open_float()
end)

-- LSP and diagnostics.
-- map("n", "<leader>q", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Open diagnostics (Trouble)" })
-- map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", { desc = "Open diagnostic [Q]uickfix list (Trouble)" })

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

map("n", "<leader>sa", function()
	require("actions-preview").code_actions()
end, { desc = "Code actions preview" })

map("n", "<leader>lf", language_format, { desc = "Format buffer" })

-- Plugin maintenance.
map("n", "<leader>pc", pack_clean, { desc = "Remove unused plugins" })

-- Keep search and paging context centered.
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- TEMP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
