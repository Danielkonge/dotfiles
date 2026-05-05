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
        local gitsigns = require("gitsigns")
        vim.keymap.set('n', '<leader>gP', gitsigns.preview_hunk, { desc = '[G]it [P]review Hunk' })
        vim.keymap.set('n', '<leader>gb', gitsigns.blame, { desc = '[G]it [B]lame Toggle' })
        vim.keymap.set('n', '<leader>gq', gitsigns.setqflist, { desc = '[G]it [B]lame Toggle' })
      end,
    },
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "ibhagwan/fzf-lua",
    },
    branch = 'master',
    config = function()
      local neogit = require("neogit")

      neogit.setup({
        disable_insert_on_commit = "auto",
        graph_style = "unicode",
        integrations = {
          diffview = true,
          fzf_lua = true,
        }
      })

      vim.keymap.set('n', '<leader>gg', neogit.open, { desc = 'Open Neo[G]it' })
      vim.keymap.set('n', '<leader>gC', neogit.close, { desc = '[C]lose Neo[G]it' })
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
    'akinsho/git-conflict.nvim',
    version = "*",
    config = function()
      require('git-conflict').setup({
        debug = false,
        default_mappings = false,    -- disable buffer local mapping created by this plugin
        default_commands = true,     -- disable commands created by this plugin
        disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
        list_opener = 'copen',       -- command or function to open the conflicts list
        highlights = {               -- They must have background color, otherwise the default color will be used
          incoming = 'DiffAdd',
          current = 'DiffText',
          ancestor = nil,
        },
      })

      vim.keymap.set('n', '<leader>gco', '<Cmd>GitConflictChooseOurs<CR>', {
        desc = '[G]it [C]onflict Choose [O]urs',
      })
      vim.keymap.set('n', '<leader>gct', '<Cmd>GitConflictChooseTheirs<CR>', {
        desc = '[G]it [C]onflict Choose [T]heirs',
      })
      vim.keymap.set('n', '<leader>gcb', '<Cmd>GitConflictChooseBoth<CR>', {
        desc = '[G]it [C]onflict Choose [B]oth',
      })
      vim.keymap.set('n', '<leader>gc0', '<Cmd>GitConflictChooseNone<CR>', {
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
}
