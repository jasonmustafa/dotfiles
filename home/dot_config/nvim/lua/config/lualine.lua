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

local catppuccin_mocha = {
	rosewater = "#f5e0dc",
	blue = "#89b4fa",
	lavender = "#b4befe",
	green = "#a6e3a1",
	teal = "#94e2d5",
	mauve = "#cba6f7",
	peach = "#fab387",
	red = "#f38ba8",
	maroon = "#eba0ac",
	flamingo = "#f2cdcd",
	text = "#cdd6f4",
	base = "#1e1e2e",
	mantle = "#181825",
	surface0 = "#313244",
	surface1 = "#45475a",
	overlay0 = "#6c7086",
}

local C = catppuccin_mocha
local custom_theme = {
	normal = {
		a = { bg = C.lavender, fg = C.mantle, gui = "bold" },
		b = { bg = C.surface0, fg = C.lavender },
		c = { bg = "NONE", fg = C.text },
		y = { bg = C.maroon, fg = C.mantle, gui = "bold" },
		z = { bg = C.flamingo, fg = C.mantle, gui = "bold" },
	},
	insert = {
		a = { bg = C.teal, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.teal },
		y = { bg = C.maroon, fg = C.mantle, gui = "bold" },
		z = { bg = C.flamingo, fg = C.mantle, gui = "bold" },
	},
	terminal = {
		a = { bg = C.green, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.green },
		y = { bg = C.maroon, fg = C.mantle, gui = "bold" },
		z = { bg = C.flamingo, fg = C.mantle, gui = "bold" },
	},
	command = {
		a = { bg = C.peach, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.peach },
		y = { bg = C.maroon, fg = C.mantle, gui = "bold" },
		z = { bg = C.flamingo, fg = C.mantle, gui = "bold" },
	},
	visual = {
		a = { bg = C.flamingo, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.flamingo },
		y = { bg = C.maroon, fg = C.mantle, gui = "bold" },
		z = { bg = C.flamingo, fg = C.mantle, gui = "bold" },
	},
	replace = {
		a = { bg = C.maroon, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.maroon },
		y = { bg = C.maroon, fg = C.mantle, gui = "bold" },
		z = { bg = C.flamingo, fg = C.mantle, gui = "bold" },
	},
	inactive = {
		a = { bg = "NONE", fg = C.lavender },
		b = { bg = "NONE", fg = C.surface1, gui = "bold" },
		c = { bg = "NONE", fg = C.overlay0 },
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
			{ "diff", diff_color = { added = { fg = C.green }, modified = { fg = C.flamingo } } },
			{ "diagnostics", diagnostics_color = { warn = { fg = C.peach } } },
		},
		lualine_x = { "lsp_status", "progress", { "filetype", icon_only = true, icon = { align = "right" } } },
		lualine_y = { "location" },
		lualine_z = { { "filename", separator = { left = "", right = "" }, left_padding = 2 } },
	},
})
