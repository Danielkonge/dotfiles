-- personal init.lua

require("daniel.set")
require("daniel.remap")

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugin
  --'tpope/vim-fugitive',
  --'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      {
        'j-hui/fidget.nvim',
        -- tag = 'legacy',
        -- event = 'LspAttach',
        opts = {},
      },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',

      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim"
        },
        -- opts = {
        --   -- options are set in lsp.lua
        -- }
      },
    },
  },

  -- {
  --   "utilyre/barbecue.nvim",
  --   name = "barbecue",
  --   version = "*",
  --   dependencies = {
  --     "SmiteshP/nvim-navic",
  --     "nvim-tree/nvim-web-devicons", -- optional dependency
  --   },
  --   opts = {
  --     -- configurations go here
  --   },
  -- },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',

      -- Adds command line completions
      'hrsh7th/cmp-cmdline',

      -- Adds buffer completions
      'hrsh7th/cmp-buffer',

      -- Adds path completions
      'hrsh7th/cmp-path',

      -- Adds pictograms
      'onsails/lspkind.nvim',

      -- Adds lsp document symbols
      'hrsh7th/cmp-nvim-lsp-document-symbol'
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',       opts = {} },

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>gP', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },


  -- THEMES
  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme 'onedark'
    -- end,
  },
  { "catppuccin/nvim",            name = "catppuccin", priority = 1000 },
  { "EdenEast/nightfox.nvim" },
  { 'marko-cerovac/material.nvim' },
  { "rebelot/kanagawa.nvim" },
  { "folke/tokyonight.nvim" },


  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    -- opts = {
    --   --
    -- },
  },


  { dir = "~/personal/nvim-plugins/indent-blankline.nvim", main = "ibl",     branch = "current_indent_final" },
  -- {
  --   -- Add indentation guides even on blank lines
  --   'lukas-reineke/indent-blankline.nvim',
  --   main = "ibl",
  --   -- Enable `lukas-reineke/indent-blankline.nvim`
  --   -- See `:help indent_blankline.txt`
  --   -- opts = {
  --   --   char = '┊',
  --   --   -- show_trailing_blankline_indent = false,
  --   -- },
  -- },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',                               opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim',                       branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  { 'nvim-telescope/telescope-ui-select.nvim' },

  { 'debugloop/telescope-undo.nvim' },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-context',
    },
    build = ':TSUpdate',
  },

  -- { dir = "~/personal/nvim-plugins/nvim-treesitter-context", branch = "testing" },

  {
    -- Undotree
    'mbbill/undotree'
  },

  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      colorcolumn = "0",
      disabled_filetypes = {
        "help",
        "text",
        "markdown",
        "tex", "latex",
        "netrw", "lazy", "mason",
        "conf",
        "log",
        "NeogitCommitMessage", "NeogitStatus", "NeogitPopup", "NeogitGitCommandHistory",
        "startup", "checkhealth",
      },
    }
  },

  {
    "folke/zen-mode.nvim",
    -- opts = {
    --   -- options
    -- }
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---type Flash.Config
    opts = {
      modes = {
        search = { enabled = false }
      }
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      -- {
      --   "R",
      --   mode = "o", -- operator pending mode (e.g., d.., y..)
      --   function()
      --     require("flash").remote()
      --   end,
      --   desc = "Remote Flash",
      -- },
      {
        "r",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Flash Treesitter Search",
      },
      -- {
      --   "<c-s>",
      --   mode = { "c" }, -- command mode (used when searching with "/")
      --   function()
      --     require("flash").toggle()
      --   end,
      --   desc = "Toggle Flash Search",
      -- },
    },
  },

  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   dependencies = {
  --     'nvim-tree/nvim-web-devicons',
  --   },
  -- },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },

  -- { dir = "~/personal/nvim-plugins/rainbow-delimiters.nvim" },
  {
    "hiphish/rainbow-delimiters.nvim"
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  {
    {
      "NeogitOrg/neogit",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim"
      },
      config = true
    },
  },

  {
    {
      "ThePrimeagen/harpoon",
      dependencies = {
        "nvim-lua/plenary.nvim",
      }
    },
  },

  {
    {
      "startup-nvim/startup.nvim",
      dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim"
      }
    }
  },

  {
    'Vonr/align.nvim',
  },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {
      break_undo = false,
    } -- this is equalent to setup({}) function
  },

  {
    'Aasim-A/scrollEOF.nvim',
    opts = {
      insert_mode = true,
    }
  },

  {
    'abecodes/tabout.nvim',
    opts = {
      tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = '`', close = '`' },
        { open = '(', close = ')' },
        { open = '[', close = ']' },
        { open = '{', close = '}' },
        { open = '<', close = '>' },
      },
    }
  },
}, {})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local daniel_save_group = vim.api.nvim_create_augroup('DanielOnSave', { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = daniel_save_group,
  pattern = "*",
  callback = function()
    local _, lnum, col, _, _ = unpack(vim.fn.getcursorcharpos())
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setcursorcharpos({ lnum, col })
  end
  -- command = [[%s/\s\+$//e]],
})


require("which-key").register({
  ["<leader>g"] = { name = "+git" },
  ["<leader>gd"] = { name = "+diffview" },
  ["<leader>d"] = { name = "+diagnostics" },
  ["<leader>t"] = { name = "+toggle" },
  ["<leader>w"] = { name = "+workspace" },
  ["<leader>l"] = { name = "+lsp" },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
