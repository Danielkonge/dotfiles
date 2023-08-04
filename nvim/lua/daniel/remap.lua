-- Remaps
-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- keymaps for moving marked text up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- stop highlights after search
vim.keymap.set('n', '<Esc><Esc>', vim.cmd.noh)

vim.keymap.set({ 'n', 'v' }, '<C-d>', '<C-d>zz')
vim.keymap.set({ 'n', 'v' }, '<C-u>', '<C-u>zz')

-- :Ex short cut
vim.keymap.set("n", "-", vim.cmd.Ex)

vim.keymap.set('n', '<leader>db', '<cmd>BufDel<cr>', { silent = true, nowait = true, noremap = true, desc = '[D]elete [B]uffer' })

-- Window movement
vim.keymap.set('n', '<c-h>', '<c-w>h', { silent = true })
vim.keymap.set('n', '<c-j>', '<c-w>j', { silent = true })
vim.keymap.set('n', '<c-k>', '<c-w>k', { silent = true })
vim.keymap.set('n', '<c-l>', '<c-w>l', { silent = true })

vim.keymap.set('n', '<leader><c-h>', '<c-w>H', { silent = true, desc = 'Move Window Left' })
vim.keymap.set('n', '<leader><c-j>', '<c-w>J', { silent = true, desc = 'Move Window Down' })
vim.keymap.set('n', '<leader><c-k>', '<c-w>K', { silent = true, desc = 'Move Window Up' })
vim.keymap.set('n', '<leader><c-l>', '<c-w>L', { silent = true, desc = 'Move Window Right' })

