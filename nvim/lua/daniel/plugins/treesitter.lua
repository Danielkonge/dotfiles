return {
  {
    -- Highlight, edit, and navigate code
    "romus204/tree-sitter-manager.nvim",
    dependencies = {
      "OXY2DEV/markview.nvim", -- not actually a dependency, but this fixes install order
    },
    config = function()
      require('tree-sitter-manager').setup({
        ensure_installed = {
          'c',
          'lua',
          'luadoc',
          'haskell',
          'python',
          'rust',
          'latex',
          'bibtex',
          "csv",
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
          "cmake",
          "cpp",
          "cuda",
          "diff",
          "dockerfile",
          "fish",
          "fortran",
          "json",
          "make",
          "sql",
          "ssh_config",
          "starlark",
          "tsv",
          "zig",
        },
        auto_install = true,
        highlight = true,
      })

      -- work around since treesitter manager doesn't handle this yet
      vim.treesitter.language.register('starlark', { 'bzl' })
      vim.treesitter.language.register('bash', { 'sh' })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'bzl', 'sh' },
        callback = function() vim.treesitter.start() end,
      })
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
    dependencies = { "romus204/tree-sitter-manager.nvim", },
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
