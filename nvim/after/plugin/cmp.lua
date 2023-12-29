-- cmp.lua
--
-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    -- setting keys
    ['<Down>'] = { i = cmp.mapping.select_next_item() },
    ['<Up>'] = { i = cmp.mapping.select_prev_item() },
    ['<C-n>'] = { i = cmp.mapping.select_next_item() },
    ['<C-p>'] = { i = cmp.mapping.select_prev_item() },
    ['<C-,>'] = { i = cmp.mapping.scroll_docs(-4) },
    ['<C-.>'] = { i = cmp.mapping.scroll_docs(4) },
    ['<C-x>'] = { i = cmp.mapping.complete() },
    ['<C-c>'] = { i = cmp.mapping.abort() },
    ['<CR>'] = { i = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })},
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = cmp.config.sources({
    -- NOTE: The order is important here.
    { name = 'nvim_lsp' },
    { name = 'luasnip', keyword_length = 2 },
    { name = 'buffer',  keyword_length = 2 },
    { name = 'path' },
  }),
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        path = "[path]",
        luasnip = "[snip]",
      },
      mode = 'symbol_text',
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      -- ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      -- before = function(entry, vim_item)
      --   -- ...
      --   return vim_item
      -- end
    })
  },
  experimental = {
    ghost_text = true,
  }
})

-- `/` cmdline setup.
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'buffer' }
  }, {
    { name = 'nvim_lsp_document_symbol' } -- this doesn't work for now
  })
})

-- `:` cmdline setup.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' }
      }
    }
  })
})
