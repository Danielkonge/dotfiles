
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
