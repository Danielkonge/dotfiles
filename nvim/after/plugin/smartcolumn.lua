-- smartcolumn.lua

vim.keymap.set('n', '<leader>cc', function()
  local colopts = {"0","80"}
  local colorcol = vim.wo.colorcolumn
  for _, i in pairs(colopts) do
    if i ~= colorcol then
       vim.wo.colorcolumn = i
    end
  end
end, { desc = '[C]olor[C]olumn Toggle' })
