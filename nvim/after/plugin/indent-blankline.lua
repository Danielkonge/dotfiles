-- indent-blankline.lua

local highlight = {
    "RainbowDelimiterRed",
    "RainbowDelimiterYellow",
    "RainbowDelimiterBlue",
    "RainbowDelimiterOrange",
    "RainbowDelimiterGreen",
    "RainbowDelimiterViolet",
    "RainbowDelimiterCyan",
}
-- vim.g.rainbow_delimiters = { highlight = highlight }

local hooks = require "ibl.hooks"

hooks.register(
    hooks.type.SCOPE_HIGHLIGHT,
    hooks.builtin.scope_highlight_from_extmark
)

local ibl = require("ibl")

ibl.setup({
    indent = { char = '┊', highlight = "LineNr" }, -- LineNr is the standard hl, but some themes overwrite it
    debounce = 200,
    scope = {
        highlight = highlight,
        show_exact_scope = true,
    },
    viewport_buffer = { min = 5, max = 10, },
    current_indent = {
        enabled = true,
        highlight = "CursorLineNr",
        show_start = false,
        show_end = false,
    },
})

