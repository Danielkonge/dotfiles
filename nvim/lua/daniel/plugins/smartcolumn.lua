vim.keymap.set('n', '<leader>cc', function()
  local colopts = { "0", "80", "100", "120" }
  vim.ui.select(colopts,
    { prompt = "Choose a color column width (0 = off)" },
    function(choice) vim.wo.colorcolumn = choice end)
end, { desc = 'Choose [C]olor [C]olumn' })

return {
  "m4xshen/smartcolumn.nvim",
  opts = {
    colorcolumn = "120",
    disabled_filetypes = {
      "help",
      "text",
      "markdown",
      "tex", "latex",
      "netrw", "lazy", "mason", "oil",
      "conf",
      "log",
      "NeogitCommitMessage", "NeogitStatus", "NeogitPopup", "NeogitGitCommandHistory",
      "startup", "checkhealth",
    },
  },
}
