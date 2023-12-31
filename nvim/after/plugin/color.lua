-- color.lua

require("onedark").setup({
  transparent = true,
  style = "deep",
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
    -- navic = {
    --   enabled = true,
    --   custom_bg = "NONE",
    -- },
    -- barbecue = {
    --   dim_dirname = true, -- directory name is dimmed by default
    --   bold_basename = true,
    --   dim_context = false,
    --   alt_background = false,
    -- },
  }
})

require("material").setup({
  lualine_style = 'default',
  disable = {
    background = true,
  },
  plugins = { -- Uncomment the plugins that you use to highlight them
    -- Available plugins:
    -- "dap",
    -- "dashboard",
    "gitsigns",
    -- "hop",
    "indent-blankline",
    -- "lspsaga",
    -- "mini",
    "neogit",
    -- "neorg",
    "nvim-cmp",
    "nvim-navic",
    "nvim-tree",
    "nvim-web-devicons",
    -- "sneak",
    "telescope",
    "trouble",
    "which-key",
  },
})

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

require('tokyonight').setup({
  style = 'night',
  transparent = true,
  dim_inactive = true,
})


vim.keymap.set('n', '<leader>to', require("onedark").toggle, { desc = '[O]nedark Theme Toggle' })

