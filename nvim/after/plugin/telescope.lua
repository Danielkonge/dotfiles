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
      -- '--multiline',
      -- '--multiline-dotall',
      -- '--glob', '!.git',
      -- '--glob', '!Library/**',
      -- '--glob', '!Music/**',
      -- '--glob', '!Movies/**',
      -- '--glob', '!Applications/**',
      -- '--glob', '!Pictures/**',
      -- '--glob', '!.DS_Store',
      -- '--glob', '!.cache',
      -- '--glob', '!.sage',
      -- '--glob', '!.npm',
      -- '--glob', '!.conda',
      -- '--glob', '!.zsh',
      -- '--glob', '!**.aux',
      -- '--glob', '!**.fdb_latexmk',
      -- '--glob', '!**.gz',
      -- '--glob', '!.auctex-auto',
      -- '--glob', '!.dropbox',
      -- '--glob', '!.anaconda',
      -- '--glob', '!.emacs.d',
      -- '--glob', '!mason/**',
      -- '--glob', '!lazy/**',
    },
    mappings = {
      i = {
        ['<C-h>'] = "which_key",
        ['<esc><esc>'] = require('telescope.actions').close,
        -- this is also covered below, but this is a bit quicker
      },
      n = {
        ['<esc><esc>'] = require('telescope.actions').close,
        ['<esc>'] = require('telescope.actions').close, -- both of these should close telescope
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
        -- '--exclude', '.git',
        -- '--exclude', 'Library',
        -- '--exclude', 'Music',
        -- '--exclude', 'Movies',
        -- '--exclude', 'Applications',
        -- '--exclude', 'Pictures',
        -- '--exclude', '.DS_Store',
        -- '--exclude', '.cache',
        -- '--exclude', '.sage',
        -- '--exclude', '.npm',
        -- '--exclude', '.conda',
        -- '--exclude', '.zsh',
        -- '--exclude', '*.aux',
        -- '--exclude', '*.fdb_latexmk',
        -- '--exclude', '*.gz',
        -- '--exclude', '.auctex-auto',
        -- '--exclude', '.dropbox',
        -- '--exclude', '.anaconda',
        -- '--exclude', '.emacs.d',
        -- '--exclude', 'mason',
        -- '--exclude', 'lazy',
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
  extensions = {
    ["ui-select"] = {
      -- opts
    },
    undo = {
      -- opts
      use_delta = true,
      mappings = {
        i = {
          ["<CR>"] = require("telescope-undo.actions").yank_additions,
          ["<S-CR>"] = require("telescope-undo.actions").yank_deletions,
          ["<C-CR>"] = require("telescope-undo.actions").restore,
        },
        n = {
          ["<CR>"] = require("telescope-undo.actions").yank_additions,
          ["<S-CR>"] = require("telescope-undo.actions").yank_deletions,
          ["<C-CR>"] = require("telescope-undo.actions").restore,
        },
      },
    },
    file_browser = {
      hidden = { file_browser = true, folder_browser = true, },
    }
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
-- Enable telescope ui select
pcall(require("telescope").load_extension, "ui-select")
-- Enable telescope undo
pcall(require('telescope').load_extension, "undo")

vim.keymap.set('n', '<leader>su', require('telescope').extensions.undo.undo, { desc = '[S]earch [U]ndo' })

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>,', require('telescope.builtin').buffers, { desc = '[,] Find existing buffers' })
-- vim.keymap.set('n', '<leader>/', function()
--   -- You can pass additional configuration to telescope to change theme, layout, etc.
--   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--     winblend = 10,
--     previewer = true,
--   })
-- end, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>s/', function()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files'
  }
end, { desc = '[/] [S]earch in open buffers' })

vim.keymap.set('n', '<leader>sp', require('telescope.builtin').git_files, { desc = 'Search Files Git [P]roject' })
vim.keymap.set('n', '<leader>sF', function() require('telescope.builtin').find_files({ cwd = '$HOME' }) end,
  { desc = '[S]earch [F]iles (home)' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles (cwd)' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', function() require('telescope.builtin').live_grep({ cwd = '$HOME' }) end,
  { desc = '[S]earch ~ by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>ds', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').registers, { desc = '[S]earch [R]egisters' })
vim.keymap.set('n', '<leader>sc', require('telescope.builtin').commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader>so', require('telescope.builtin').vim_options, { desc = '[S]earch [O]ptions' })
vim.keymap.set('n', '<leader>sCs', require('telescope.builtin').colorscheme, { desc = '[S]earch [C]olorschemes' })
vim.keymap.set('n', '<leader>sCh', require('telescope.builtin').highlights, { desc = '[S]earch Highlights' })
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').builtin, { desc = '[S]earch [B]uiltin Commands' })
vim.keymap.set('n', '<leader>sH', require('telescope.builtin').command_history, { desc = '[S]earch Command [H]istory'})
vim.keymap.set('n', '<leader>sq', require('telescope.builtin').quickfix, { desc = '[S]earch [Q]uickfix List'})
vim.keymap.set('n', '<leader>sl', require('telescope.builtin').loclist, { desc = '[S]earch [L]ocation List'})
vim.keymap.set('n', '<leader>sj', require('telescope.builtin').jumplist, { desc = '[S]earch [J]ump List'})
vim.keymap.set('n', '<leader>sv', require('telescope.builtin').vim_options, { desc = '[S]earch [V]im Options'})
vim.keymap.set('n', '<leader>sa', require('telescope.builtin').autocommands, { desc = '[S]earch Vim [A]utocommands'})

require("telescope").load_extension "file_browser"
-- open file_browser with the path of the current buffer
vim.api.nvim_set_keymap(
  "n",
  "<space>.",
  "<Cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
  { noremap = true, silent = true, desc = '[.] Telescope File Browser' }
)

require("which-key").register({
  ["<leader>s"] = { name = "+search" },
  ["<leader>sC"] = { name = "+color" }
})
