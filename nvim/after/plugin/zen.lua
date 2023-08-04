-- zen.lua

vim.keymap.set('n', '<leader>z', function()
  require('zen-mode').toggle()
  local transp = vim.g.onedark_config.transparent
  require('onedark').setup({ transparent = not transp })
  require('onedark').load()
end, { desc = '[Z]en Mode Toggle' })

