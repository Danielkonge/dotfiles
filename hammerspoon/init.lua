hs.loadSpoon("EmmyLua")

local hyper = { "cmd", "alt", "ctrl" }

-- NOTE: hs.reload() destroys the current Lua interpreter and
-- creates a new one, so we can't have any code after hs.reload()
hs.hotkey.bind(hyper, "r", function()
  hs.reload()
end)
hs.alert.show("Config re-loaded")



hs.hotkey.bind(hyper, "s", function()
  hs.spotify.displayCurrentTrack()
end)


DK_battery = {
  percent = hs.battery.percentage(),
  source = hs.battery.powerSource(),
  title = "Battery Status",
  high = 80,
  low = 20,
  very_low = 5,
}

DK_alertPowerSource = function()
  local currentSource = hs.battery.powerSource()
  if DK_battery.source ~= currentSource then
    DK_battery.source = currentSource
    hs.alert.show(DK_battery.source)
  end
end

DK_notifyCharge = function()
  local currentPercent = hs.battery.percentage()
  if DK_battery.percent == currentPercent then
    return
  end
  DK_battery.percent = currentPercent
  if DK_battery.source == 'AC Power' then
    if DK_battery.percent == 100 then
      hs.notify.new({
        title = DK_battery.title,
        subTitle = "Battery fully charged"
      }):send()
    end
    if DK_battery.percent == DK_battery.high then
      hs.notify.new({
        title = DK_battery.title,
        subTitle = "Battery " .. tostring(DK_battery.high) .. "% charged"
      }):send()
    end
  end
  if DK_battery.source == 'Battery Power' then
    if DK_battery.percent == DK_battery.low then
      hs.notify.new({
        title = DK_battery.title,
        subTitle = "Battery " .. tostring(DK_battery.low) .. "% charge remaining"
      }):send()
    end
    if DK_battery.percent == DK_battery.very_low then
      hs.notify.new({
        title = DK_battery.title,
        subTitle = "Battery " .. tostring(DK_battery.very_low) .. "% charge remaining"
      }):send()
    end
  end
end

BatteryWatcherCallback = function()
  DK_alertPowerSource()
  DK_notifyCharge()
end

-- if the watcher is local it can get garbage collected
-- unless we call it somewhere else
DK_batteryWatcher = hs.battery.watcher.new(BatteryWatcherCallback)
DK_batteryWatcher:start()


local wm = { "ctrl", "alt" }
-- local wms = { "ctrl", "alt", "shift" }
hs.loadSpoon("MiroWindowsManager")
hs.window.animationDuration = 0.0
spoon.MiroWindowsManager:bindHotkeys({
  up = { wm, "up" },
  right = { wm, "right" },
  down = { wm, "down" },
  left = { wm, "left" },
  fullscreen = { wm, "return" },
})

-- PaperWM = hs.loadSpoon("PaperWM")
-- PaperWM:bindHotkeys({
--   -- switch to a new focused window in tiled grid
--   focus_left      = { wm, "h" },
--   focus_right     = { wm, "l" },
--   focus_up        = { wm, "k" },
--   focus_down      = { wm, "j" },
--
--   -- switch windows by cycling forward/backward
--   -- (forward = down or right, backward = up or left)
--   focus_prev      = { wm, "tab" },
--   focus_next      = { wms, "tab" },
--
--   -- move windows around in tiled grid
--   swap_left       = { wms, "h" },
--   swap_right      = { wms, "l" },
--   swap_up         = { wms, "k" },
--   swap_down       = { wms, "j" },
--
--   -- position and resize focused window
--   center_window   = { wm, "c" },
--   -- anchor_window_left   = {{"ctrl", "alt", "cmd"}, ","},
--   -- anchor_window_right  = {{"ctrl", "alt", "cmd"}, "."},
--   -- full_width           = {{"alt", "cmd"}, "f"},
--   -- cycle_width          = {{"alt", "cmd"}, "r"},
--   -- reverse_cycle_width  = {{"ctrl", "alt", "cmd"}, "r"},
--   -- cycle_height         = {{"alt", "cmd", "shift"}, "r"},
--   -- reverse_cycle_height = {{"ctrl", "alt", "cmd", "shift"}, "r"},
--
--   -- increase/decrease width
--   -- increase_width = {{"alt", "cmd"}, "l"},
--   -- decrease_width = {{"alt", "cmd"}, "h"},
--
--   -- move focused window into / out of a column
--   -- slurp_in = {{"alt", "cmd"}, "i"},
--   -- barf_out = {{"alt", "cmd"}, "o"},
--
--   -- split screen focused window with left window
--   split_screen    = { wm, "s" },
--
--   -- move the focused window into / out of the tiling layer
--   toggle_floating = { wm, "f" },
--   -- raise all floating windows on top of tiled windows
--   -- focus_floating  = {{"alt", "cmd", "shift"}, "f"},
--
--   -- focus the first / second / etc window in the current space
--   focus_window_1  = { wm, "1" },
--   focus_window_2  = { wm, "2" },
--   focus_window_3  = { wm, "3" },
--   focus_window_4  = { wm, "4" },
--   focus_window_5  = { wm, "5" },
--   focus_window_6  = { wm, "6" },
--   focus_window_7  = { wm, "7" },
--   focus_window_8  = { wm, "8" },
--   focus_window_9  = { wm, "9" },
--
--   -- focus the leftmost / rightmost window in the current space
--   -- focus_window_first = {{"cmd", "shift"}, "home"},
--   -- focus_window_last  = {{"cmd", "shift"}, "end"},
--
--   -- switch to a new Mission Control space
--   -- switch_space_l = {{"alt", "cmd"}, ","},
--   -- switch_space_r = {{"alt", "cmd"}, "."},
--   -- switch_space_1 = {{"alt", "cmd"}, "1"},
--   -- switch_space_2 = {{"alt", "cmd"}, "2"},
--   -- switch_space_3 = {{"alt", "cmd"}, "3"},
--   -- switch_space_4 = {{"alt", "cmd"}, "4"},
--   -- switch_space_5 = {{"alt", "cmd"}, "5"},
--   -- switch_space_6 = {{"alt", "cmd"}, "6"},
--   -- switch_space_7 = {{"alt", "cmd"}, "7"},
--   -- switch_space_8 = {{"alt", "cmd"}, "8"},
--   -- switch_space_9 = {{"alt", "cmd"}, "9"},
--
--   -- move focused window to a new space and tile
--   move_window_l   = { { "ctrl", "shift" }, "left" },
--   move_window_r   = { { "ctrl", "shift" }, "right" },
--   move_window_u   = { { "ctrl", "shift" }, "up" },
--   move_window_d   = { { "ctrl", "shift" }, "down" },
--   move_window_1   = { { "ctrl", "shift" }, "1" },
--   move_window_2   = { { "ctrl", "shift" }, "2" },
--   move_window_3   = { { "ctrl", "shift" }, "3" },
--   move_window_4   = { { "ctrl", "shift" }, "4" },
--   move_window_5   = { { "ctrl", "shift" }, "5" },
--   move_window_6   = { { "ctrl", "shift" }, "6" },
--   move_window_7   = { { "ctrl", "shift" }, "7" },
--   move_window_8   = { { "ctrl", "shift" }, "8" },
--   move_window_9   = { { "ctrl", "shift" }, "9" }
-- })
-- -- PaperWM.swipe_fingers = 3
-- PaperWM.scroll_window = wm
-- -- enable infinite loop scrolling for focus left/right/up/down
-- PaperWM.infinite_loop_window = true
-- -- PaperWM.window_gap = 10
-- PaperWM:start()

hs.loadSpoon("ClipboardTool")
spoon.ClipboardTool.paste_on_select = true
spoon.ClipboardTool.show_copied_alert = false
spoon.ClipboardTool.show_in_menubar = false
spoon.ClipboardTool.frequency = 3.0
spoon.ClipboardTool:start()

spoon.ClipboardTool:bindHotkeys({
  toggle_clipboard = { { "cmd", "shift" }, "v" }
})
