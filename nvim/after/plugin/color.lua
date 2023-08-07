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

require("catppuccin").setup({
  flavour = "mocha",
  transparent_background = true,
  integrations = {
    neogit = true,
    which_key = true,
    lsp_trouble = true,
    gitsigns = true,
    notify = true,
  }
})


vim.keymap.set('n', '<leader>b', function()
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
end, { desc = '[B]ackground Transparent Toggle' })

