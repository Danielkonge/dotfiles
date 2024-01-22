-- setup extra formatting in python
vim.keymap.set('n', '<leader>b', function()
    vim.cmd.write()
    vim.cmd('silent !black %')
end, { desc = 'Format buffer with Black' })

vim.keymap.set('n', '<leader>is', function()
    vim.cmd.write()
    vim.cmd('silent !isort %')
end, { desc = 'Format buffer with isort' })
