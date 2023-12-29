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
            action = wezterm.action_callback(workspaces.quick_picker),
        },
        {
            key = 'F',
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



        {
            key = 'å',
            mods = 'LEADER',
            action = wezterm.action_callback(function(_win, _pane)
                local weztable = wezterm.table
                -- wezterm.log_info( weztable.to_string(_G) )
                -- wezterm.log_info( weztable.to_string_fallback(_G) )


--                 wezterm.log_info(wezterm.to_string { 1, 2 })
--                 wezterm.log_info(wezterm.to_string { 1, 2 } == [=[[
--     1,
--     2,
-- ]]=])
--                 wezterm.log_info(wezterm.to_string { a = 1, b = 2 })
--                 wezterm.log_info(wezterm.to_string { a = 1, b = 2 } == [[{
--     "a": 1,
--     "b": 2,
-- }]])
                -- local has_value = wezterm.table.has_value
                --
                -- local tbl1 = {
                --     a = 1,
                --     b = {
                --         c = {
                --             d = 4
                --         }
                --     },
                -- }
                -- local arr1 = { 'a', 'b', 'c' }
                --
                -- wezterm.log_info(has_value(tbl1, 1))
                -- wezterm.log_info(not has_value(tbl1, 4))
                -- wezterm.log_info(has_value(tbl1, 4, 'Deep'))
                -- wezterm.log_info(not has_value(tbl1, 'a', 'Deep'))
                --
                -- wezterm.log_info(has_value(arr1, 'a'))
                -- wezterm.log_info(not has_value(arr1, '1'))

                -- local flatten = wezterm.table.flatten
                -- local equal = wezterm.table.equal
                --
                -- local arr1 = { { 1, 2 }, 3 }
                -- local arr2 = { 'a', { 'b', { 'c' } } }
                -- local arr3 = { 1, { a = 1, 2 }, { b = 2 } }
                --
                -- wezterm.log_info(equal(flatten({ arr1, arr2 }), { { 1, 2 }, 3, 'a', { 'b', { 'c' } } }))
                -- wezterm.log_info(flatten({arr1, arr2}))
                -- wezterm.log_info(equal(flatten({ arr1, arr2 }, 'Deep'), { 1, 2, 3, 'a', 'b', 'c' }))
                --
                -- wezterm.log_info(equal(flatten({arr1, arr3}), { { 1, 2 }, 3, 1, { a = 1, 2 }, { b = 2 } }))
                -- wezterm.log_info(flatten({arr1, arr3}))
                -- wezterm.log_info(equal(flatten({arr1, arr3}, 'Deep'), { 1, 2, 3, 1, 2 }))

                -- local extend = wezterm.table.extend
                -- local deep_extend = wezterm.table.deep_extend
                -- local equal = wezterm.table.equal
                --
                -- local tbl1 = {
                --     a = 1,
                --     b = {
                --         d = 4,
                --     },
                --     c = 3,
                -- }
                --
                -- local tbl2 = {
                --     a = 2,
                --     b = {
                --         e = 5,
                --     },
                --     d = 4,
                -- }
                --
                -- local tbl3 = {
                --     e = 5,
                -- }
                --
                -- wezterm.log_info(equal(extend({tbl1, tbl2}), { a = 2, b = { e = 5 }, c = 3, d = 4 }))
                -- wezterm.log_info(equal(extend({tbl1, tbl2}, 'Keep'), { a = 1, b = { d = 4 }, c = 3, d = 4 }))
                -- -- This will return an error: extend({tbl1, tbl2}, 'Error')
                --
                -- wezterm.log_info(equal(extend({tbl2, tbl3}), { a = 2, b = { e = 5 }, d = 4, e = 5 }))
                -- wezterm.log_info(equal(extend({tbl2, tbl3}, 'Keep'), { a = 2, b = { e = 5 }, d = 4, e = 5 }))
                -- wezterm.log_info(equal(extend({tbl2, tbl3}, 'Error'), { a = 2, b = { e = 5 }, d = 4, e = 5 }))
                --
                -- wezterm.log_info(equal(deep_extend({tbl1, tbl2}), { a = 2, b = { d = 4, e = 5 }, c = 3, d = 4 }))
                -- wezterm.log_info(equal(deep_extend({tbl1, tbl2}, 'Keep'), { a = 1, b = { d = 4, e = 5 }, c = 3, d = 4 }))
                -- -- This will return an error: extend({tbl1, tbl2}, 'Error')
                --
                -- tbl3 = {
                --     b = {
                --         a = 1,
                --         b = 2,
                --     }
                -- }
                --
                -- wezterm.log_info(equal(deep_extend({tbl2, tbl3}), { a = 2, b = { a = 1, b = 2, e = 5 }, d = 4 }))
                -- wezterm.log_info(equal(deep_extend({tbl2, tbl3}, 'Keep'), { a = 2, b = { a = 1, b = 2, e = 5 }, d = 4 }))
                -- wezterm.log_info(equal(deep_extend({tbl2, tbl3}, 'Error'), { a = 2, b = { a = 1, b = 2, e = 5 }, d = 4 }))

                -- local has_key = wezterm.table.has_key
                -- local get = wezterm.table.get
                --
                -- local tbl1 = {
                --     a = 1,
                --     b = {
                --         c = {
                --             d = 4
                --         }
                --     }
                -- }
                -- local arr1 = { 'a', 'b', 'c' }
                --
                -- wezterm.log_info(has_key(tbl1, 'a'))
                -- wezterm.log_info(has_key(tbl1, 'b'))
                -- wezterm.log_info(has_key(tbl1, 'b', 'c', 'd'))
                --
                -- wezterm.log_info(has_key(arr1, 3))
                -- wezterm.log_info(not has_key(arr1, 4))
                -- wezterm.log_info(not has_key(arr1, 1, 2))
                --
                -- wezterm.log_info(get(tbl1, 'a') == 1)
                -- wezterm.log_info(get(tbl1, 'b') == tbl1.b) -- note: we get the table address of tbl1.b here
                -- wezterm.log_info(get(tbl1, 'b', 'c', 'd') == 4)
                -- wezterm.log_info(get(tbl1, 'c') == nil)
                --
                -- wezterm.log_info(get(arr1, 3) == 'c')
                -- wezterm.log_info(get(arr1, 4) == nil)
                -- wezterm.log_info(get(arr1, 1, 2) == nil)

                -- local clone = wezterm.table.clone
                -- local equal = wezterm.table.equal
                --
                -- local tbl = {
                --     a = 1,
                --     b = '2',
                --     c = {
                --         d = 1,
                --     },
                -- }
                -- local tbl_copy = tbl -- copy the table address
                -- local tbl_top_clone = clone(tbl) -- same as clone(tbl1, 'Top')
                -- local tbl_deep_clone = clone(tbl, 'Deep')
                --
                -- wezterm.log_info(tbl == tbl_copy)
                -- wezterm.log_info(not (tbl == tbl_top_clone))
                -- wezterm.log_info(not (tbl == tbl_deep_clone))
                -- wezterm.log_info(equal(tbl, tbl_top_clone))
                -- wezterm.log_info(equal(tbl, tbl_deep_clone))
                --
                -- tbl.a = 2
                -- wezterm.log_info(not equal(tbl, tbl_top_clone))
                -- wezterm.log_info(tbl_top_clone.a == 1)
                -- wezterm.log_info(not equal(tbl, tbl_deep_clone))
                -- wezterm.log_info(tbl_deep_clone.a == 1)
                -- tbl.a = 1
                --
                -- tbl.c.d = 2
                -- wezterm.log_info(equal(tbl, tbl_top_clone))
                -- wezterm.log_info(tbl_top_clone.c.d == 2)
                -- wezterm.log_info(not equal(tbl, tbl_deep_clone))
                -- wezterm.log_info(tbl_deep_clone.c.d == 1)


                -- wezterm.log_info("table test fallback", weztable.to_string_fallback( { a=1, b=2 } ), weztable.to_string_fallback( { a=1, { b=2 } } ) )
                -- wezterm.log_info("table test", weztable.to_string( { a=1, b=2 } ), weztable.to_string( { a=1, { b=2 } } ) )
                -- wezterm.log_info( weztable.extend( { { opt1 = "a", opt2 = "b" }, { opt3 = "c", opt4 = "d" }, { opt1 = "b" } } ) )
                -- wezterm.log_info( weztable.extend( { { opt1 = { a = 1, b = 2 }, opt2 = { 1, 2 } }, { opt3 = "c", opt4 = "d" }, { opt1 = { a = 3 } } }, "Keep" ) )
                -- wezterm.log_info( weztable.extend( { { opt1 = { a = 1, b = 2 }, opt2 = { 1, 2 } }, { opt3 = "c", opt4 = "d" }, { opt1 = { a = 3 } } }, "Force" ) )
                local ok, _ = pcall(function() weztable.deep_extend({ { opt1 = "a", opt2 = "b" }, { opt3 = "c", opt4 = "d" }, { opt1 = "b" } }, "Error") end)
                wezterm.log_info(not ok)

                local tbl1 = {
                    a = 1,
                    b = {
                        d = 4,
                    },
                    e = 3,
                }
                local tbl2 = {
                    a = 2,
                    b = {
                        e = 5,
                    },
                    d = 4,
                }
                local tbl3 = {
                    e = 5,
                }
                local ok1, msg = pcall(function() weztable.extend({tbl1, tbl3}, 'Error') end)
                local msg_string = wezterm.to_string(msg)
                -- wezterm.log_info(not ok, msg_string)
                wezterm.log_info(not ok1 and  msg_string:find "The key 'e' is in more than one of the tables." ~= nil)
                local ok2, ms2 = pcall(function() weztable.deep_extend({tbl1, tbl2}, 'Error') end)
                local msg_string2 = wezterm.to_string(ms2)
                wezterm.log_info(not ok2 and  msg_string2:find "The key 'a' is in more than one of the tables." ~= nil)
                wezterm.log_info( weztable.deep_extend( { { opt1 = { a = 1, b = 2 }, opt2 = { 1, 2 } }, { opt3 = "c", opt4 = "d" }, { opt1 = { a = 3 } } }, "Keep" ) )
                wezterm.log_info( weztable.deep_extend( { { opt1 = { a = 1, b = 2 }, opt2 = { 1, 2 } }, { opt3 = "c", opt4 = "d" }, { opt1 = { a = 3 } } }, "Force" ) )
                --
                -- wezterm.log_info( weztable.equal( { 1, 2, { a = 'a', b = 'abc' } }, { 1, 2, { a = 'a', b = 'abc' } } ) )
                -- local tmp1 = { a = { b = { c = 'c' } }, 1, { 2 } }
                -- local tmp2 = { a = { b = { c = 'c' } }, 1, { 2 } }
                -- wezterm.log_info( "tmp1", tmp1, "tmp2", tmp2 )
                -- wezterm.log_info( weztable.equal( tmp1, tmp2 ) )
                -- wezterm.log_info( tmp1, tmp2 )
                -- wezterm.log_info( weztable.equal( tmp1, tmp2 ) )

                -- local tmp3 = { 1,2,3 }
                -- local tmp4 = weztable.clone(tmp3)
                -- wezterm.log_info( "new:", tmp3, tmp4 )
                -- tmp3[1] = nil
                -- wezterm.log_info( "new:", tmp3, tmp4 )
                -- wezterm.log_info( "test1:", weztable.to_string({ a = {'a'}, 1, {2} }))
                -- wezterm.log_info( "test2:", weztable.to_string_fallback({ a = {'a'}, 1, {2} }))
                -- wezterm.log_info( weztable.extend( { { opt1 = "a", opt2 = "b" }, { opt3 = "c", opt4 = "d" }, { opt1 = "b" } }, "keep" ) )
                -- wezterm.log_info( weztable.extend( { { opt1 = "a", opt2 = { 1, 2 } }, { opt3 = "c", opt4 = "d" }, { opt1 = "b" } }, "Force" ) )
                -- wezterm.log_info( weztable.extend( { { opt1 = "a", opt2 = "b" }, { opt3 = "c", opt4 = "d" }, { opt1 = "b" } }, "Error" ) )
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
                -- local t = { a = 1, b = 2, c = { a = { b = 'a' }, b = nil }, 1 }
                -- wezterm.log_info(#t)
                -- wezterm.log_info(weztable.length(t))
                -- wezterm.log_info(weztable.has_key(t, "a"))
                -- wezterm.log_info(weztable.has_key(t, "a", 'c', 'a'))
                -- wezterm.log_info(weztable.has_key(t, "c", 'a', 'b'))
                -- wezterm.log_info(weztable.has_key(t, "c", nil))
                -- wezterm.log_info(weztable.has_key(t, "b"))
                -- wezterm.log_info(weztable.has_key(t, "c", 'b'))
                -- wezterm.log_info(weztable.has_key(t, 1))
                -- wezterm.log_info(weztable.has_key(t, nil))
                -- wezterm.log_info(weztable.has_key(t, 2))
                -- wezterm.log_info(weztable.get(t, "a"))
                -- wezterm.log_info(weztable.get(t, "a", 'c', 'a'))
                -- wezterm.log_info(weztable.get(t, "c", 'a', 'b'))
                -- wezterm.log_info(weztable.get(t, "c", nil))
                -- wezterm.log_info(weztable.get(t, "b"))
                -- wezterm.log_info(weztable.get(t, "c", 'b'))
                -- wezterm.log_info(weztable.get(t, 1))
                -- wezterm.log_info(weztable.get(t, nil))
                -- wezterm.log_info(weztable.get(t, 2))
                -- wezterm.log_info(weztable.get(t, "c"))
                -- wezterm.log_info(table.has_value(t, 1))
                --
                -- wezterm.log_info( table.to_string(t) )
                --

                -- local tbl = { 1, 2, 3, { a = 1, b = 2, { 5 } } }

                -- wezterm.log_info( table.to_string( { {1,2,3}, { a = 1, b = 2, { 5 }} } ) )
                -- wezterm.log_info(weztable.to_string({ { 1, 2, 3 }, { a = 1, b = 2, { 5 } } }, 0))
                -- wezterm.log_info(weztable.to_string({ { 1, 2, 3 }, { a = 1, b = 2, { 5 } } }, 2))
                -- wezterm.log_info(weztable.to_string({ { 1, 2, 3 }, { a = 1, b = 2, { 5 } } }, 0, true))
                -- wezterm.log_info(weztable.to_string(tbl))

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

                -- local home = wezterm.home_dir
                -- local tbl = wezterm.read_dir(home, function(filepath, meta) return { meta:is_file(), filepath }  end)
                -- wezterm.log_info(tbl)

                -- local per_path = wezterm.to_path("/Users/daniel/personal")
                -- wezterm.log_info(per_path)

                -- local home_path = per_path:dirname()
                -- wezterm.log_info(home_path)
                -- home_path:pop()
                -- wezterm.log_info(home_path)

                -- local basepath = per_path:basename()

                -- local test_path = home_path:join(basepath)
                -- wezterm.log_info(test_path)

                -- wezterm.log_info("Extra tests:")

                -- local test = wezterm.to_path("/path1") .. wezterm.to_path("/path2")
                -- -- local test1 = "string" .. wezterm.to_path("/path")
                -- local test2 = wezterm.to_path("/path") .. "/string"
                -- local test3 = string.format("%s/string", wezterm.to_path("/path"))
                -- local test4 = wezterm.to_path("/path"):join("file.txt")
                -- local test5 = wezterm.to_path( wezterm.home_dir ):metadata()
                -- wezterm.log_info(test, test2, test3, test4, test5)

                -- local to_path = wezterm.to_path
                -- local tmp = to_path('Test')
                -- wezterm.log_info( tmp:upper(), tmp:lower())
                -- local tmp2 = to_path('a longer test')
                -- local test = tmp2:clone()
                -- local tmp3 = 'some longer test'
                -- wezterm.log_info( tmp3:find('e') )
                -- wezterm.log_info( tmp2:find('e'))
                -- wezterm.log_info( tmp2:find('z') )
                -- wezterm.log_info( tmp3:find('z') )
                -- test:gsub('a', 'one')
                -- wezterm.log_info(tmp2, test)
                -- local test2 = tmp2:clone()
                -- test2:join("abc")
                -- wezterm.log_info(tmp2, test2, tmp2 == test2)
                -- local tmp = wezterm.Path.clone('tmp')
                -- wezterm.log_info(tmp)
                -- local test1 = to_path 'abc'
                -- local test2 = test1:clone()
                -- local test3 = to_path 'xyz'
                -- wezterm.log_info(test1, test2, test3)
                -- wezterm.log_info(test1 == test2)
                -- wezterm.log_info(test1 == test3)
                -- wezterm.log_info(test1, test2, test3, test1 == test2, test1 == test3, test2 == test3)

                -- string.match
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

    config.mouse_bindings = {
        {
            event = { Down = { streak = 2, button = 'Left' } },
            action = act.SelectTextAtMouseCursor 'SemanticZone',
            mods = 'SHIFT',
        },
    }
end

return keys
