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

-- hooks.register(
--     hooks.type.ACTIVE,
--     function(_)
--         if vim.bo.buftype == 'nofile' then
--             if vim.b.dev_base then
--                 -- we are in `InspectTree`
--                 if vim.fn.line('$') < 500 then
--                     return true
--                 else
--                     -- ibl is slow on large trees
--                     return false
--                 end
--             else
--                 return false
--             end
--         end
--         return true
--     end
-- )

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

-- note: overwrite needs to be after setup
-- ibl.overwrite({
--     exclude = {
--         buftypes = {
--             "terminal",
--             -- don't include "nofile",
--             "quickfix",
--             "prompt",
--         }
--     }
-- })

