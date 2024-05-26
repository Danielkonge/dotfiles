local wezterm = require('wezterm')

local user_vars = {}

function user_vars.on_user_var_change(window, pane, name, value)
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
    elseif name == 'OPACITY_MODE' then
        local number_value = tonumber(value)
        if number_value == 1 then
            -- If we haven't overridden it yet, then override the text bg opacity
            overrides.text_background_opacity = 0.8
        else
            -- else we did already, and we should disable out override now
            overrides.text_background_opacity = nil
        end
    end
    window:set_config_overrides(overrides)
end


return user_vars
