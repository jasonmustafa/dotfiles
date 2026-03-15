local mode_map = {
	["NORMAL"] = " N",
	["O-PENDING"] = "󰇘 N?",
	["INSERT"] = " I",
	["VISUAL"] = " V",
	["V-BLOCK"] = " VB",
	["V-LINE"] = " VL",
	["V-REPLACE"] = " VR",
	["REPLACE"] = "󰬸 R",
	["COMMAND"] = " !",
	["SHELL"] = " SH",
	["TERMINAL"] = " T",
	["EX"] = "󰆍 X",
	["S-BLOCK"] = "󰓡 SB",
	["S-LINE"] = "󰓡 SL",
	["SELECT"] = "󰓡 S",
	["CONFIRM"] = " Y",
	["MORE"] = "󰇙 M",
}

local rose_pine = {
	love = "#eb6f92",
	gold = "#f6c177",
	rose = "#ebbcba",
	pine = "#31748f",
	foam = "#9ccfd8",
	iris = "#c4a7e7",
	text = "#e0def4",
	subtle = "#908caa",
	muted = "#6e6a86",
	overlay = "#26233a",
	base = "#191724",
	hl_high = "#524f67",
}

local C = rose_pine
local custom_theme = {
	normal = {
		a = { bg = C.iris, fg = C.base, gui = "bold" },
		b = { bg = C.overlay, fg = C.iris },
		c = { bg = "NONE", fg = C.text },
		y = { bg = C.love, fg = C.base, gui = "bold" },
		z = { bg = C.rose, fg = C.base, gui = "bold" },
	},
	insert = {
		a = { bg = C.foam, fg = C.base, gui = "bold" },
		b = { bg = C.overlay, fg = C.foam },
		y = { bg = C.love, fg = C.base, gui = "bold" },
		z = { bg = C.rose, fg = C.base, gui = "bold" },
	},
	terminal = {
		a = { bg = C.gold, fg = C.base, gui = "bold" },
		b = { bg = C.overlay, fg = C.gold },
		y = { bg = C.love, fg = C.base, gui = "bold" },
		z = { bg = C.rose, fg = C.base, gui = "bold" },
	},
	command = {
		a = { bg = C.love, fg = C.base, gui = "bold" },
		b = { bg = C.overlay, fg = C.love },
		y = { bg = C.love, fg = C.base, gui = "bold" },
		z = { bg = C.rose, fg = C.base, gui = "bold" },
	},
	visual = {
		a = { bg = C.rose, fg = C.base, gui = "bold" },
		b = { bg = C.overlay, fg = C.rose },
		y = { bg = C.love, fg = C.base, gui = "bold" },
		z = { bg = C.rose, fg = C.base, gui = "bold" },
	},
	replace = {
		a = { bg = C.pine, fg = C.text, gui = "bold" },
		b = { bg = C.overlay, fg = C.pine },
		y = { bg = C.love, fg = C.base, gui = "bold" },
		z = { bg = C.rose, fg = C.base, gui = "bold" },
	},
	inactive = {
		a = { bg = "NONE", fg = C.iris },
		b = { bg = "NONE", fg = C.hl_high, gui = "bold" },
		c = { bg = "NONE", fg = C.muted },
	},
}

require("lualine").setup({
	options = {
		theme = custom_theme,
		globalstatus = true,
		component_separators = "",
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function(s) return mode_map[s] or s end,
				separator = { left = "", right = "" },
				right_padding = 2,
			},
		},
		lualine_b = { "branch" },
		lualine_c = {
			{ "diff", diff_color = { added = { fg = C.foam }, modified = { fg = C.rose } } },
			{ "diagnostics", diagnostics_color = { warn = { fg = C.gold } } },
		},
		lualine_x = { "lsp_status", "progress", { "filetype", icon_only = true, icon = { align = "right" } } },
		lualine_y = { "location" },
		lualine_z = { { "filename", separator = { left = "", right = "" }, left_padding = 2 } },
	},
})
