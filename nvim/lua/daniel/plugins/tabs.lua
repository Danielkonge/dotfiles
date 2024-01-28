return {
  -- Detect tabstop and shiftwidth automatically
  { 'tpope/vim-sleuth' },

  {
    'abecodes/tabout.nvim',
    opts = {
      tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = '`', close = '`' },
        { open = '(', close = ')' },
        { open = '[', close = ']' },
        { open = '{', close = '}' },
        { open = '<', close = '>' },
      },
    }
  },
}
