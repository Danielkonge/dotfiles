return {
  -- Theme inspired by Atom
  -- 'navarasu/onedark.nvim',
  dir = "~/personal/nvim-plugins/onedark.nvim",
  priority = 1000,
  lazy = false,
  -- config = function()
  --   vim.cmd.colorscheme 'onedark'
  -- end,
  config = function()
    require("onedark").setup({
      transparent = true,
      -- style = "deep",
      ending_tildes = true,
      -- Lualine options --
      lualine = {
        transparent = true, -- lualine center bar transparency
      },
      diagnostics = {
        darker = true,
        undercurl = true,
        background = false,
      },
    })

    require('onedark').load()
  end,
}
