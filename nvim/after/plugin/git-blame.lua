-- git-blame.lua

require('gitblame').setup({
    enabled = false,
    date_format = '%r',
    -- delay = 800,
    -- use_blame_commit_file_urls = true,
})

vim.keymap.set('n', '<leader>go', '<Cmd>GitBlameOpenCommitURL<CR>', { desc = '[G]it-blame [O]pen Commit' })
vim.keymap.set('n', '<leader>gf', '<Cmd>GitBlameOpenFileURL<CR>', { desc = '[G]it-blame [O]pen File' })
vim.keymap.set('n', '<leader>gb', '<Cmd>GitBlameToggle<CR>', { desc = '[G]it-blame Toggle' })
