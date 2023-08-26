-- lsp.lua

-- require('nvim-navic').setup({
--     lsp = {
--         auto_attach = true,
--     },
--     highlight = true,
-- })
--
-- local navic_on = false
-- local navic_toggle = function()
--     if navic_on then
--         require('lualine').setup({
--             winbar = {
--                 lualine_c = {}
--             },
--         })
--         navic_on = false
--     else
--         require('lualine').setup({
--             winbar = {
--                 lualine_c = {
--                     {
--                         "navic",
--                         -- Can be nil, "static" or "dynamic". This option is useful only when you have highlights enabled.
--                         -- Many colorschemes don't define same backgroud for nvim-navic as their lualine statusline backgroud.
--                         -- Setting it to "static" will perform a adjustment once when the component is being setup. This should
--                         --   be enough when the lualine section isn't changing colors based on the mode.
--                         -- Setting it to "dynamic" will keep updating the highlights according to the current modes colors for
--                         --   the current section.
--                         color_correction = nil,
--                         -- lua table with same format as setup's option. All options except "lsp" options take effect when set here.
--                         navic_opts = nil
--                     },
--                 }
--             },
--         })
--         navic_on = true
--     end
-- end

-- vim.keymap.set('n', '<leader>tn', navic_toggle, { desc = 'LSP: Start nvim-navic (breadcrumb display)' })

require("barbecue.ui").toggle(false)

vim.keymap.set('n', '<leader>lb', require("barbecue.ui").toggle, { desc = 'LSP: Toggle barbecue' })
vim.keymap.set('n', '<leader>tb', require("barbecue.ui").toggle, { desc = 'LSP: Toggle [B]arbecue' })
vim.keymap.set('n', '<leader>lp', function() require("barbecue.ui").navigate(-1) end, { desc = 'LSP: Barbecue previous' })
vim.keymap.set('n', '<leader>l1', function() require("barbecue.ui").navigate(1) end, { desc = 'LSP: Barbecue 1st entry' })
vim.keymap.set('n', '<leader>l2', function() require("barbecue.ui").navigate(2) end, { desc = 'LSP: Barbecue 2nd entry' })
vim.keymap.set('n', '<leader>l3', function() require("barbecue.ui").navigate(3) end, { desc = 'LSP: Barbecue 3rd entry' })
vim.keymap.set('n', '<leader>l4', function() require("barbecue.ui").navigate(4) end, { desc = 'LSP: Barbecue 4th entry' })

require('nvim-navbuddy').setup({
    lsp = {
        auto_attach = true,
    },
    mappings = {
        ["?"] = require("nvim-navbuddy.actions").help(),
    },
})

vim.keymap.set('n', '<leader>ll', require('nvim-navbuddy').open, { desc = 'LSP: Breadcrumb navigation' })

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

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('gt', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>sD', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    nmap('<leader>sW', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')


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
        vim.cmd({ cmd = 'write' })
        vim.cmd({ cmd = 'edit', args = { "%" } })
    end, '[F]ormat Buffer')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end
-- Diagnostic keymaps
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = 'Go to [P]revious diagnostic message' })
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = 'Go to [N]ext diagnostic message' })
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { desc = '[O]pen floating diagnostic message' })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open diagnostics [L]ist' })
vim.keymap.set('n', '<leader>d+', function() vim.diagnostic.show(nil, 0) end, { desc = 'Show diagnostics (buffer)' })
vim.keymap.set('n', '<leader>d-', function() vim.diagnostic.hide(nil, 0) end, { desc = 'Hide diagnostics (buffer)' })

vim.keymap.set('n',
    '<leader>=',
    'ggVG=<C-o>',
    -- The following two methods don't work for some reason
    -- 'gg=G<C-o>',
    -- function()
    --     local _, lnum, col, _, _ = unpack(vim.fn.getcursorcharpos())
    --     vim.cmd([[execute "normal gg=G"]])
    --     vim.fn.setcursorcharpos({ lnum, col })
    -- end,
    { silent = true, desc = 'Indent buffer' }
)

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
    -- clangd = {},
    -- gopls = {},
    pyright = {},
    rust_analyzer = {},
    texlab = {},
    -- tsserver = {},

    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

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
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
        }
    end,
}
