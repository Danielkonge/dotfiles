return {
  -- Undotree
  'mbbill/undotree',
  config = function()
    -- toggle undo tree
    vim.keymap.set('n', '<leader>tu', vim.cmd.UndotreeToggle, { desc = '[U]ndo Tree Toggle' })
  end,
}
