return {
  'saghen/blink.cmp',
  -- dir = "~/personal/nvim-plugins/blink.cmp",
  lazy = false, -- lazy loading handled internally
  -- optional: provides snippets for the snippet source
  dependencies = 'rafamadriz/friendly-snippets',

  -- use a release tag to download pre-built binaries
  -- version = 'v0.*',
  commit = 'db635f2',
  build = 'cargo build --release',
  -- OR build from source, requires nightly:
  -- https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- On musl libc based systems you need to add this flag
  -- build = 'RUSTFLAGS="-C target-feature=-crt-static" cargo build --release',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    highlight = {
      -- sets the fallback highlight groups to nvim-cmp's highlight groups
      -- useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release, assuming themes add support
      use_nvim_cmp_as_default = true,
    },
    -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- adjusts spacing to ensure icons are aligned
    nerd_font_variant = 'mono',
    keymap = {
      show = '<C-x>',
      hide = '<C-c>',
      accept = '<CR>',
      select_prev = { '<Up>', '<C-p>', '<S-Tab>' },
      select_next = { '<Down>', '<C-n>', '<Tab>' },

      show_documentation = '<C-m>',
      hide_documentation = '<C-m>',
      scroll_documentation_up = '<C-,>',
      scroll_documentation_down = '<C-.>',

      snippet_forward = '<Tab>',
      snippet_backward = '<S-Tab>',
    },
    documentation = {
      auto_show = true,
    },

    -- experimental auto-brackets support
    accept = { auto_brackets = { enabled = true } },

    -- experimental signature help support
    trigger = { signature_help = { enabled = true } },
    fuzzy = {
      keyword_range = 'full',
      prebuiltBinaries = {
        download = false,
      }
    }
  }
}
--   {
--   -- Autocompletion
--   'hrsh7th/nvim-cmp',
--   dependencies = {
--     -- Adds LSP completion capabilities
--     'neovim/nvim-lspconfig',
--     'hrsh7th/cmp-nvim-lsp',
--     -- Adds lsp document symbols
--     'hrsh7th/cmp-nvim-lsp-document-symbol',
--
--     -- Adds buffer completions
--     'hrsh7th/cmp-buffer',
--
--     -- Adds path completions
--     'hrsh7th/cmp-path',
--
--     -- Adds command line completions
--     'hrsh7th/cmp-cmdline',
--
--     -- Snippet Engine & its associated nvim-cmp source
--     {
--       'L3MON4D3/LuaSnip',
--       version = "v2.*",
--       build = "make install_jsregexp",
--     },
--
--     'saadparwaiz1/cmp_luasnip',
--
--     -- Adds a number of user-friendly snippets
--     'rafamadriz/friendly-snippets',
--
--     -- Adds pictograms
--     'onsails/lspkind.nvim',
--
--     -- git completions
--     { 'petertriho/cmp-git', dependencies = { 'nvim-lua/plenary.nvim' } }
--   },
--   config = function()
--     -- [[ Configure nvim-cmp ]]
--     -- See `:help cmp`
--     local cmp = require('cmp')
--     local luasnip = require('luasnip')
--     local lspkind = require('lspkind')
--     require('luasnip.loaders.from_vscode').lazy_load()
--     luasnip.config.setup({})
--     require('cmp_git').setup({})
--
--     cmp.setup({
--       snippet = {
--         expand = function(args)
--           luasnip.lsp_expand(args.body)
--         end,
--       },
--       mapping = {
--         -- setting keys
--         ['<Down>'] = { i = cmp.mapping.select_next_item() },
--         ['<Up>'] = { i = cmp.mapping.select_prev_item() },
--         ['<C-n>'] = { i = cmp.mapping.select_next_item() },
--         ['<C-p>'] = { i = cmp.mapping.select_prev_item() },
--         -- ['<C-,>'] = { i = cmp.mapping.scroll_docs(-4) },
--         -- ['<C-.>'] = { i = cmp.mapping.scroll_docs(4) },
--         ['<C-,>'] = cmp.mapping(function(_)
--           if cmp.visible() then
--             cmp.scroll_docs(-4)
--           end
--         end, { 'i' }),
--         ['<C-.>'] = cmp.mapping(function(_)
--           if cmp.visible() then
--             cmp.scroll_docs(4)
--           end
--         end, { 'i' }),
--         ['<C-x>'] = { i = cmp.mapping.complete() },
--         ['<C-c>'] = { i = cmp.mapping.abort() },
--         ['<CR>'] = {
--           i = cmp.mapping.confirm({
--             behavior = cmp.ConfirmBehavior.Replace,
--             select = true,
--           })
--         },
--         ['<Tab>'] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.select_next_item()
--           elseif luasnip.expand_or_locally_jumpable() then
--             luasnip.expand_or_jump()
--           else
--             fallback()
--           end
--         end, { 'i', 's' }),
--         ['<S-Tab>'] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.select_prev_item()
--           elseif luasnip.locally_jumpable(-1) then
--             luasnip.jump(-1)
--           else
--             fallback()
--           end
--         end, { 'i', 's' }),
--       },
--       sources = cmp.config.sources({
--         -- NOTE: The order is important here.
--         { name = 'nvim_lsp' },
--         { name = 'luasnip', keyword_length = 2 },
--         { name = 'buffer',  keyword_length = 3 },
--         { name = 'path' },
--         { name = 'git' },
--         { name = 'lazydev', group_index = 0, },
--       }),
--       formatting = {
--         format = lspkind.cmp_format({
--           with_text = true,
--           menu = {
--             buffer = "[buf]",
--             nvim_lsp = "[LSP]",
--             path = "[path]",
--             luasnip = "[snip]",
--           },
--           mode = 'symbol_text',
--           maxwidth = 80, -- prevent the popup from showing more than provided characters
--           -- (e.g 50 will not show more than 50 characters)
--           -- ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part
--           -- would show ellipsis_char instead (must define maxwidth first)
--
--           -- The function below will be called before any actual modifications from lspkind
--           -- so that you can provide more controls on popup customization.
--           -- (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
--           -- before = function(entry, vim_item)
--           --   -- ...
--           --   return vim_item
--           -- end
--         })
--       },
--       experimental = {
--         ghost_text = true,
--       },
--       performance = {
--         max_view_entries = 20,
--       },
--     })
--
--     -- `/` cmdline setup.
--     cmp.setup.cmdline({ '/', '?' }, {
--       mapping = cmp.mapping.preset.cmdline(),
--       sources = cmp.config.sources({
--         { name = 'buffer' }
--       }, {
--         { name = 'nvim_lsp_document_symbol' } -- this doesn't work for now
--       })
--     })
--
--     -- `:` cmdline setup.
--     cmp.setup.cmdline(':', {
--       mapping = cmp.mapping.preset.cmdline(),
--       sources = cmp.config.sources({
--         { name = 'path' }
--       }, {
--         {
--           name = 'cmdline',
--           option = {
--             ignore_cmds = { 'Man', '!' }
--           }
--         }
--       })
--     })
--   end,
-- }
