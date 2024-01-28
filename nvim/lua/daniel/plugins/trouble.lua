return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local trouble = require("trouble")

    vim.keymap.set("n", "<leader>xo", function() trouble.open() end, { desc = "Trouble [O]pen" })
    vim.keymap.set("n", "<leader>xw", function() trouble.open("workspace_diagnostics") end,
      { desc = "Trouble [W]orkspace Diagnostics" })
    vim.keymap.set("n", "<leader>xd", function() trouble.open("document_diagnostics") end,
      { desc = "Trouble [D]ocument Diagnostics" })
    vim.keymap.set("n", "<leader>xq", function() trouble.open("quickfix") end, { desc = "Trouble [Q]uickfix" })
    vim.keymap.set("n", "<leader>xl", function() trouble.open("loclist") end, { desc = "Trouble [L]oclist" })
    vim.keymap.set("n", "gR", function() trouble.open("lsp_references") end,
      { desc = "Trouble LSP [R]eference" })
  end,
}
