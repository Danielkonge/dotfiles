require('treesj').setup({
    use_default_keymaps = false,
    max_join_length = 120,
    dot_repeat = false,
})

vim.keymap.set('n', '<leader>m', require('treesj').toggle, { desc = '[M]erge toggle (split/join)' })
vim.keymap.set('n', '<leader>M', function()
    require('treesj').toggle({ split = { recursive = true } })
end, { desc = '[M]erge toggle (recursive split/join)' })
