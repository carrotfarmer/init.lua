require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "ts_ls",
        "rust_analyzer",
        "eslint",
    },
    automatic_enable = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<C-i>", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
end

for _, server in ipairs({
    "lua_ls",
    "ts_ls",
    "rust_analyzer",
    "eslint",
}) do
    vim.lsp.config(server, {
        capabilities = capabilities,
        on_attach = on_attach,
    })
end
