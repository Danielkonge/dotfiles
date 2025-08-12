vim.keymap.set('n', '<leader>e', function()
  vim.cmd.write()
  vim.cmd.edit()
end, { desc = 'Reload file' })

return {
  "HiPhish/rainbow-delimiters.nvim",
  -- dir = "~/personal/nvim-plugins/rainbow-delimiters.nvim",
  config = function()
    -- This module contains a number of default definitions
    local rainbow_delimiters = require 'rainbow-delimiters'

    ---@type rainbow_delimiters.config
    vim.g.rainbow_delimiters = {
      strategy = {
        [''] = function(bufnr)
          local large_file = vim.api.nvim_buf_line_count(bufnr) > 50000
          return (not large_file) and rainbow_delimiters.strategy['global'] or nil
        end,
        -- vim = rainbow_delimiters.strategy['local'],
        -- c = rainbow_delimiters.strategy['local'],
      },
      query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
        -- python = 'rainbow-blocks',
        query = function(bufnr)
          -- Use blocks for `:InspectTree`
          local is_inspecttree = vim.b[bufnr].dev_base ~= nil
          return is_inspecttree and 'rainbow-blocks' or 'rainbow-delimiters'
        end,
        -- latex = 'rainbow-blocks',
      },
      priority = {
        [''] = 110,
        lua = 210,
        -- python = 210,
      },
      highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
      },
    }
  end,
}
