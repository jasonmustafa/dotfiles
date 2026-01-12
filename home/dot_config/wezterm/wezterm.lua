local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMonoNL Nerd Font")
config.font_size = 15
config.color_scheme = "Catppuccin Mocha"
-- Retro tabs with terminal font
config.use_fancy_tab_bar = false
-- Set tab bar background to transparent
config.colors = {
	tab_bar = {
		background = "rgba(30, 30, 46, 0.5)",
		active_tab = {
			bg_color = "rgba(30, 30, 46, 0.5)",
			fg_color = "#cba6f7", -- mauve
		},
		inactive_tab = {
			bg_color = "rgba(30, 30, 46, 0.5)",
			fg_color = "#6c7086", -- overlay0
		},
		inactive_tab_hover = {
			bg_color = "rgba(30, 30, 46, 0.5)",
			fg_color = "#a6adc8", -- subtext0
		},
		new_tab = {
			bg_color = "rgba(30, 30, 46, 0.5)",
			fg_color = "#6c7086", -- overlay0
		},
		new_tab_hover = {
			bg_color = "rgba(30, 30, 46, 0.5)",
			fg_color = "#a6adc8", -- subtext0
		},
	},
}

config.window_background_opacity = 0.5
config.tiling_desktop_environments = { "Wayland" }

-- Status bar

-- Leader indicator, mode indicator, cwd, and workspace name
wezterm.on("update-status", function(window)
	local leader = ""
	if window:leader_is_active() then
		leader = wezterm.format({
			{ Foreground = { Color = "#f38ba8" } },
			{ Text = " \u{f14de} " }, -- rocket
		})
	end

	local mode_text = "\u{f120}"
	local mode_color = "#89b4fa" -- blue for normal
	local key_table = window:active_key_table()
	if key_table == "copy_mode" then
		mode_text = "\u{f4bb}"
		mode_color = "#fab387" -- peach
	elseif key_table == "search_mode" then
		mode_text = "\u{f002}"
		mode_color = "#a6e3a1" -- green
	end
	local mode = wezterm.format({
		{ Foreground = { Color = mode_color } },
		{ Text = mode_text },
	})

	local workspace = wezterm.format({
		{ Foreground = { Color = "#94e2d5" } },
		{ Text = "\u{f0328} " .. window:active_workspace() }, -- layer
	})
	window:set_left_status(leader .. " " .. mode .. "  " .. workspace .. " ")
end)

-- Custom tab title format: [1] or [1] name if explicitly named
wezterm.on("format-tab-title", function(tab)
	local index = tab.tab_index + 1
	local title = tab.tab_title
	if title and #title > 0 then
		return string.format(" %d %s ", index, title)
	end
	return string.format(" %d ", index)
end)

-- Multiplexing
config.unix_domains = { { name = "unix" } }

-- Keybinds
config.leader = { mods = "CTRL", key = "Space", timeout_milliseconds = 1000 }
config.keys = {
	-- splitting
	{ mods = "LEADER", key = "-", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = "=", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = "m", action = wezterm.action.TogglePaneZoomState },
	-- rotate panes
	{ mods = "LEADER", key = "Space", action = wezterm.action.RotatePanes("Clockwise") },
	-- show the pane selection mode, but have it swap the active and selected panes
	{ mods = "LEADER", key = "0", action = wezterm.action.PaneSelect({ mode = "SwapWithActive" }) },
	-- activate copy mode or vim mode
	{ key = "Enter", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
}

-- SSH Domains
-- TODO

return config
