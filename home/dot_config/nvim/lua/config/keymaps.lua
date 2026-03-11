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

local function copy_path(modifier)
	local path = vim.fn.expand("%" .. modifier)
	vim.fn.setreg("+", path)
	vim.notify(("Copied: %s"):format(path), vim.log.levels.INFO)
end

local function yank_lines_with_path()
	local l1 = vim.fn.line("v")
	local l2 = vim.fn.line(".")
	local start = math.min(l1, l2)
	local finish = math.max(l1, l2)
	local lines = vim.api.nvim_buf_get_lines(0, start - 1, finish, false)
	local relpath = vim.fn.expand("%:.")
	local header = ("%s:%d-%d"):format(relpath, start, finish)
	local text = header .. "\n" .. table.concat(lines, "\n") .. "\n"
	vim.fn.setreg("+", text)
	vim.notify(("Copied %d lines with path"):format(#lines), vim.log.levels.INFO)
end

local function chezmoi_nvim_dir()
	local source = vim.trim(vim.fn.system("chezmoi source-path"))
	local path = source .. "/home/dot_config/nvim"

	if vim.v.shell_error == 0 and source ~= "" and vim.fn.isdirectory(path) == 1 then
		return path
	end

	path = vim.fn.expand("~/.local/share/chezmoi/home/dot_config/nvim")
	if vim.fn.isdirectory(path) == 1 then
		return path
	end

	return vim.fn.stdpath("config")
end

-- File and session.
map("n", "<leader>w", "<cmd>write<CR>")
map({ "n", "v", "x" }, "<leader>o", "<cmd>update<CR> :source<CR>")
map({ "n", "v", "x" }, "<leader>O", "<cmd>restart<CR>", { desc = "Restart vim" })

-- Clipboard and editing.
map({ "n", "v", "x" }, "<leader>y", '"+y<CR>')
map({ "n", "v", "x" }, "<leader>d", '"+d<CR>')

-- Copy files/lines
map({ "n", "v", "x" }, "<leader>cp", function() copy_path(":.") end, { desc = "Copy relative file path" })
map({ "n", "v", "x" }, "<leader>cP", function() copy_path(":p") end, { desc = "Copy absolute file path" })
map("v", "<leader>cy", yank_lines_with_path, { desc = "Yank lines with file path" })

map({ "n", "v", "x" }, "<C-s>", [[:s/\V]], { desc = "Enter substitute mode in selection" })

-- Clear highlights on search when pressing <ESC> in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

map("n", "<leader>sf", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
map({ "n", "v" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "[S]earch current [W]ord" })
map("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "[S]earch [G]rep" })
map("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "[S]earch [D]iagnostics" })
map("n", "<leader>sr", function() Snacks.picker.resume() end, { desc = "[S]earch [R]esume" })
map("n", "<leader>s.", function() Snacks.picker.recent() end, { desc = 'Search Recent Files ("." for recent)' })
map("n", "<leader>sc", function() Snacks.picker.command_history() end, { desc = "[S]earch [C]ommands" })
map("n", "<leader><leader>", function() Snacks.picker.buffers() end, { desc = "[ ] Find existing buffers" })
map("n", "<leader>/", function() Snacks.picker.lines() end, { desc = "[/] Fuzzily search lines in current buffer" })
map("n", "<leader>s/", function() Snacks.picker.grep_buffers() end, { desc = "[S]earch (grep) [/] in Open Files" })
map("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "[S]earch [K]eymaps" })
map("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "[Search] [Help]" })

map(
	"n",
	"<leader>sn",
	function() Snacks.picker.files({ cwd = chezmoi_nvim_dir() }) end,
	{ desc = "[S]earch [N]eovim files" }
)

-- Explorer
map("n", "<leader>e", "<cmd>lua MiniFiles.open()<CR>")
map("n", "\\", function() Snacks.explorer() end, { desc = "File explorer" })

-- LSP and diagnostics
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

map("n", "<leader>sa", function() require("actions-preview").code_actions() end, { desc = "Code actions preview" })
map("n", "<leader>f", language_format, { desc = "Format buffer" })

-- Keep search and paging context centered
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Use CTRL+<hjkl> to switch between windows
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Plugin maintenance
map("n", "<leader>pc", pack_clean, { desc = "Remove unused plugins" })

-- TEMP: Disable arrow keys in normal mode
map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
