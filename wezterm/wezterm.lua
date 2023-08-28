local wezterm = require('wezterm')
local act = wezterm.action

-- Allow working with both the current release and the nightly
local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.front_end = "WebGpu"

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

config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false

config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = true

config.inactive_pane_hsb = {
    saturation = 0.8,
    brightness = 0.8,
}



wezterm.on('update-status', function(window, pane)
    -- Figure out the cwd and host of the current pane.
    -- This will pick up the hostname for the remote host if your
    -- shell is using OSC 7 on the remote host.
    local cwd_uri = pane:get_current_working_dir()
    local right_status = {}
    local left_status = {}
    if cwd_uri then
        local cwd = ''
        local hostname = ''
        if type(cwd_uri) == 'userdata' then
            -- Running on a newer version of wezterm and we have
            -- a URL object here, making this simple!
            cwd = cwd_uri.file_path
            hostname = cwd_uri.host or wezterm.hostname()
        else
            -- an older version of wezterm, 20230712-072601-f4abf8fd or earlier,
            -- which doesn't have the Url object
            cwd_uri = cwd_uri:sub(8)
            local slash = cwd_uri:find '/'
            if slash then
                hostname = cwd_uri:sub(1, slash - 1)
                -- and extract the cwd from the uri, decoding %-encoding
                cwd = cwd_uri:sub(slash):gsub('%%(%x%x)', function(hex)
                    return string.char(tonumber(hex, 16))
                end)
            end
        end

        -- Remove the domain name portion of the hostname
        local dot = hostname:find '[.]'
        if dot then
            hostname = hostname:sub(1, dot - 1)
        end
        if hostname == '' then
            hostname = wezterm.hostname()
        end
        left_status = {
            { Foreground = { Color = 'rgb(210,55,100)' } },
            { Background = { Color = 'none' } },
            { Attribute = { Italic = true } },
            { Text = '  Workspace:  ' },

            { Attribute = { Italic = false } },
            { Text = window:active_workspace() .. '        ' },

        }
        right_status = {
            { Background = { Color = 'none' } },

            { Foreground = { Color = 'rgb(94,172,211)' } },
            { Attribute = { Italic = true } },
            { Text = 'in  ' },

            { Foreground = { Color = 'rgb(210,55,100)' } },
            { Attribute = { Italic = false } },
            { Text = cwd },

            { Foreground = { Color = 'rgb(94,172,211)' } },
            { Attribute = { Italic = true } },
            { Text = '  @  ' },

            { Foreground = { Color = 'rgb(210,55,100)' } },
            { Attribute = { Italic = false } },
            { Text = hostname .. '  ' },
        }
    end
    --
    window:set_left_status(wezterm.format(left_status))
    window:set_right_status(wezterm.format(right_status))
end)

-- retro tab bar
config.colors = {
    tab_bar = {
        background = 'none',   -- 'rgba(0,0,0,0)',
        active_tab = {
            bg_color = 'none', -- 'rgba(0,0,0,0)',
            fg_color = 'rgb(75,185,55)',
        },
        inactive_tab = {
            bg_color = 'none',           -- 'rgba(0,0,0,0)',
            fg_color = 'rgb(94,172,211)' -- = '#5eacd3'
        },
        new_tab = {
            bg_color = 'none',
            fg_color = 'rgb(210,55,100)'
        },
    }
}

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

config.term = "wezterm"


-- keybindings:

wezterm.on('toggle-bg', function(window, _)
    local overrides = window:get_config_overrides() or {}
    if not overrides.background then
        overrides.background = {}
        overrides.colors = { background = '#1a212e' }
        overrides.text_background_opacity = 1.0
    else
        overrides.background = nil
        overrides.colors = nil
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

for i = 1, 8 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'LEADER',
        action = act.ActivateTab(i - 1),
    })
end

wezterm.on('user-var-changed', function(window, pane, name, value)
    local overrides = window:get_config_overrides() or {}
    if name == "ZEN_MODE" then
        local incremental = value:find("+")
        local number_value = tonumber(value)
        if incremental ~= nil then
            while (number_value > 0) do
                window:perform_action(wezterm.action.IncreaseFontSize, pane)
                number_value = number_value - 1
            end
            overrides.enable_tab_bar = false
            overrides.background = {}
            overrides.colors = { background = '#1a212e' }
            overrides.text_background_opacity = 1.0
        elseif number_value < 0 then
            window:perform_action(wezterm.action.ResetFontSize, pane)
            overrides.font_size = nil
            overrides.background = nil
            overrides.colors = nil
            overrides.text_background_opacity = nil
            overrides.enable_tab_bar = true
        else
            overrides.font_size = number_value
            overrides.background = {}
            overrides.colors = { background = '#1a212e' }
            overrides.text_background_opacity = 1.0
            overrides.enable_tab_bar = false
        end
    end
    window:set_config_overrides(overrides)
end)


-- config.debug_key_events = true
-- config.enable_kitty_keyboard = true

return config
