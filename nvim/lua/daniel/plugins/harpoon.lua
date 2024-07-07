return {
  "ThePrimeagen/harpoon",
  branch = 'harpoon2',
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local harpoon = require('harpoon')

    harpoon:setup()

    vim.keymap.set('n', '<leader><space>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list(), {
        title = '',
        title_pos = 'center',
        border = 'solid',
        ui_fallback_width = 80,
        ui_width_ratio = 0.5,
      })
    end, { desc = '[ ] Harpoon Menu' })
    vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end, { desc = '[H]arpoon: [A]dd to list' })
    vim.keymap.set('n', '<leader>hr', function() harpoon:list():remove() end, { desc = '[R]emove Mark' })
    vim.keymap.set('n', '<leader>hc', function() harpoon:list():clear() end, { desc = '[C]lear Marks' })

    vim.keymap.set('n', '<leader>1', function() harpoon:list():select(1) end, { silent = true })
    vim.keymap.set('n', '<leader>2', function() harpoon:list():select(2) end, { silent = true })
    vim.keymap.set('n', '<leader>3', function() harpoon:list():select(3) end, { silent = true })
    vim.keymap.set('n', '<leader>4', function() harpoon:list():select(4) end, { silent = true })
    vim.keymap.set('n', '<leader>5', function() harpoon:list():select(5) end, { silent = true })
    vim.keymap.set('n', '<leader>6', function() harpoon:list():select(6) end, { silent = true })
    vim.keymap.set('n', '<leader>7', function() harpoon:list():select(7) end, { silent = true })
    vim.keymap.set('n', '<leader>8', function() harpoon:list():select(8) end, { silent = true })
    vim.keymap.set('n', '<leader>9', function() harpoon:list():select(9) end, { silent = true })
  end,
}
