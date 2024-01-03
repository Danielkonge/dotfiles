
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local yank_highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = yank_highlight_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Remove spaces at end of line
local daniel_save_group = vim.api.nvim_create_augroup('DanielOnSave', { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = daniel_save_group,
  pattern = "*",
  callback = function()
    local _, lnum, col, _, _ = unpack(vim.fn.getcursorcharpos())
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setcursorcharpos({ lnum, col })
  end
  -- command = [[%s/\s\+$//e]],
})

-- Spell check in text filetypes
local daniel_filetype_group = vim.api.nvim_create_augroup('DanielFiletype', { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = daniel_filetype_group,
  pattern = { "gitcommit", "markdown", "tex", "latex" },
  callback = function()
    vim.opt_local.spell = true
  end
})
