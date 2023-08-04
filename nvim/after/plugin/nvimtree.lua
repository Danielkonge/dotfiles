-- nvimtree.lua

require("nvim-tree").setup()

vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>', { desc = 'Nvim-[T]ree Toggle' })

