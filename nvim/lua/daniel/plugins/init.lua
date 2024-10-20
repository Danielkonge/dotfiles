return {
  { "folke/lazy.nvim", version = "*" },
  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    -- opts = {},
    dependencies = {
      { 'echasnovski/mini.icons', version = '*' },
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local which_key = require('which-key')
      which_key.setup({})
      which_key.add({
        { "<leader>g", group = "git" },
        { "<leader>gC", group = "git-conflict" },
        { "<leader>gs", group = "git-signs" },
        { "<leader>gd", group = "diffview" },
        { "<leader>d", group = "diagnostics" },
        { "<leader>t", group = "toggle" },
        { "<leader>w", group = "workspace" },
        { "<leader>G", group = "generate" },
        { "<leader>n", group = "noice" },
        { "<leader>x", group = "trouble" },
        { "ga", group = "align", mode = "x" },
        { "<leader>z", group = "spell" },
        { "<leader>T", group = "treesitter" },
        { "<leader>h", group = "harpoon" },
        { "<leader>c", group = "choose/code" },
        { "<leader>s", group = "search" },
        { "<leader>sC", group = "color" },
        { "<leader>sG", group = "grep" },
        { "<leader>#", group = "Navigate to Harpoon file at #" },
        { "<leader>1", hidden = true },
        { "<leader>2", hidden = true },
        { "<leader>3", hidden = true },
        { "<leader>4", hidden = true },
        { "<leader>5", hidden = true },
        { "<leader>6", hidden = true },
        { "<leader>7", hidden = true },
        { "<leader>8", hidden = true },
        { "<leader>9", hidden = true },
        { "<esc>", hidden = true },
        -- ["<leader>l"] = { name = "+lsp" },
      })
    end,
  },
}
-- error in current_indent above
