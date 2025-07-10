-- Pull in the Wezterm API
local wezterm = require("wezterm")
local os = require("os")

-- This will hold the Configuration
local config = wezterm.config_builder()

config.default_cursor_style = "SteadyBlock"
config.anti_alias_custom_block_glyphs = true
config.font = wezterm.font("Hurmit Nerd Font Mono", { weight = "Medium" })
config.cell_width = 0.9
config.font_size = 15

config.window_background_opacity = 0.95

config.color_scheme = "Catppuccin Macchiato"

config.window_padding = {
	top = 0,
	right = 0,
	left = 10,
}

-- Hide the tab bar if only one tab is open
config.hide_tab_bar_if_only_one_tab = true
config.max_fps = 240 -- hack for smoothness
config.enable_kitty_graphics = true

-- Smooth hack
config.max_fps = 240

-- Enable Kitty Graphics
config.enable_kitty_graphics = true

config.keys = {

	{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	-- Make Option-Right equivalent to Alt-f; forward-word
	{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
}

return config
