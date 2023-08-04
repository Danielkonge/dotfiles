-- trouble.lua

vim.keymap.set("n", "<leader>xo", function() require("trouble").open() end, { desc = "Trouble [O]pen" })
vim.keymap.set("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end, { desc = "Trouble [W]orkspace Diagnostics" })
vim.keymap.set("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end, { desc = "Trouble [D]ocument Diagnostics" })
vim.keymap.set("n", "<leader>xq", function() require("trouble").open("quickfix") end, { desc = "Trouble [Q]uickfix" })
vim.keymap.set("n", "<leader>xl", function() require("trouble").open("loclist") end, { desc = "Trouble [L]oclist" })
vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end, { desc = "Trouble LSP [R]eference" })

require("which-key").register({
  ["<leader>x"] = { name = "+trouble" }
})
