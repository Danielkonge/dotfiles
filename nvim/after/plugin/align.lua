-- align_to_char(length, reverse, preview, marks)
-- align_to_string(is_pattern, reverse, preview, marks)
-- align(str, reverse, marks)
-- operator(fn, opts)
-- Where:
--      length: integer
--      reverse: boolean
--      preview: boolean
--      marks: table (e.g. {1, 0, 23, 15})
--      str: string (can be plaintext or Lua pattern if is_pattern is true)


vim.keymap.set('x', 'ga1', function()
    require 'align'.align_to_char({
        preview = true,
        length = 1,
    }) end,
    { noremap = true, silent = true, desc = 'Align to one char' })
vim.keymap.set('x', 'ga2', function()
    require 'align'.align_to_char({
        preview = true,
        length = 2,
    }) end,
    { noremap = true, silent = true, desc = 'Align to two chars' })
vim.keymap.set('x', 'gar', function()
    require 'align'.align_to_string({
        preview = true,
        regex = true,
    }) end,
    { noremap = true, silent = true, desc = 'Align to regex from the left' })
vim.keymap.set('x', 'gaR', function()
    require 'align'.align_to_string({
        preview = true,
        regex = true,
        reverse = true,
    }) end,
    { noremap = true, silent = true, desc = 'Align to regex from the right' })

require("which-key").register({
    ["ga"] = { name = "+align", mode = "x" },
})
