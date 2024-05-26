return {
  { "folke/lazy.nvim", version = "*" },
  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    -- opts = {},
    config = function()
      local which_key = require('which-key')
      which_key.setup({})
      which_key.register({
        ["<leader>g"] = { name = "+git" },
        ["<leader>gC"] = { name = "+git-conflict" },
        ["<leader>gd"] = { name = "+diffview" },
        ["<leader>d"] = { name = "+diagnostics" },
        ["<leader>t"] = { name = "+toggle" },
        ["<leader>w"] = { name = "+workspace" },
        ["<leader>G"] = { name = "+generate" },
        ["<leader>n"] = { name = "+noice" },
        ["<leader>x"] = { name = "+trouble" },
        ["ga"] = { name = "+align", mode = "x" },
        ["<leader>z"] = { name = "+spell" },
        ["<leader>T"] = { name = "+treesitter" },
        ["<leader>h"] = { name = "+harpoon" },
        ["<leader>c"] = { name = "+choose/code" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>sC"] = { name = "+color" },
        ["<leader>sG"] = { name = "+grep" },
        ["<leader>"] = {
          ["1"] = "which_key_ignore",
          ["2"] = "which_key_ignore",
          ["3"] = "which_key_ignore",
          ["4"] = "which_key_ignore",
          ["5"] = "which_key_ignore",
          ["6"] = "which_key_ignore",
          ["7"] = "which_key_ignore",
          ["8"] = "which_key_ignore",
          ["9"] = "which_key_ignore",
          ["#"] = "Navigate to Harpoon file #",
        },
        -- ["<leader>l"] = { name = "+lsp" },
      })
    end,
  },
}
-- error in current_indent above
