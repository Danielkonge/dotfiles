local wezterm    = require('wezterm')
local act        = wezterm.action

local workspaces = require('workspaces')

local keys       = {}

-- Helper function to detect SSH
local function is_ssh(pane)
    local process = pane:get_foreground_process_name()
    return process and (process:find("ssh") or process:find("SSH"))
end

function keys.apply_to_config(config)
    config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 3000 }

    config.keys = {
        -- Fix keys for ssh, which doesn't work with config.enable_kitty_keyboard = true
        {
            key = "UpArrow",
            action = wezterm.action_callback(function(window, pane)
                if is_ssh(pane) then
                    window:perform_action(act.SendString '\x1b[A', pane)
                else
                    window:perform_action(act.SendKey { key = 'UpArrow' }, pane)
                end
            end),
        },
        {
            key = 'DownArrow',
            action = wezterm.action_callback(function(window, pane)
                if is_ssh(pane) then
                    window:perform_action(act.SendString '\x1b[B', pane)
                else
                    window:perform_action(act.SendKey { key = 'DownArrow' }, pane)
                end
            end),
        },
        {
            key = 'LeftArrow',
            action = wezterm.action_callback(function(window, pane)
                if is_ssh(pane) then
                    window:perform_action(act.SendString '\x1b[D', pane)
                else
                    window:perform_action(act.SendKey { key = 'LeftArrow' }, pane)
                end
            end),
        },
        {
            key = 'RightArrow',
            action = wezterm.action_callback(function(window, pane)
                if is_ssh(pane) then
                    window:perform_action(act.SendString '\x1b[C', pane)
                else
                    window:perform_action(act.SendKey { key = 'RightArrow' }, pane)
                end
            end),
        },

        -- Turn off the default CTRL-SHIFT-Space action (so it can potentially be used in tmux)
        -- {
        --     key = 'Space',
        --     mods = 'CTRL|SHIFT',
        --     action = act.DisableDefaultAssignment,
        -- },
        {
            key = 'Tab',
            mods = 'ALT',
            action = act.ActivatePaneDirection 'Next',
        },
        {
            key = 'Tab',
            mods = 'ALT|SHIFT',
            action = act.ActivatePaneDirection 'Prev',
        },
        {
            key = 'w',
            mods = 'ALT',
            action = act.CloseCurrentPane { confirm = true },
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
            key = 'o',
            mods = 'LEADER',
            action = act.EmitEvent 'toggle-text-bg-opacity',
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
            key = 'h',
            mods = 'ALT',
            action = act.ActivatePaneDirection 'Left',
        },
        {
            key = 'l',
            mods = 'ALT',
            action = act.ActivatePaneDirection 'Right',
        },
        {
            key = 'k',
            mods = 'ALT',
            action = act.ActivatePaneDirection 'Up',
        },
        {
            key = 'j',
            mods = 'ALT',
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
            key = 'F',
            mods = 'LEADER',
            action = wezterm.action_callback(workspaces.quick_picker),
        },
        {
            key = 'f',
            mods = 'LEADER',
            action = wezterm.action_callback(workspaces.fuzzy_picker),
        },
        {
            key = 'd',
            mods = 'LEADER',
            action = act.ShowDebugOverlay,
        },
        -- Shell Integration commands:
        {
            key = 'UpArrow',
            mods = 'SHIFT',
            action = act.ScrollToPrompt(-1),
        },
        {
            key = 'DownArrow',
            mods = 'SHIFT',
            action = act.ScrollToPrompt(1),
        },
    }

    for i = 1, 9 do
        table.insert(config.keys, {
            key = tostring(i),
            mods = 'LEADER',
            action = act.ActivateTab(i - 1),
        })
    end

    config.mouse_bindings = {
        {
            event = { Down = { streak = 2, button = 'Left' } },
            action = act.SelectTextAtMouseCursor 'SemanticZone',
            mods = 'SHIFT',
        },
    }
end

return keys
