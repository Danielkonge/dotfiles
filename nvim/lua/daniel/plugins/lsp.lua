local servers = {
  "lua_ls",        -- lua
  "pylsp",         -- python
  "ty",            -- python
  "ruff",          -- python
  "rust_analyzer", -- rust
  "clangd",        -- c/c++
  "texlab",        -- latex
  "bashls",        -- bash
  "yamlls",        -- yaml
  "taplo",         -- toml
  "starpls",       -- starlark (bazel)
  "zls",           -- zig
}


-- local daniel_lsp = vim.api.nvim_create_augroup('DanielLsp', { clear = true })
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = daniel_lsp,
--   callback = function(event)
--     local buf = event.buf
--     -- local client = vim.lsp.get_client_by_id(event.data.client_id)
--     local daniel_lsp_buf = vim.api.nvim_create_augroup('DanielLsp_' .. buf, { clear = true })
--     vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
--       group = daniel_lsp_buf,
--       callback = function()
--         vim.lsp.buf.document_highlight()
--       end
--     })
--     vim.api.nvim_create_autocmd("CursorMoved", {
--       group = daniel_lsp_buf,
--       callback = function()
--         vim.lsp.buf.clear_references()
--       end
--     })
--   end
-- })


-- Find more lsp keymaps in fzf.lua
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "LSP: [R]e[N]ame" })
vim.keymap.set('n', '<leader>ih', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, { desc = "LSP: Toggle [I]nlay [H]ints" })
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = "LSP: Format current buffer" })

vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "LSP: Hover" })
vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, { desc = "LSP: Signature help" })
vim.keymap.set('n', 'gT', vim.lsp.buf.typehierarchy, { desc = "LSP: Type hierarchy" })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>dp', function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = 'Go to [P]revious diagnostic message' })
vim.keymap.set('n', '<leader>dn', function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = 'Go to [N]ext diagnostic message' })
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { desc = '[O]pen floating diagnostic message' })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open diagnostics [L]ist' })
vim.keymap.set('n', '<leader>d+', function()
  vim.diagnostic.show(nil, 0)
end, { desc = 'Show diagnostics (buffer)' })
vim.keymap.set('n', '<leader>d-', function()
  vim.diagnostic.hide(nil, 0)
end, { desc = 'Hide diagnostics (buffer)' })


return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_enable = {
          exclude = {
            "pylsp",
            "ty",
            "ruff",
          }
        }
      })

      vim.lsp.config("pylsp", {
        settings = {
          pylsp = {
            plugins = {
              jedi = {
                environment = "~/work/kosmos/.venv/bin/python",
              },
              jedi_completion = {
                fuzzy = true,
              },
              rope_autoimport = {
                enabled = false,
              },
              rope_completion = {
                enabled = false,
              },
              flake8 = {
                enabled = false,
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
        },
      })
      vim.lsp.enable("pylsp")

      vim.lsp.config("ruff", {
        init_options = {
          settings = {
            configuration = "~/work/kosmos/common/bazel/linting/ruff_config/drug_discovery_ruffconfig.toml",
            -- logLevel = "trace",
          }
        },
        -- capabilities = {
        --   hoverProvider = false,
        -- }
      })
      vim.lsp.enable("ruff")

      vim.lsp.config("ty", {
        cmd = { "/Users/daniel/personal/ruff/target/release/ty", "server" },
        settings = {
          ty = {
            experimental = {
              rename = true,
              autoImport = true,
            }
          }
        },
        -- init_options = {
        --   logLevel = "trace",
        -- },
        on_attach = function(client)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      })
      vim.lsp.enable("ty")
    end,
  },
  -- Useful status updates for LSP
  {
    'j-hui/fidget.nvim',
    opts = {},
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    'stevearc/aerial.nvim',
    opts = {
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
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




-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
-- local util = require('lspconfig.util')
-- local on_attach = function(_, bufnr)
-- NOTE: Remember that lua is a real programming language, and as such it is possible
-- to define small helper and utility functions so you don't have to repeat yourself
-- many times.
--
-- In this case, we create a function that lets us more easily define mappings specific
-- for LSP related items. It sets the mode, buffer and description for us each time.
-- local nmap = function(keys, func, desc)
--   if desc then
--     desc = 'LSP: ' .. desc
--   end
--
--   vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
-- end

-- nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
-- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

-- local builtin = require('telescope.builtin')
-- nmap('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
-- nmap('gr', builtin.lsp_references, '[G]oto [R]eferences')
-- nmap('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
-- nmap('gt', builtin.lsp_type_definitions, 'Type [D]efinition')
-- nmap('<leader>sD', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
-- nmap('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
-- nmap('<leader>sW', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

-- nmap('<leader>ih', function()
--   vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
-- end, 'Toggle [I]nlay [H]ints')
-- nmap('<leader>ti', function()
--   vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
-- end, 'Toggle [I]nlay Hints')

-- See `:help K` for why this keymap
-- nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
-- nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

-- Lesser used LSP functionality
-- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
-- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
-- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
-- nmap('<leader>wl', function()
--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- end, '[W]orkspace [L]ist Folders')

-- nmap('<leader>f', function()
--   vim.lsp.buf.format()
--   -- add fix so rainbow-delimiters highlighting works with format
--   vim.cmd.write()
--   vim.cmd.edit()
-- end, '[F]ormat Buffer')

-- Create a command `:Format` local to the LSP buffer
-- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--   vim.lsp.buf.format()
-- end, { desc = 'Format current buffer with LSP' })
-- end

-- local pyright_attach = function(client, _bufnr)
--   client.server_capabilities.declarationProvider = nil
--   client.server_capabilities.definitionProvider = nil
--   client.server_capabilities.documentHighlightProvider = nil
--   client.server_capabilities.documentSymbolProvider = nil
--   client.server_capabilities.executeCommandProvider = nil
--   client.server_capabilities.hoverProvider = nil
--   client.server_capabilities.referencesProvider = nil
--   client.server_capabilities.renameProvider = nil
--   -- client.server_capabilities.signatureHelpProvider = nil
--   client.server_capabilities.typeDefinitionProvider = nil
--   client.server_capabilities.codeActionProvider = nil
--
--   client.server_capabilities.completionProvider.resolveProvider = false
-- end

-- local ruff_attach = function(client, _bufnr)
--   client.server_capabilities.declarationProvider = nil
--   client.server_capabilities.definitionProvider = nil
--   client.server_capabilities.documentHighlightProvider = nil
--   client.server_capabilities.documentSymbolProvider = nil
--   client.server_capabilities.executeCommandProvider = nil
--   client.server_capabilities.hoverProvider = nil
--   client.server_capabilities.referencesProvider = nil
--   client.server_capabilities.renameProvider = nil
--   client.server_capabilities.signatureHelpProvider = nil
--   client.server_capabilities.typeDefinitionProvider = nil
--   client.server_capabilities.codeActionProvider = nil
-- end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
-- local servers = {
--   lua_ls = true,
--   pylsp = true,         -- python
--   pyright = true,       -- python
--   rust_analyzer = true, -- rust
--   clangd = true,        -- c/c++
--   texlab = true,        -- latex
--   bashls = true,        -- bash
--   yamlls = true,        -- yaml
--   taplo = true,         -- toml
--   starpls = true,       -- starlark (bazel)  -- manually install!
--   -- bzl = true,        -- starlark (bazel) [old setup in ftplugin]
--   -- gopls = true,
--   -- tsserver = true,
-- }
--
-- return {
--   {
--     -- LSP Configuration & Plugins
--     'neovim/nvim-lspconfig',
--     dependencies = {
--       -- Automatically install LSPs to stdpath for neovim
--       { 'williamboman/mason.nvim', config = true },
--       'williamboman/mason-lspconfig.nvim',
--
--       -- Useful functionality
--       -- 'hrsh7th/cmp-nvim-lsp',
--       'saghen/blink.cmp',
--       'nvim-telescope/telescope.nvim',
--
--       -- Useful status updates for LSP
--       {
--         'j-hui/fidget.nvim',
--         opts = {},
--       },
--
--       -- Additional lua configuration, makes nvim stuff amazing!
--       -- { 'folke/neodev.nvim',       commit = '3941036e3da9b0dc09244036d20c590b6d752175' },
--       {
--         'folke/lazydev.nvim',
--         ft = 'lua',
--         opts = {
--           library = {
--             -- See the configuration section for more details
--             -- Load luvit types when the `vim.uv` word is found
--             { path = "luvit-meta/library", words = { "vim%.uv" } },
--           },
--         },
--       },
--       { "Bilal2453/luvit-meta",    lazy = true }, -- optional `vim.uv` typings
--     },
--     config = function()
--       -- Diagnostic keymaps
--       vim.keymap.set('n', '<leader>dp', function() vim.diagnostic.jump({ count = -1, float = true }) end,
--         { desc = 'Go to [P]revious diagnostic message' })
--       vim.keymap.set('n', '<leader>dn', function() vim.diagnostic.jump({ count = 1, float = true }) end,
--         { desc = 'Go to [N]ext diagnostic message' })
--       vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { desc = '[O]pen floating diagnostic message' })
--       vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open diagnostics [L]ist' })
--       vim.keymap.set('n', '<leader>d+', function() vim.diagnostic.show(nil, 0) end,
--         { desc = 'Show diagnostics (buffer)' })
--       vim.keymap.set('n', '<leader>d-', function() vim.diagnostic.hide(nil, 0) end,
--         { desc = 'Hide diagnostics (buffer)' })
--
--       vim.keymap.set('n',
--         '<leader>=',
--         'ggVG=<C-o>',
--         -- The following two methods don't work for some reason (some plugin)
--         -- 'gg=G<C-o>',
--         -- function()
--         --     local _, lnum, col, _, _ = unpack(vim.fn.getcursorcharpos())
--         --     vim.cmd([[execute "normal gg=G"]])
--         --     vim.fn.setcursorcharpos({ lnum, col })
--         -- end,
--         { silent = true, desc = 'Indent buffer' }
--       )
--
--       vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
--
--       -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
--       -- local capabilities = vim.lsp.protocol.make_client_capabilities()
--       -- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--       -- capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
--
--       -- Ensure the servers above are installed
--       local mason_lspconfig = require 'mason-lspconfig'
--
--       mason_lspconfig.setup {
--         ensure_installed = vim.tbl_keys(servers),
--       }
--       -- local pylsp_capabilities = vim.lsp.protocol.make_client_capabilities()
--       -- pylsp_capabilities.textDocument.hover.dynamicRegistration = false
--
--       local lspconfig = require('lspconfig')
--
--       lspconfig.lua_ls.setup({
--         capabilities = require('blink.cmp').get_lsp_capabilities(lspconfig.lua_ls.capabilities),
--         inlay_hint = { enabled = true },
--         on_attach = on_attach,
--         settings = {
--           Lua = {
--             workspace = { checkThirdParty = false },
--             telemetry = { enable = false },
--             hint = { enable = true },
--             diagnostics = {
--               unusedLocalExclude = { "_*" },
--             },
--           }
--         },
--       })
--
--       lspconfig.pylsp.setup({
--         capabilities = require('blink.cmp').get_lsp_capabilities(lspconfig.pylsp.capabilities),
--         inlay_hint = { enabled = true },
--         on_attach = on_attach,
--         settings = {
--           pylsp = {
--             -- Run
--             -- :PylspInstall pylsp-mypy python-lsp-ruff python-lsp-black
--             -- to use the following
--             plugins = {
--               black = {
--                 enabled = true,
--                 line_length = 120,
--               },
--               pylsp_mypy = {
--                 enabled = false,
--                 live_mode = false,
--                 dmypy = true,
--                 strict = true,
--                 report_progress = true,
--                 -- overrides = {
--                 --     "--check-untyped-defs",
--                 --     "--warn-unused-ignores",
--                 --     "--warn-return-any",
--                 --     "--warn-unreachable",
--                 --     "--strict-equality",
--                 --     "--extra-checks",
--                 --     "--show-error-context",
--                 --     "--pretty",
--                 --     true,
--                 -- },
--               },
--               ruff = {
--                 enabled = true,
--                 lineLength = 120,
--                 extendSelect = { "I" },
--                 formatEnabled = true,
--                 -- format = nil,
--               },
--               jedi_completion = {
--                 enabled = true, -- true,
--                 fuzzy = true,   -- true,
--               },
--               -- jedi_definition = {
--               --   enabled = false,
--               -- },
--               -- jedi_hover = {
--               --   enabled = false,
--               -- },
--               -- jedi_references = {
--               --   enabled = false,
--               -- },
--               -- jedi_signature_help = {
--               --   enabled = false,
--               -- },
--               -- jedi_symbols = {
--               --   enabled = false,
--               -- },
--               rope_autoimport = {
--                 enabled = false, -- setting this to true messes with code completion
--               },
--               rope_completion = {
--                 enabled = false,
--               },
--               flake8 = {
--                 enabled = false,
--                 maxLineLength = 120,
--               },
--               mccabe = {
--                 enabled = false,
--               },
--               pycodestyle = {
--                 enabled = false,
--               },
--               pyflakes = {
--                 enabled = false,
--               },
--               pylint = {
--                 enabled = false,
--               },
--               autopep8 = {
--                 enabled = false,
--               },
--               yapf = {
--                 enabled = false,
--               },
--             }
--           }
--         },
--       })
--
--       -- lspconfig.ruff.setup({
--       --   -- capabilities = capabilities,
--       --   on_attach = ruff_attach,
--       --   -- init_options = {
--       --   --   settings = {
--       --   --     organizeImports = true,
--       --   --   }
--       --   -- },
--       -- })
--
--       -- lspconfig.pyright.setup({
--       --   capabilities = require('blink.cmp').get_lsp_capabilities(lspconfig.pyright.capabilities),
--       --   inlay_hint = { enabled = false },
--       --   on_attach = pyright_attach,
--       --   -- settings = {
--       --   --   python = {
--       --   --     analysis = {
--       --   --       typeCheckingMode = 'strict',
--       --   --     }
--       --   --   }
--       --   -- },
--       -- })
--
--       -- lspconfig.basedpyright.setup({
--       --   capabilities = capabilities,
--       --   inlay_hint = { enabled = true },
--       --   on_attach = on_attach,
--       -- })
--
--       local cwd = vim.fn.getcwd()
--       local kosmos = '/Users/daniel/work/kosmos'
--       local is_in_kosmos = string.sub(cwd, 1, #kosmos) == kosmos
--
--       lspconfig.rust_analyzer.setup({
--         capabilities = require('blink.cmp').get_lsp_capabilities(lspconfig.rust_analyzer.capabilities),
--         inlay_hint = { enabled = true },
--         on_attach = on_attach,
--         settings = is_in_kosmos and {
--           ['rust-analyzer'] = {
--             check = {
--               overrideCommand = {
--                 'bazel',
--                 'build',
--                 '--config=rust_analyzer',
--                 '//zircon/...',
--               }
--             },
--             -- server = {
--             --   extraEnv = {
--             --     RUSTUP_TOOLCHAIN = "nightly",
--             --   }
--             -- }
--           }
--         } or nil
--       })
--
--       lspconfig.clangd.setup({
--         capabilities = require('blink.cmp').get_lsp_capabilities(lspconfig.clangd.capabilities),
--         inlay_hint = { enabled = true },
--         on_attach = on_attach,
--       })
--
--       lspconfig.texlab.setup({
--         capabilities = require('blink.cmp').get_lsp_capabilities(lspconfig.texlab.capabilities),
--         inlay_hint = { enabled = true },
--         on_attach = on_attach,
--       })
--
--       lspconfig.bashls.setup({
--         capabilities = require('blink.cmp').get_lsp_capabilities(lspconfig.bashls.capabilities),
--         inlay_hint = { enabled = true },
--         on_attach = on_attach,
--       })
--
--       lspconfig.yamlls.setup({
--         capabilities = require('blink.cmp').get_lsp_capabilities(lspconfig.yamlls.capabilities),
--         inlay_hint = { enabled = true },
--         on_attach = on_attach,
--       })
--
--       lspconfig.taplo.setup({
--         capabilities = require('blink.cmp').get_lsp_capabilities(lspconfig.taplo.capabilities),
--         inlay_hint = { enabled = true },
--         on_attach = on_attach,
--       })
--
--       lspconfig.starpls.setup({
--         capabilities = require('blink.cmp').get_lsp_capabilities(lspconfig.starpls.capabilities),
--         inlay_hint = { enabled = true },
--         on_attach = on_attach,
--       })
--
--       -- local configs = require("lspconfig.configs")
--       -- if not configs.sith_lsp then
--       --   local root_files = {
--       --     "pyproject.toml",
--       --     "requirements.txt",
--       --     "Pipfile",
--       --     "pyrightconfig.json",
--       --     ".git",
--       --   }
--       --   configs.sith_lsp = {
--       --     default_config = {
--       --       cmd = { "/Users/daniel/personal/nvim-plugins/sith-language-server/target/release/sith-lsp" },
--       --       root_dir = function(fname)
--       --         return lspconfig.util.root_pattern(unpack(root_files))(fname)
--       --       end,
--       --       single_file_support = true,
--       --       filetypes = { "python" },
--       --       init_options = {
--       --         settings = {
--       --           -- Settings for the server goes here.
--       --           -- Config example
--       --           -- sith = {
--       --           -- },
--       --           logLevel = 'trace',
--       --           logFile = '/Users/daniel/Desktop/sith_lsp.log',
--       --
--       --           ruff = {
--       --             lint = {
--       --               enable = true
--       --             }
--       --           }
--       --       }
--       --       },
--       --     },
--       --   }
--       -- end
--       --
--       -- lspconfig.sith_lsp.setup({
--       --   capabilities = require('blink.cmp').get_lsp_capabilities(lspconfig.sith_lsp.capabilities),
--       --   inlay_hint = { enabled = true },
--       --   on_attach = on_attach,
--       -- })
--
--       -- mason_lspconfig.setup_handlers {
--       --   function(server_name)
--       --     require('lspconfig')[server_name].setup {
--       --       capabilities = capabilities,
--       --       inlay_hint = { enabled = true },
--       --       on_attach = server_name ~= 'pyright' and on_attach or pyright_attach,
--       --       settings = servers[server_name],
--       --       filetypes = (servers[server_name] or {}).filetypes,
--       --       root_dir = (server_name == 'pylsp' or server_name == 'pyright') and function(fname)
--       --         return util.find_git_ancestor(fname)
--       --       end or nil,
--       --     }
--       --   end,
--       -- }
--
--
--       -- rust workaround
--       -- for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
--       --     local default_diagnostic_handler = vim.lsp.handlers[method]
--       --     vim.lsp.handlers[method] = function(err, result, context, config)
--       --         if err ~= nil and err.code == -32802 then
--       --             return
--       --         end
--       --         return default_diagnostic_handler(err, result, context, config)
--       --     end
--       -- end
--     end
--   },
--
--   {
--     'stevearc/aerial.nvim',
--     opts = {
--       on_attach = function(bufnr)
--         -- Jump forwards/backwards with '{' and '}'
--         vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
--         vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
--       end,
--     },
--     -- Optional dependencies
--     dependencies = {
--       "nvim-treesitter/nvim-treesitter",
--       "nvim-tree/nvim-web-devicons"
--     },
--   },
-- }
