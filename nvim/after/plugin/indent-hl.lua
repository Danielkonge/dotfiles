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
    indent = { char = '┊', }, -- can add: highlight = highlight, here too
    scope = { highlight = highlight, show_end_always = true, },
    viewport_buffer = { min = 100, max = 200, },
    current_indent = { enabled = true }, -- only available in my fork
})
