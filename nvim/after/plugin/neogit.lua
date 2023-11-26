local neogit = require("neogit")

neogit.setup({
  disable_insert_on_commit = "auto",
  integrations = {
    telescope = true,
    diffview = true
  }
})

vim.keymap.set('n', '<leader>gg', neogit.open, { desc = 'Open Neo[G]it' })
vim.keymap.set('n', '<leader>gc', neogit.close, { desc = '[C]lose Neo[G]it' })
vim.keymap.set('n', '<leader>gr', neogit.refresh, { desc = 'Neo[G]it [R]efresh' })

vim.keymap.set('n', '<leader>gdo', require("diffview").open, { desc = '[O]pen Diffview' })
vim.keymap.set('n', '<leader>gdc', require("diffview").close, { desc = '[C]lose Diffview' })
vim.keymap.set('n', '<leader>gdb', require("diffview").file_history, { desc = 'Diffview [B]ranch History' })
vim.keymap.set('n', '<leader>gdf', ':DiffviewFileHistory %<CR>', { silent = true, desc = 'Diffview [F]ile History' })
vim.keymap.set('n', '<leader>gdt', ':DiffviewToggleFiles<CR>', { silent = true, desc = 'Diffview [T]oggle Files' })
vim.keymap.set('n', '<leader>gdr', require("diffview").update_colors, { desc = 'Diffview [R]efresh' })
