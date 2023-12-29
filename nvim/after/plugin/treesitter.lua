-- treesitter.lua

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = {
    'c',
    'lua',
    'luadoc',
    'haskell',
    'python',
    'rust',
    'latex',
    'bibtex',
    'vimdoc',
    'vim',
    'query',
    'toml',
    'yaml',
    'regex',
    'bash',
    'markdown',
    'markdown_inline',
    'html',
    'css',
    'javascript',
  },
  sync_install = false,

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = true,

  ignore_install = {},
  modules = {},

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<leader>Tv',
      node_incremental = '+',
      scope_incremental = '.',
      node_decremental = '-',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ii'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    -- move = {
    --   enable = true,
    --   set_jumps = true, -- whether to set jumps in the jumplist
    -- },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>Ts'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>TS'] = '@parameter.inner',
      },
    },
  },
}

require("treesitter-context").setup({
  enable = false,
  max_lines = 16,
  min_window_height = 10,
  multiline_threshold = 8,
})

vim.keymap.set('n', '<leader>Tc', '<Cmd>TSContextToggle<CR>', { silent = true, desc = 'Toggle [C]ontext' })
vim.keymap.set('n', '<leader>tC', '<Cmd>TSContextToggle<CR>', { silent = true, desc = 'Toggle [C]ontext' })
vim.keymap.set("n", "[c", function()
  require("treesitter-context").go_to_context()
end, { silent = true, desc = 'Jump to [C]ontext' })

require("which-key").register({
  ["<leader>T"] = { name = "+treesitter" },
})
