-- telescope.lua

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '--follow',
      '--glob', '!.git',
      '--glob', '!Library/**',
      '--glob', '!Music/**',
      '--glob', '!Movies/**',
      '--glob', '!Applications/**',
      '--glob', '!Pictures/**',
      '--glob', '!.DS_Store',
      '--glob', '!.cache',
      '--glob', '!.sage',
      '--glob', '!.npm',
      '--glob', '!.conda',
      '--glob', '!.zsh',
      '--glob', '!**.aux',
      '--glob', '!**.fdb_latexmk',
      '--glob', '!**.gz',
      '--glob', '!.auctex-auto',
      '--glob', '!.dropbox',
      '--glob', '!.anaconda',
      '--glob', '!.emacs.d',
      '--glob', '!mason/**',
      '--glob', '!lazy/**',
    },
    mappings = {
      i = {
        ['<C-h>'] = "which_key",
      },
      n = {
        ['<esc>'] = require('telescope.actions').close,
        ['dd'] = require('telescope.actions').delete_buffer,
        ['<C-h>'] = "which_key",
      }
    },
  },
  pickers = {
    find_files = {
      -- cwd = '$HOME',
      find_command = {
        'fd',
        '--type', 'f',
        '--hidden',
        '--relative-path',
        '--follow',
        '--exclude', '.git',
        '--exclude', 'Library',
        '--exclude', 'Music',
        '--exclude', 'Movies',
        '--exclude', 'Applications',
        '--exclude', 'Pictures',
        '--exclude', '.DS_Store',
        '--exclude', '.cache',
        '--exclude', '.sage',
        '--exclude', '.npm',
        '--exclude', '.conda',
        '--exclude', '.zsh',
        '--exclude', '*.aux',
        '--exclude', '*.fdb_latexmk',
        '--exclude', '*.gz',
        '--exclude', '.auctex-auto',
        '--exclude', '.dropbox',
        '--exclude', '.anaconda',
        '--exclude', '.emacs.d',
        '--exclude', 'mason',
        '--exclude', 'lazy',
        -- '.', '$HOME',
      },
      -- follow = true,
      -- hidden = true,
    },
    live_grep = {
      -- cwd = '$HOME',
    },
    grep_string = {
      -- cwd = '$HOME',
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>,', require('telescope.builtin').buffers, { desc = '[,] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', function() require('telescope.builtin').find_files({ cwd = '$HOME' }) end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sp', require('telescope.builtin').find_files, { desc = '[S]earch Files [P]roject (cwd)' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', function() require('telescope.builtin').live_grep({ cwd = '$HOME' }) end, { desc = '[S]earch ~ by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').registers, { desc = '[S]earch [R]egisters' })
vim.keymap.set('n', '<leader>sc', require('telescope.builtin').commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader>so', require('telescope.builtin').vim_options, { desc = '[S]earch [O]ptions' })
vim.keymap.set('n', '<leader>sC', require('telescope.builtin').colorscheme, { desc = '[S]earch [C]olorscheme' })
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').builtin, { desc = '[S]earch [B]uiltin Commands' })

require("telescope").load_extension "file_browser"
-- open file_browser with the path of the current buffer
vim.api.nvim_set_keymap(
  "n",
  "<space>.",
  ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
  { noremap = true, desc = '[.] Telescope File Browser' }
)

require("which-key").register({
  ["<leader>s"] = { name = "+search" }
})
