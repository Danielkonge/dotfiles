local wezterm = require('wezterm')
local act = wezterm.action

local workspace = {}

function workspace.apply_to_config(config)
    config.default_workspace = "Home"
end

function workspace.fuzzy_picker(window, pane)
    local success, stdout, stderr = wezterm.run_child_process {
        '/Users/daniel/.config/scripts/wezterm-workspaces.sh'
    }
    local workspaces = {}

    if success then
        for line in stdout:gmatch("[^\r\n]+") do
            -- Match on the '$' symbol
            for line_id, line_label in line:gmatch("(.+) %$ (.+)") do
                table.insert(workspaces, { id = line_id, label = line_label })
            end
        end
    else
        wezterm.log_info('stderr:', stderr)
    end

    window:perform_action(
        act.InputSelector {
            action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
                if not id and not label then
                    wezterm.log_info 'Cancelled'
                else
                    wezterm.log_info('You selected id(' .. id .. ') and label(' .. label .. ')')
                    inner_window:perform_action(
                        act.SwitchToWorkspace {
                            name = label,
                            spawn = {
                                label = 'Workspace: ' .. label,
                                cwd = id,
                            }
                        },
                        inner_pane
                    )
                end
            end),
            title = 'Choose Workspace',
            choices = workspaces,
        },
        pane
    )
end

return workspace