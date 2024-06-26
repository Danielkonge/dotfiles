return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    vim.keymap.set('n', '<leader><space>', require('harpoon.ui').toggle_quick_menu, { desc = '[ ] Harpoon Menu' })
    vim.keymap.set('n', '<leader>ha', require('harpoon.mark').add_file, { desc = '[A]dd Mark' })
    vim.keymap.set('n', '<leader>hr', require('harpoon.mark').rm_file, { desc = '[R]emove Mark' })
    vim.keymap.set('n', '<leader>hc', require('harpoon.mark').clear_all, { desc = '[C]lear Marks' })

    vim.keymap.set('n', '<leader>1', function() require('harpoon.ui').nav_file(1) end, { silent = true })
    vim.keymap.set('n', '<leader>2', function() require('harpoon.ui').nav_file(2) end, { silent = true })
    vim.keymap.set('n', '<leader>3', function() require('harpoon.ui').nav_file(3) end, { silent = true })
    vim.keymap.set('n', '<leader>4', function() require('harpoon.ui').nav_file(4) end, { silent = true })
    vim.keymap.set('n', '<leader>5', function() require('harpoon.ui').nav_file(5) end, { silent = true })
    vim.keymap.set('n', '<leader>6', function() require('harpoon.ui').nav_file(6) end, { silent = true })
    vim.keymap.set('n', '<leader>7', function() require('harpoon.ui').nav_file(7) end, { silent = true })
    vim.keymap.set('n', '<leader>8', function() require('harpoon.ui').nav_file(8) end, { silent = true })
    vim.keymap.set('n', '<leader>9', function() require('harpoon.ui').nav_file(9) end, { silent = true })
  end,
}
