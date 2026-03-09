vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = "a" -- Mouse support in all previous modes

vim.o.showmode = false -- Mode is already in status line

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.wrap = false
vim.o.breakindent = true -- wrapped lines continue visually indented

vim.o.undofile = true
vim.o.swapfile = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = "yes"

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.o.inccommand = "split" -- Preview live substitutions

vim.o.cursorline = true

vim.o.scrolloff = 10 -- Minimal number of screen lines to keep above and below cursor

vim.o.confirm = true -- Dialog when performing operation that would fail due to unsaved changes in buffer

vim.o.termguicolors = true
vim.o.winborder = "rounded"

vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.WARN },
	virtual_text = true, -- Text shows up at the end of the line
	jump = { float = true },
})
