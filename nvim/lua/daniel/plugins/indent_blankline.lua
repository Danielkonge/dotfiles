local highlight = {
  "RainbowDelimiterRed",
  "RainbowDelimiterYellow",
  "RainbowDelimiterBlue",
  "RainbowDelimiterOrange",
  "RainbowDelimiterGreen",
  "RainbowDelimiterViolet",
  "RainbowDelimiterCyan",
}

return {
  -- Add indentation guides even on blank lines
  -- 'lukas-reineke/indent-blankline.nvim',
  dir = "~/personal/nvim-plugins/indent-blankline.nvim",
  branch = "current_indent_final",
  main = "ibl",
  config = function()
    local hooks = require "ibl.hooks"

    hooks.register(
      hooks.type.SCOPE_HIGHLIGHT,
      hooks.builtin.scope_highlight_from_extmark
    )

    local ibl = require("ibl")

    ibl.setup({
      indent = { char = '┊', highlight = "LineNr" }, -- LineNr is the standard hl, but some themes overwrite it
      debounce = 200,
      scope = {
        highlight = highlight,
        show_exact_scope = true,
      },
      viewport_buffer = { min = 5, max = 10, },
      current_indent = {
        enabled = true,
        highlight = "CursorLineNr",
        show_start = false,
        show_end = false,
      },
    })
  end,

  -- dir = "~/personal/nvim-plugins/scope-indent-guides.nvim",
  -- config = function()
  --   require('scope-indent-guides').setup()
  -- end

  -- dir = "~/personal/nvim-plugins/indentmini.nvim",
  -- config = function()
  --   require('indentmini').setup()
  -- end
}
