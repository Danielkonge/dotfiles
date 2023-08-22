-- color.lua

require("onedark").setup({
  transparent = true,
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

vim.keymap.set('n', '<leader>to', require("onedark").toggle, { desc = '[O]nedark Theme Toggle' })

vim.keymap.set('n', '<leader>tb', function()
  local cur_theme = vim.g.colors_name
  if cur_theme == "onedark" then
    require('onedark').set_options(
      'transparent',
      not vim.g.onedark_config.transparent
    )
    require('onedark').load()
  elseif cur_theme == "catppuccin-mocha" then
    local transp = require("catppuccin").options.transparent_background
    require("catppuccin").default_options.transparent_background = not transp
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

