return {
  -- THEMES
  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    lazy = false,
    -- config = function()
    --   vim.cmd.colorscheme 'onedark'
    -- end,
    config = function()
      require("onedark").setup({
        transparent = true,
        style = "deep",
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

      vim.keymap.set('n', '<leader>to', require("onedark").toggle, { desc = '[O]nedark Theme Toggle' })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    config = function()
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
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = true,
    config = function()
      require('nightfox').setup({
        options = {
          transparent = true, -- Disable setting background
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          }
        },
      })
    end,
  },
  {
    'marko-cerovac/material.nvim',
    lazy = true,
    config = function()
      require("material").setup({
        lualine_style = 'default',
        disable = {
          background = true,
        },
        plugins = { -- Uncomment the plugins that you use to highlight them
          -- "dap",
          "gitsigns",
          "indent-blankline",
          "neogit",
          "nvim-cmp",
          "nvim-navic",
          "nvim-tree",
          "nvim-web-devicons",
          "telescope",
          "trouble",
          "which-key",
        },
      })
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
    config = function()
      require('kanagawa').setup({
        -- compile = false,          -- enable compiling the colorscheme
        transparent = true, -- do not set background color
        theme = "wave",     -- Load "wave" theme when 'background' option is not set
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none"
              }
            }
          }
        },
      })
    end,
  },
  {
    'folke/tokyonight.nvim',
    config = function()
      require('tokyonight').setup({
        style = 'night',
        transparent = true,
        dim_inactive = true,
      })
    end,
  },
}
