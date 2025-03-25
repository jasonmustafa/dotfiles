--[[
-- WezTerm Config
-- Author: Jason Mustafa (https://www.jasonmustafa.com/)
--]]

local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback({
	{ family = "JetBrains Mono NL" },
	{ family = "MesloLGS NF" }, -- for Powerlevel10k icons
})
config.font_size = 15
config.color_scheme = "Catppuccin Mocha"

config.enable_tab_bar = false
config.window_background_opacity = 0.5
config.tiling_desktop_environments = { "Wayland" }

return config
