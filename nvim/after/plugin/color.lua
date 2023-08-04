-- color.lua

require("onedark").setup({
  transparent = true,
  toggle_style_key = '<leader>ct',
  -- Lualine options --
  lualine = {
    transparent = true, -- lualine center bar transparency
  },
})
require('onedark').load()

vim.keymap.set('n', '<leader>b', function()
  local transp = vim.g.onedark_config.transparent
  require('onedark').setup({ transparent = not transp })
  require('onedark').load()
end, { desc = '[B]ackground Transparent Toggle' })

