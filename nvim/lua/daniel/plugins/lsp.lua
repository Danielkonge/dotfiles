-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('gt', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>sD', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  nmap('<leader>sW', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  nmap('<leader>ih', function()
    vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled(0))
  end, 'Toggle [I]nlay [H]ints')
  nmap('<leader>ti', function()
    vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled(0))
  end, 'Toggle [I]nlay Hints')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  nmap('<leader>f', function()
    vim.lsp.buf.format()
    -- add fix so rainbow-delimiters highlighting works with format
    vim.cmd.write()
    vim.cmd.edit()
  end, '[F]ormat Buffer')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  clangd = {},   -- c/c++
  -- gopls = {},
  -- pyright = {},       -- python
  pylsp = {
    pylsp = {
      -- Run
      -- :PylspInstall pylsp-mypy python-lsp-ruff python-lsp-black
      -- to use the following
      plugins = {
        black = {
          enabled = true,
          line_length = 120,
        },
        pylsp_mypy = {
          enabled = true,
          live_mode = false,
          dmypy = true,
          strict = true,
          report_progress = true,
          -- overrides = {
          --     "--check-untyped-defs",
          --     "--warn-unused-ignores",
          --     "--warn-return-any",
          --     "--warn-unreachable",
          --     "--strict-equality",
          --     "--extra-checks",
          --     "--show-error-context",
          --     "--pretty",
          --     true,
          -- },
        },
        ruff = {
          enabled = true,
          lineLength = 120,
          extendSelect = { "I" },
          format = nil,           -- need this for black formatting to work
        },
        jedi_completion = {
          enabled = true,
          fuzzy = true,
        },
        rope_autoimport = {
          enabled = false,           -- setting this to true messes with code completion
        },
        rope_completion = {
          enabled = false,
        },
        flake8 = {
          enabled = false,
          maxLineLength = 120,
        },
        mccabe = {
          enabled = false,
        },
        pycodestyle = {
          enabled = false,
        },
        pyflakes = {
          enabled = false,
        },
        pylint = {
          enabled = false,
        },
        autopep8 = {
          enabled = false,
        },
        yapf = {
          enabled = false,
        },
      }
    }
  },                    -- python
  rust_analyzer = {},   -- rust
  texlab = {},          -- latex
  -- tsserver = {},
  bashls = {},          -- bash
  yamlls = {},          -- yaml
  taplo = {},           -- toml
  -- bzl = {}, -- starlark (bazel) [setup in ftplugin]
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      hint = { enable = true },
      diagnostics = {
        unusedLocalExclude = { "_*" },
      },
    },
  },   -- lua
}

return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful functionality
      'hrsh7th/cmp-nvim-lsp',
      'nvim-telescope/telescope.nvim',

      -- Useful status updates for LSP
      {
        'j-hui/fidget.nvim',
        -- tag = 'legacy',
        -- event = 'LspAttach',
        opts = {},
      },

      -- Additional lua configuration, makes nvim stuff amazing!
      { 'folke/neodev.nvim',       commit = '3941036e3da9b0dc09244036d20c590b6d752175' },
    },
    config = function()
      -- Diagnostic keymaps
      vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = 'Go to [P]revious diagnostic message' })
      vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = 'Go to [N]ext diagnostic message' })
      vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { desc = '[O]pen floating diagnostic message' })
      vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open diagnostics [L]ist' })
      vim.keymap.set('n', '<leader>d+', function() vim.diagnostic.show(nil, 0) end,
        { desc = 'Show diagnostics (buffer)' })
      vim.keymap.set('n', '<leader>d-', function() vim.diagnostic.hide(nil, 0) end,
        { desc = 'Hide diagnostics (buffer)' })

      vim.keymap.set('n',
        '<leader>=',
        'ggVG=<C-o>',
        -- The following two methods don't work for some reason (some plugin)
        -- 'gg=G<C-o>',
        -- function()
        --     local _, lnum, col, _, _ = unpack(vim.fn.getcursorcharpos())
        --     vim.cmd([[execute "normal gg=G"]])
        --     vim.fn.setcursorcharpos({ lnum, col })
        -- end,
        { silent = true, desc = 'Indent buffer' }
      )

      vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")


      -- Setup neovim lua configuration
      require('neodev').setup({
        -- add options here
      })

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            inlay_hint = { enabled = true },
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end,
      }
    end
  },

  {
    'stevearc/aerial.nvim',
    opts = {
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
    },
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },
}
