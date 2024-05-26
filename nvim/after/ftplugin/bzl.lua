-- setup bazel/starlark lsp

-- local util = require('lspconfig.util')

-- for now bzl is better than starlark
-- if vim.fn.executable('bzl') == 1 then
--     vim.lsp.start({
--         name = 'Bazel/Starlark Language Server',
--         cmd = { 'bzl', 'lsp', 'serve' },
--         -- root_dir = util.root_pattern('WORKSPACE', 'WORKSPACE.bazel'),
--         -- util.find_git_ancestor(vim.loop.cwd()) -- root_dir is not helpful since a lot of features are pay-walled
--     })
-- end


-- Install with: cargo install starlark_bin
-- if vim.fn.executable('starlark') == 1 then
--     vim.lsp.start({
--         name = 'Bazel/Starlark Language Server',
--         cmd = { 'starlark', '--lsp' },
--         root_dir = util.find_git_ancestor(vim.loop.cwd()),
--     })
-- end
