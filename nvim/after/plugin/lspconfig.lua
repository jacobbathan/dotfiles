local function config(_config)
    return vim.tbl_deep_extend("force", {
    on_attach = function()
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = 0} )
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = 0} )
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer = 0} )
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer = 0} ) -- ??
    vim.keymap.set("n", "<Leader>dk", vim.diagnostic.goto_prev, {buffer = 0} )
    vim.keymap.set("n", "<Leader>dj", vim.diagnostic.goto_next, {buffer = 0} )
    vim.keymap.set("n", "<Leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer = 0} )
    vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, {buffer = 0} )
    end,
    }, _config or {})
end


require'lspconfig'.gopls.setup{config()}
require'lspconfig'.tsserver.setup{config()}
require'lspconfig'.rust_analyzer.setup{config()}

