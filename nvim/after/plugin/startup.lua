-- startup.lua

vim.g.startup_bookmarks = {
  ["S"] = '~/.config/nvim/after/plugin/startup.lua',
  ["Z"] = '~/.zshrc',
  ["K"] = '~/.config/kitty/kitty.conf',
  ["T"] = '~/.config/tmux/tmux.conf',
  ["I"] = '~/.config/nvim/lua/daniel/init.lua',
  ["W"] = '~/.config/wezterm/wezterm.lua',
  ["H"] = '~/.hammerspoon/init.lua',
}

local user_bookmarks = vim.g.startup_bookmarks

local bookmark_texts = { "Bookmarks:", "" }
local user_bookmark_mappings = {}

for key, file in pairs(user_bookmarks) do
  bookmark_texts[#bookmark_texts + 1] = "[" .. key .. "]" .. " " .. file
end

local function longest_line(lines)
    local longest = 0
    for _, line in ipairs(lines) do
        if vim.fn.strdisplaywidth(line) > longest then
            longest = vim.fn.strdisplaywidth(line)
        end
    end
    return longest
end

local function spaces(amount)
    return string.rep(" ", amount)
end

local bm_length = longest_line(bookmark_texts) + 2
local bookmark_texts_aligned = {}
for _, file in ipairs(bookmark_texts) do
  table.insert(bookmark_texts_aligned, file .. spaces(bm_length - #file))
end

for key, file in pairs(user_bookmarks) do
  user_bookmark_mappings[key] = "<cmd>e " .. file .. "<CR>"
end
local nvim_header = {
  "                                          /$$              ",
  "                                         |__/              ",
  " /$$$$$$$   /$$$$$$   /$$$$$$  /$$    /$$ /$$ /$$$$$$/$$$$ ",
  "| $$__  $$ /$$__  $$ /$$__  $$|  $$  /$$/| $$| $$_  $$_  $$",
  "| $$  \\ $$| $$$$$$$$| $$  \\ $$ \\  $$/$$/ | $$| $$ \\ $$ \\ $$",
  "| $$  | $$| $$_____/| $$  | $$  \\  $$$/  | $$| $$ | $$ | $$",
  "| $$  | $$|  $$$$$$$|  $$$$$$/   \\  $/   | $$| $$ | $$ | $$",
  "|__/  |__/ \\_______/ \\______/     \\_/    |__/|__/ |__/ |__/",
}
local cow = {
  "        \\   ^__^",
  "         \\  (oo)\\_______",
  "            (__)\\       )\\/\\",
  "                ||----w |",
  "                ||     ||",
}

local quote = require("startup.functions").quote()
while true do
  if require("startup.utils").longest_line(quote) <= vim.o.columns - 15 then
    break
  end
  quote = require("startup.functions").quote()
end
local length = require("startup.utils").longest_line(quote) + 4

local complete = {}

table.insert(quote, 1, "")
quote[#quote + 1] = ""

table.insert(complete, "▛" .. string.rep("▀", length - 2) .. "▜")
local function spaces(amount)
  return string.rep(" ", amount)
end
for _, line in ipairs(quote) do
  table.insert(
    complete,
    "▌" .. " " .. line .. spaces(length - 3 - #line) .. "▐"
  )
end
table.insert(complete, "▙" .. string.rep("▄", length - 2) .. "▟")

for _, line in ipairs(cow) do
  complete[#complete + 1] = line
end

-- NOTE: lua dump(vim.fn.expand("#<1")) to get newest oldfile

require("startup").setup({
  pre_header = {
    type = "text",
    align = "center",
    fold_section = false,
    margin = 5,
    content = nvim_header,
    highlight = "String",
  },
  header = {
    type = "text",
    oldfiles_directory = false,
    align = "left",
    fold_section = false,
    title = "Header",
    margin = 5,
    content = complete,
    highlight = "Statement",
    default_color = "",
    oldfiles_amount = 0,
  },
  body = {
    type = "oldfiles",
    oldfiles_directory = false,
    align = "center",
    fold_section = false,
    title = "Oldfiles",
    margin = 5,
    content = "",
    highlight = "String",
    default_color = "",
    oldfiles_amount = 5,
  },
  body_2 = {
    type = "oldfiles",
    oldfiles_directory = true,
    align = "center",
    fold_section = false,
    title = "",
    margin = 5,
    content = "",
    highlight = "String",
    oldfiles_amount = 5,
  },
  bookmarks = {
    type = "text",
    align = "center",
    margin = 5,
    content = bookmark_texts_aligned,
    highlight = "String",
  },
  time_data = {
    type = "text",
    align = "center",
    margin = 5,
    content = function()
      local clock = " " .. os.date "%H:%M"
      local date = " " .. os.date "%d-%m-%y"
      return {clock,date}
    end,
    highlight = "String",
  },
  options = {
    after = function()
      require("startup").create_mappings(user_bookmark_mappings)
      require("startup.utils").oldfiles_mappings()
    end,
    mapping_keys = false,
    cursor_column = 0.25,
    empty_line_between_mappings = false,
    disable_statuslines = true,
    paddings = { 3, 2, 1, 2, 2, 2 },
  },
  mappings = {
    execute_command = "<CR>",
    open_file = "o",
    open_file_split = "<c-o>",
    open_section = "<TAB>",
    open_help = "?",
  },
  colors = {
    background = "#1f2227",
    folded_section = "#56b6c2",
  },
  parts = { "pre_header", "header", "body", "body_2", "bookmarks", "time_data" },
})

-- require("startup").setup({
--   theme = "startify",
-- })
