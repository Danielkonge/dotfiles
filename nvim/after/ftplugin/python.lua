-- setup extra formatting in python
vim.keymap.set('n', '<leader>b', function()
    vim.cmd.write()
    -- use black version from venv
    vim.cmd('silent !python -m black %')
end, { desc = 'Format buffer with Black' })

vim.keymap.set('n', '<leader>is', function()
    vim.cmd.write()
    vim.cmd('silent !isort %')
end, { desc = 'Format buffer with isort' })
