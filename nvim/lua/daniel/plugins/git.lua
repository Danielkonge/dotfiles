return {
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
        vim.keymap.set('n', '<leader>gsp', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gsn', require('gitsigns').next_hunk,
          { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>gP', require('gitsigns').preview_hunk,
          { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    branch = 'master',
    config = function()
      local neogit = require("neogit")

      neogit.setup({
        disable_insert_on_commit = "auto",
        graph_style = "unicode",
        telescope_sorter = function()
          return require("telescope").extensions.fzf.native_fzf_sorter()
        end,
        integrations = {
          telescope = true,
          diffview = true
        }
      })

      vim.keymap.set('n', '<leader>gg', neogit.open, { desc = 'Open Neo[G]it' })
      vim.keymap.set('n', '<leader>gc', neogit.close, { desc = '[C]lose Neo[G]it' })
      vim.keymap.set('n', '<leader>gr', neogit.refresh, { desc = 'Neo[G]it [R]efresh' })

      vim.keymap.set('n', '<leader>gdo', require("diffview").open, { desc = '[O]pen Diffview' })
      vim.keymap.set('n', '<leader>gdc', require("diffview").close, { desc = '[C]lose Diffview' })
      vim.keymap.set('n', '<leader>gdb', require("diffview").file_history, { desc = 'Diffview [B]ranch History' })
      vim.keymap.set('n', '<leader>gdf', '<Cmd>DiffviewFileHistory %<CR>',
        { silent = true, desc = 'Diffview [F]ile History' })
      vim.keymap.set('n', '<leader>gdt', '<Cmd>DiffviewToggleFiles<CR>',
        { silent = true, desc = 'Diffview [T]oggle Files' })
      vim.keymap.set('n', '<leader>gdr', require("diffview").update_colors, { desc = 'Diffview [R]efresh' })
    end,
  },

  {
    'f-person/git-blame.nvim',
    config = function()
      require('gitblame').setup({
        enabled = false,
        display_virtual_text = false,
        date_format = '%r',
        -- delay = 2000,
        schedule_event = "CursorHold",
        -- clear_event = "CursorMoved"
        -- use_blame_commit_file_urls = true,
      })

      vim.keymap.set('n', '<leader>go', '<Cmd>GitBlameOpenCommitURL<CR>', { desc = '[G]it Blame [O]pen Commit' })
      vim.keymap.set('n', '<leader>gf', '<Cmd>GitBlameOpenFileURL<CR>', { desc = '[G]it Blame Open [F]ile' })
      vim.keymap.set('n', '<leader>gb', '<Cmd>GitBlameToggle<CR>', { desc = '[G]it [B]lame Toggle' })
    end,
  },

  {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = function()
      require('git-conflict').setup({
        default_mappings = false,
      })

      vim.keymap.set('n', '<leader>gCo', '<Cmd>GitConflictChooseOurs<CR>', {
        desc = '[G]it [C]onflict Choose [O]urs',
      })
      vim.keymap.set('n', '<leader>gCt', '<Cmd>GitConflictChooseTheirs<CR>', {
        desc = '[G]it [C]onflict Choose [T]heirs',
      })
      vim.keymap.set('n', '<leader>gCb', '<Cmd>GitConflictChooseBoth<CR>', {
        desc = '[G]it [C]onflict Choose [B]oth',
      })
      vim.keymap.set('n', '<leader>gC0', '<Cmd>GitConflictChooseNone<CR>', {
        desc = '[G]it [C]onflict Choose None',
      })
      vim.keymap.set('n', '<leader>gn', '<Cmd>GitConflictNextConflict<CR>', {
        desc = '[G]it [C]onflict [N]ext',
      })
      vim.keymap.set('n', '<leader>gp', '<Cmd>GitConflictPrevConflict<CR>', {
        desc = '[G]it [C]onflict [P]rev',
      })
      vim.keymap.set('n', '<leader>gq', '<Cmd>GitConflictListQf<CR>', {
        desc = '[G]it [C]onflict [Q]uickfix List',
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'GitConflictDetected',
        callback = function()
          vim.notify('Conflict detected in ' .. vim.fn.expand('<afile>'))
        end
      })
    end,
  },

  -- This is interesting but not yet useful
  -- note: to use it, first brew install gh
  -- {
  --   'pwntester/octo.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-telescope/telescope.nvim',
  --     'nvim-tree/nvim-web-devicons',
  --   },
  --   config = function()
  --     require('octo').setup({
  --       suppress_missing_scope = {
  --         project_v2 = true,
  --       },
  --     })
  --
  --     -- vim.treesitter.language.register('markdown', 'octo')
  --   end,
  -- },
}
