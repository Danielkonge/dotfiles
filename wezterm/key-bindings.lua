local wezterm = require('wezterm')
local act = wezterm.action

local workspaces = require('workspaces')

local keys = {}


function keys.apply_to_config(config)
    config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 3000 }

    config.keys = {
        -- Turn off the default CTRL-SHIFT-Space action (so it can potentially be used in tmux)
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
        {
            key = 'p',
            mods = 'LEADER',
            action = act.ActivateCommandPalette,
        },
        {
            key = 'q',
            mods = 'LEADER',
            action = act.CloseCurrentPane { confirm = false },
        },
        {
            key = 'z',
            mods = 'LEADER',
            action = act.TogglePaneZoomState,
        },
        {
            key = '?',
            mods = 'LEADER',
            action = act.ShowLauncherArgs { title = 'Choose Command', flags = 'FUZZY|COMMANDS' }
            -- seems to be the same as below
            -- action = act.ShowLauncherArgs { title = 'Keys', flags = 'FUZZY|KEY_ASSIGNMENTS|COMMANDS' }
        },
        {
            key = 't',
            mods = 'LEADER',
            action = act.ShowLauncherArgs { title = 'Switch Tab', flags = 'FUZZY|TABS' }
        },
        {
            key = 'w',
            mods = 'LEADER',
            action = act.ShowLauncherArgs { title = 'Switch Workspace', flags = 'FUZZY|WORKSPACES' }
        },
        {
            key = '.',
            mods = 'LEADER',
            action = act.PaneSelect {
                alphabet = '1234567890',
            },
        },
        {
            key = ',',
            mods = 'LEADER',
            action = act.PaneSelect {
                alphabet = '1234567890',
                mode = 'SwapWithActive',
            },
        },
        {
            key = 'r',
            mods = 'LEADER',
            action = act.RotatePanes 'CounterClockwise',
        },
        {
            key = 'LeftArrow',
            mods = 'LEADER',
            action = act.ActivatePaneDirection 'Left',
        },
        {
            key = 'RightArrow',
            mods = 'LEADER',
            action = act.ActivatePaneDirection 'Right',
        },
        {
            key = 'UpArrow',
            mods = 'LEADER',
            action = act.ActivatePaneDirection 'Up',
        },
        {
            key = 'DownArrow',
            mods = 'LEADER',
            action = act.ActivatePaneDirection 'Down',
        },
        {
            key = 'LeftArrow',
            mods = 'ALT',
            action = act.AdjustPaneSize { 'Left', 1 },
        },
        {
            key = 'RightArrow',
            mods = 'ALT',
            action = act.AdjustPaneSize { 'Right', 1 },
        },
        {
            key = 'UpArrow',
            mods = 'ALT',
            action = act.AdjustPaneSize { 'Up', 1 },
        },
        {
            key = 'DownArrow',
            mods = 'ALT',
            action = act.AdjustPaneSize { 'Down', 1 },
        },
        {
            key = 'UpArrow',
            mods = 'ALT|CMD',
            action = act.SwitchWorkspaceRelative(1),
        },
        {
            key = 'DownArrow',
            mods = 'ALT|CMD',
            action = act.SwitchWorkspaceRelative(-1),
        },
        {
            key = 'f',
            mods = 'LEADER',
            action = wezterm.action_callback(workspaces.fuzzy_picker),
        },
    }

    for i = 1, 9 do
        table.insert(config.keys, {
            key = tostring(i),
            mods = 'LEADER',
            action = act.ActivateTab(i - 1),
        })
    end
end

return keys