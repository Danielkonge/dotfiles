return {
  "folke/zen-mode.nvim",
  config = function()
    local zen = require("zen-mode")
    zen.setup({
      plugins = {
        wezterm = {
          enabled = true,
          -- can be either an absolute font size or the number of incremental steps
          font = "+2", -- (10% increase per step)
        },
      }
    })

    vim.keymap.set('n', '<leader>tz', function()
      zen.toggle()
    end, { desc = '[Z]en Mode Toggle' })
  end,
}
