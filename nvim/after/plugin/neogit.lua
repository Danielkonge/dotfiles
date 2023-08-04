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
vim.keymap.set('n', '<leader>gr', neogit.close, { desc = 'Neo[G]it [R]efresh' })
