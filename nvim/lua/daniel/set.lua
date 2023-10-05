-- set.lua

-- [[ Setting options ]]
-- See `:help vim.o`

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- netrw settings
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- add relative line numbers
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Start with smartcolumn off
vim.wo.colorcolumn = "0"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'
vim.opt.shortmess:append('c')
vim.opt.pumblend = 1

vim.opt.splitright = true -- Prefer windows splitting to the right
vim.opt.splitbelow = true -- Prefer windows splitting to the bottom

vim.opt.inccommand = 'split'

-- vim.opt.formatoptions = vim.opt.formatoptions
--     - "a" -- Auto formatting is BAD.
--     - "t" -- Don't auto format my code. I got linters for that.
--     + "c" -- In general, I like it when comments respect textwidth
--     + "q" -- Allow formatting comments w/ gq
--     - "o" -- O and o, don't continue comments
--     + "r" -- But do continue when pressing enter.
--     + "n" -- Indent past the formatlistpat, not underneath it.
--     + "j" -- Auto-remove comments if possible.
--     - "2" -- I'm not in gradeschool anymore

-- The above doesn't work for now, so here is a workaround:
local daniel_format = vim.api.nvim_create_augroup('DanielFormat', { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
	group = daniel_format,
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions
		- "a" -- Auto formatting is BAD.
		- "t" -- Don't auto format my code. I got linters for that.
		+ "c" -- In general, I like it when comments respect textwidth
		+ "q" -- Allow formatting comments w/ gq
		- "o" -- O and o, don't continue comments
		+ "r" -- But do continue when pressing enter.
		+ "n" -- Indent past the formatlistpat, not underneath it.
		+ "j" -- Auto-remove comments if possible.
		- "2" -- I'm not in gradeschool anymore
	end
})

vim.opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.incsearch = true

-- smart indentation on new lines
vim.opt.smartindent = true
vim.opt.autoindent = true

-- highlight current line's line number with another color
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.opt.spell = false
vim.opt.spelllang = { 'en_us' }
