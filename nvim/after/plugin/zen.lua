-- zen.lua

require('zen-mode').setup({
  plugins = {
    wezterm = {
      enabled = true,
      -- can be either an absolute font size or the number of incremental steps
      font = "+2", -- (10% increase per step)
    },
  }
})

vim.keymap.set('n', '<leader>tz', function()
  require('zen-mode').toggle()
end, { desc = '[Z]en Mode Toggle' })

