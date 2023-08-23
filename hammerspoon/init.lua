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


local battery = {
  percent = hs.battery.percentage(),
  source = hs.battery.powerSource(),
  title = "Battery Status",
  high = 80,
  low = 20,
  very_low = 5,
}

local alertPowerSource = function()
  local currentSource = hs.battery.powerSource()
  if battery.source ~= currentSource then
    battery.source = currentSource
    hs.alert.show(battery.source)
  end
end

local notifyCharge = function()
  local currentPercent = hs.battery.percentage()
  if battery.percent == currentPercent then
    return
  end
  battery.percent = currentPercent
  if battery.source == 'AC Power' then
    if battery.percent == 100 then
      hs.notify.new({
        title = battery.title,
        subTitle = "Battery fully charged"
      }):send()
    end
    if battery.percent == battery.high then
      hs.notify.new({
        title = battery.title,
        subTitle = "Battery " .. tostring(battery.high) .. "% charged"
      }):send()
    end
  end
  if battery.source == 'Battery Power' then
    if battery.percent == battery.low then
      hs.notify.new({
        title = battery.title,
        subTitle = "Battery " .. tostring(battery.low) .. "% charge remaining"
      }):send()
    end
    if battery.percent == battery.very_low then
      hs.notify.new({
        title = battery.title,
        subTitle = "Battery " .. tostring(battery.very_low) .. "% charge remaining"
      }):send()
    end
  end
end

local batteryWatcherCallback = function()
  alertPowerSource()
  notifyCharge()
end

-- if the watcher is local it can get garbage collected 
-- unless we call it somewhere else
DK_batteryWatcher = hs.battery.watcher.new(batteryWatcherCallback)
DK_batteryWatcher:start()

local hotkeys = {
  n = "Notes",
  t = "WezTerm",
  m = "Spotify",
  b = "Safari",
}

for key, app in pairs(hotkeys) do
  hs.hotkey.bind(hyper, key, function()
    hs.application.launchOrFocus(app)
  end)
end

hs.loadSpoon("DeepLTranslate")
spoon.DeepLTranslate:bindHotkeys({
  translate = { hyper, "z" }
})

local wm = { "ctrl", "alt" }
hs.loadSpoon("MiroWindowsManager")
hs.window.animationDuration = 0.0
spoon.MiroWindowsManager:bindHotkeys({
  up = {wm, "up"},
  right = {wm, "right"},
  down = {wm, "down"},
  left = {wm, "left"},
  fullscreen = {wm, "return"},
})

hs.loadSpoon("ClipboardTool")
spoon.ClipboardTool.paste_on_select = true
spoon.ClipboardTool.show_copied_alert = false
spoon.ClipboardTool.show_in_menubar = false
spoon.ClipboardTool.frequency = 3.0
spoon.ClipboardTool:start()

spoon.ClipboardTool:bindHotkeys({
  toggle_clipboard = { { "cmd", "shift" }, "v" }
})


hs.loadSpoon("KSheet")
-- spoon.KSheet.init()

spoon.KSheet:bindHotkeys({
  toggle = { hyper, "h" }
})


