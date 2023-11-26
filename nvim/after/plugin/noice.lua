require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true,         -- use a classic bottom cmdline for search
    command_palette = true,       -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false,       -- add a border to hover docs and signature help
  },
})
require("notify").setup({
  background_colour = "#000000",
})

vim.keymap.set("n", "<leader>nl", function()
  require("noice").cmd("last")
end, { desc = '[N]oice [L]ast' }
)

vim.keymap.set("n", "<leader>nh", function()
  require("noice").cmd("history")
end, { desc = '[N]oice [H]istory' }
)

vim.keymap.set("n", "<leader>nt", function()
  require("noice").cmd("telescope")
end, { desc = '[N]oice [T]elescope' }
)

vim.keymap.set("n", "<leader>ns", function()
  require("noice").cmd("stats")
end, { desc = '[N]oice [S]tats' }
)

vim.keymap.set("c", "<S-Enter>", function()
    require("noice").redirect(vim.fn.getcmdline)
end, { desc = "Redirect Cmdline" })

-- set up in cmp too:
vim.keymap.set({"n", "s"}, "<C-.>", function()
  if not require("noice.lsp").scroll(4) then
    return "<C-.>"
  end
end, { silent = true, expr = true })

vim.keymap.set({"n", "s"}, "<C-,>", function()
  if not require("noice.lsp").scroll(-4) then
    return "<C-,>"
  end
end, { silent = true, expr = true })

require("which-key").register({
  ["<leader>n"] = { name = "+noice" }
})
