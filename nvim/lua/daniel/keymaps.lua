-- Remaps
-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- keymaps for moving marked text up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move marked text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move marked text up" })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- stop highlights after search
vim.keymap.set('n', '<Esc><Esc>', vim.cmd.noh)

vim.keymap.set({ 'n', 'v' }, '<C-d>', '<C-d>zz', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-u>', '<C-u>zz', { silent = true })

vim.keymap.set('i', '<C-a>', '<Esc>I', { silent = true })
vim.keymap.set('i', '<C-e>', '<Esc>A', { silent = true })
vim.keymap.set('i', '<C-u>', '<Esc>O', { silent = true })
vim.keymap.set('i', '<C-d>', '<Esc>o', { silent = true })
vim.keymap.set('i', '<C-z>', '<Esc>zza', { silent = true })

-- :Ex short cut (use oil instead)
-- vim.keymap.set("n", "-", vim.cmd.Ex)

vim.keymap.set('n', '<leader>wS', function() print(vim.fn.getcwd()) end, { desc = 'Show CWD (≈ workspace)' })

vim.keymap.set('n', [[<leader>"]], vim.cmd.split, { desc = 'Horizontal split window' })
vim.keymap.set('n', [[<leader>%]], vim.cmd.vsplit, { desc = 'Vertical split window' })

-- Window movement
vim.keymap.set('n', '<c-h>', '<c-w>h', { silent = true })
vim.keymap.set('n', '<c-j>', '<c-w>j', { silent = true })
vim.keymap.set('n', '<c-k>', '<c-w>k', { silent = true })
vim.keymap.set('n', '<c-l>', '<c-w>l', { silent = true })

-- Insert mode movement
vim.keymap.set('i', '<c-h>', '<Left>', { silent = true })
vim.keymap.set('i', '<c-j>', '<Down>', { silent = true })
vim.keymap.set('i', '<c-k>', '<Up>', { silent = true })
vim.keymap.set('i', '<c-l>', '<Right>', { silent = true })

-- better indenting
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

-- Spelling
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
