-- spell.lua 

vim.keymap.set('n', '<leader>ze', function()
  vim.opt.spell = true
  vim.opt.spelllang = { 'en_us' }
end, { desc = '[E]nglish (US) Spell Check' })

vim.keymap.set('n', '<leader>zd', function()
  vim.opt.spell = true
  vim.opt.spelllang = { 'da' }
end, { desc = '[D]anish Spell Check' })

vim.keymap.set('n', '<leader>zt', function()
  vim.opt.spell = not ( vim.opt.spell:get() )
end, { desc = '[T]oggle Spell Check' })

vim.keymap.set('n', '<leader>ts', function()
  vim.opt.spell = not ( vim.opt.spell:get()  )
end, { desc = 'Toggle [S]pell Check' })

require("which-key").register({
  ["<leader>z"] = { name = "+spell" }
})
