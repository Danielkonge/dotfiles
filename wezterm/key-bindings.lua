local wezterm    = require('wezterm')
local act        = wezterm.action

local workspaces = require('workspaces')

local keys       = {}


function keys.apply_to_config(config)
    config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 3000 }

    config.keys = {
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
            mods = 'ALT',
            action = act.ActivatePaneDirection 'Prev',
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
            key = 'f',
            mods = 'LEADER',
            action = wezterm.action_callback(workspaces.fuzzy_picker),
        },
        {
            key = 'd',
            mods = 'LEADER',
            action = act.ShowDebugOverlay,
        },
        {
            key = 'å',
            mods = 'LEADER',
            action = wezterm.action_callback(function(win, pane)
                local weztable = wezterm.table
                -- wezterm.log_info( table.merge( { { opt1 = "a", opt2 = "b" }, { opt3 = "c", opt4 = "d" }, { opt1 = "b" } } ) )
                --
                -- local tbl = { 1, 2, "a", { 1, 2, "b" }, "c" }
                -- wezterm.log_info( tbl )
                -- local new_tbl = table.clone(tbl)
                -- wezterm.log_info( new_tbl )
                --
                -- local tbl = table.flatten( {0, {1,2,3,4},{5,6,7},{8,9,10},{11, {12, {13, 14}}}} )
                -- wezterm.log_info(tbl)
                -- wezterm.log_info( table.to_string(tbl) )
                --
                -- local t = { a = 1, b = 2 }
                -- wezterm.log_info(#t)
                -- wezterm.log_info(table.length(t))
                -- wezterm.log_info(table.has_key(t, "a"))
                -- wezterm.log_info(table.has_value(t, 1))
                --
                -- wezterm.log_info( table.to_string(t) )
                --

                local tbl = { 1, 2, 3, { a = 1, b = 2, { 5 } } }

                -- wezterm.log_info( table.to_string( { {1,2,3}, { a = 1, b = 2, { 5 }} } ) )
                wezterm.log_info(weztable.to_string({ { 1, 2, 3 }, { a = 1, b = 2, { 5 } } }, 0))
                wezterm.log_info(weztable.to_string({ { 1, 2, 3 }, { a = 1, b = 2, { 5 } } }, 2))
                wezterm.log_info(weztable.to_string({ { 1, 2, 3 }, { a = 1, b = 2, { 5 } } }, 0, true))
                wezterm.log_info(weztable.to_string(tbl))

                -- string.startswith = function(str, start)
                --     return str:sub(1, #start) == start
                -- end
                --
                -- string.basename = function(s)
                --     return string.gsub(s, '(.*[/\\])(.*)', '%2')
                -- end
                --
                --
                -- local home = wezterm.home_dir
                -- local year_in_secs = 60*60*24*365
                -- for _, v in ipairs(wezterm.read_dir(home, function(filepath, meta)
                --     -- wezterm.log_info(filepath, meta:is_dir(), meta:is_symlink())
                --     -- return { (meta:is_symlink() or meta:is_dir()) and (not filepath:basename():startswith('.')), #filepath, meta:secs_since_accessed() }
                --     -- return meta:is_symlink() and meta:is_dir()
                --     return {
                --         meta:is_file() and (10^3 < meta:bytes() and meta:bytes() < 10^7) and (meta:secs_since_created() < year_in_secs),
                --         filepath:basename(),
                --         -meta:secs_since_created()
                --     }
                -- end)) do
                --     wezterm.log_info('entry: ' .. v)
                -- end
                --
                -- local tbl = wezterm.read_dir(home, function(filepath, meta) return { meta:is_file(), filepath:basename() }  end)
                -- wezterm.log_info(tbl)
            end)
        }
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
