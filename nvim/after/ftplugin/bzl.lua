-- setup bazel/starlark lsp
if vim.fn.executable('bzl') == 1 then
    vim.lsp.start({
        name = 'Bazel/Starlark Language Server',
        cmd = { 'bzl', 'lsp', 'serve' },
    })
end
