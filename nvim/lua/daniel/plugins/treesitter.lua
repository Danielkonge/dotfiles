return {
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      "OXY2DEV/markview.nvim",  -- not actually a dependency, but this fixes install order
    },
    lazy = false,
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]]
      -- See `:help nvim-treesitter`
      require('nvim-treesitter.configs').setup {
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = {
          'c',
          'lua',
          'luadoc',
          'haskell',
          'python',
          'rust',
          'latex',
          'bibtex',
          'vimdoc',
          'vim',
          'query',
          'toml',
          'yaml',
          'regex',
          'bash',
          'markdown',
          'markdown_inline',
          'html',
          'css',
          'javascript',
        },
        sync_install = false,

        -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
        auto_install = true,

        ignore_install = {},
        modules = {},

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          disable = function(_lang, bufnr)
            return vim.api.nvim_buf_line_count(bufnr) > 10000
          end,
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<leader>Tv',
            node_incremental = '+',
            scope_incremental = '.',
            node_decremental = '-',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['aa'] = '@parameter.outer',
              ['ii'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          -- move = {
          --   enable = true,
          --   set_jumps = true, -- whether to set jumps in the jumplist
          -- },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>Ts'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>TS'] = '@parameter.inner',
            },
          },
        },
      }
    end
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    -- dir = "~/personal/nvim-plugins/nvim-treesitter-context",
    config = function()
      local tree_context = require('treesitter-context')
      tree_context.setup({
        enable = true,
        max_lines = 8,
        min_window_height = 15,
        line_numbers = true,
        multiline_threshold = 1,
        separator = nil,
        trim_scope = 'outer',
        mode = 'cursor',
      })
      -- vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { underline = true, sp = 'Grey' })
      -- vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', { link = 'CursorLineNr' })
      vim.api.nvim_set_hl(0, 'TreesitterContext', { link = 'None' })
      local line_nr = vim.api.nvim_get_hl(0, { name = 'LineNr' })
      vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom', { underline = true, sp = line_nr.fg })

      vim.keymap.set('n', '<leader>Tc', '<Cmd>TSContextToggle<CR>', { silent = true, desc = 'Toggle [C]ontext' })
      vim.keymap.set('n', '<leader>tC', '<Cmd>TSContextToggle<CR>',
        { silent = true, desc = 'Toggle [C]ontext (see <leader>Tc)' })
      vim.keymap.set("n", "[c", function()
        tree_context.go_to_context(vim.v.count1)
      end, { silent = true, desc = 'Jump to [C]ontext' })
      vim.keymap.set('n', '<leader>Tt', function()
        if tree_context.config.multiline_threshold == 1 then
          tree_context.config.update({
            max_lines = 30,
            multiline_threshold = 25,
          })
        else
          tree_context.config.update({
            max_lines = 8,
            multiline_threshold = 1,
          })
        end
      end, { desc = 'Toggle context length' })
    end
  },

  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup({
        use_default_keymaps = false,
        max_join_length = 120,
        dot_repeat = false,
      })

      vim.keymap.set('n', '<leader>m', require('treesj').toggle, { desc = '[M]erge toggle (split/join)' })
      vim.keymap.set('n', '<leader>M', function()
        require('treesj').toggle({ split = { recursive = true } })
      end, { desc = '[M]erge toggle (recursive split/join)' })
    end
  },
}
