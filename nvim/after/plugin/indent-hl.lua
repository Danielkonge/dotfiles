-- indent-hl.lua

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

require("ibl").setup({
    indent = { char = '┊', highlight = "LineNr" }, -- LineNr is the standard hl, but some themes overwrite it
    scope = {
        highlight = highlight,
        show_exact_scope = true,
    },
    viewport_buffer = { min = 50, max = 1000, },
    current_indent = { enabled = true, highlight = "CursorLineNr" },
})
