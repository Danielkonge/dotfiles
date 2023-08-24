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


vim.keymap.set('x', 'ga1', function() require 'align'.align_to_char(1, true) end,
    { noremap = true, silent = true, desc = 'Align to one char' })    -- Aligns to 1 character, looking left
vim.keymap.set('x', 'ga2', function() require 'align'.align_to_char(2, true, true) end,
    { noremap = true, silent = true, desc = 'Align to two chars' })   -- Aligns to 2 characters, looking left and with previews
vim.keymap.set('x', 'gaw', function() require 'align'.align_to_string(false, true, true) end,
    { noremap = true, silent = true, desc = 'Align to string' })      -- Aligns to a string, looking left and with previews
vim.keymap.set('x', 'gal', function() require 'align'.align_to_string(true, true, true) end,
    { noremap = true, silent = true, desc = 'Align to Lua pattern' }) -- Aligns to a Lua pattern, looking left and with previews


require("which-key").register({
    ["ga"] = { name = "+align", mode = "x" },
})
