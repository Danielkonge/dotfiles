-- zen.lua

vim.keymap.set('n', '<leader>tz', function()
  require('zen-mode').toggle()
  local cur_theme = vim.g.colors_name
  local transp = true
  if cur_theme == "onedark" then
    transp = vim.g.onedark_config.transparent
    require('onedark').setup({ transparent = not transp })
    require('onedark').load()
  elseif cur_theme == "catppuccin-mocha" then
    transp = require("catppuccin").options.transparent_background
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = not transp,
      integrations = {
        neogit = true,
        which_key = true,
        lsp_trouble = true,
        gitsigns = true,
        notify = true,
      }
    })
    require("catppuccin").load()
  else
    print("Error: Not onedark or catppuccin-mocha.")
  end
end, { desc = '[Z]en Mode Toggle' })

