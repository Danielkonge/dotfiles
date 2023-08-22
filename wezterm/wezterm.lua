local wezterm = require('wezterm')
local act = wezterm.action

local config = {}

config.front_end = "WebGpu"

config.color_scheme = 'Catppuccin Mocha'

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

config.hide_tab_bar_if_only_one_tab = true
-- config.tab_bar_at_bottom = true

config.background = {
    -- deepest layer
    {
        source = {
            File = '/Users/daniel/Dropbox/Background-Images/sword-red.png'
        },
        hsb = { brightness = 0.03 },
        opacity = 0.96,
    },
    -- more layers can be added here
}

-- background of special text (e.g. which-key in nvim)
config.text_background_opacity = 0.5

-- config.colors = {
--     -- useful for One Dark theme
--     cursor_fg = "yellow",
-- }

config.term = "wezterm"


-- keybindings:

wezterm.on('toggle-bg', function(window, _)
  local overrides = window:get_config_overrides() or {}
  if not overrides.background then
    overrides.background = {}
    overrides.text_background_opacity = 1.0
  else
    overrides.background = nil
    overrides.text_background_opacity = nil
  end
  window:set_config_overrides(overrides)
end)

wezterm.on('toggle-ligature', function(window, _)
  local overrides = window:get_config_overrides() or {}
    if not overrides.font then
        -- If we haven't overridden it yet, then override with ligatures enabled
        overrides.font = wezterm.font({
            family = 'JetBrains Mono',
            weight = 'Medium',
            harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
        })
    else
    -- else we did already, and we should disable out override now
    overrides.font = nil
  end
  window:set_config_overrides(overrides)
end)

config.leader = { key = 'Space', mods = 'CTRL|SHIFT', timeout_milliseconds = 3000 }
config.keys = {
    -- Turn off the default CTRL-SHIFT-Space action
    {
        key = 'Space',
        mods = 'CTRL|SHIFT',
        action = act.DisableDefaultAssignment,
    },
    {
        key = '%',
        mods = 'LEADER',
        action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = '"',
        mods = 'LEADER',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'b',
        mods = 'LEADER',
        action = act.EmitEvent 'toggle-bg',
    },
    {
        key = 'l',
        mods = 'LEADER',
        action = act.EmitEvent 'toggle-ligature',
    },
    {
        key = '+',
        mods = 'CMD',
        action = act.IncreaseFontSize,
    },
    {
        key = 'c',
        mods = 'LEADER',
        action = act.ActivateCopyMode,
    },
}

for i = 1,8 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'LEADER',
        action = act.ActivateTab(i-1),
    })
end

-- config.debug_key_events = true
-- config.enable_kitty_keyboard = true

return config

