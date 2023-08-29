local wezterm = require('wezterm')
-- local act = wezterm.action

-- Allow working with both the current release and the nightly
local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.front_end = "WebGpu"
config.term = "wezterm"

-- This might not be a good idea?
-- config.default_prog = { '/opt/homebrew/bin/zsh', '-l' }

config.max_fps = 120
config.animation_fps = 60

config.enable_kitty_keyboard = true

-- config.color_scheme = 'Catppuccin Mocha'
config.color_scheme = 'carbonfox'

config.window_decorations = "RESIZE"

config.font = wezterm.font({
    family = 'JetBrains Mono',
    weight = 'Medium',
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
})
-- ->
config.adjust_window_size_when_changing_font_size = false
config.font_size = 13.0
config.line_height = 1.2

config.inactive_pane_hsb = {
    saturation = 0.8,
    brightness = 0.8,
}

config.background = {
    -- deepest layer
    {
        source = {
            File = '/Users/daniel/.config/wezterm/sword-red.png'
        },
        hsb = { brightness = 0.03, saturation = 1.02 },
        opacity = 0.95,
    },
    -- more layers can be added here
}

config.macos_window_background_blur = 10

-- background of special text (e.g. which-key in nvim)
config.text_background_opacity = 0.4

-- config.window_padding = {
--     left = 0,
--     right = 0,
--     top = 0,
--     bottom = 0,
-- }
-- config.colors = {
--     -- useful for One Dark theme
--     cursor_fg = "yellow",
-- }

local tab_bar = require('tab-bar')

wezterm.on('update-status', tab_bar.on_update_status)

wezterm.on('format-tab-title', tab_bar.on_format_tab_title)

tab_bar.apply_to_config(config)

local toggles = require('toggles')

wezterm.on('toggle-bg', toggles.on_toggle_bg)

wezterm.on('toggle-ligature', toggles.on_toggle_ligature)

local zen_mode = require('zen-mode')

wezterm.on('user-var-changed', zen_mode.on_user_var_change)

require('workspaces').apply_to_config(config)

require('key-bindings').apply_to_config(config)


-- config.debug_key_events = true


return config
