-- smartcolumn.lua

vim.keymap.set('n', '<leader>tc', function()
  local colopts = {"0","80"}
  local colorcol = vim.wo.colorcolumn
  for _, i in pairs(colopts) do
    if i ~= colorcol then
       vim.wo.colorcolumn = i
    end
  end
end, { desc = '[C]olor Column Toggle' })

vim.keymap.set('n', '<leader>cc', function()
  local colopts = { "0", "80", "100", "120" }
  vim.ui.select(colopts,
    { prompt = "Choose a color column width (0 = off)" },
    function(choice) vim.wo.colorcolumn = choice end)
end, { desc = 'Choose [C]olor [C]olumn' })
