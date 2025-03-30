--[[
-- WezTerm Config
-- Author: Jason Mustafa (https://www.jasonmustafa.com/)
--]]

local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMonoNL Nerd Font")
config.font_size = 15
config.color_scheme = "Catppuccin Mocha"

config.enable_tab_bar = false
config.window_background_opacity = 0.5
config.tiling_desktop_environments = { "Wayland" }

return config
