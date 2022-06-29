local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if not status_cmp_ok then
    return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        virtual_text = false,
        signs = {
            active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })
end

local function lsp_keymaps()
    -- signature/documentation
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
    -- goto
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
    -- code actions
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { buffer = 0 })
    -- diagnostics
    vim.keymap.set("n", "<leader>ldb", require'telescope.builtin'.diagnostics, { buffer = 0 })
    vim.keymap.set("n", "<leader>ldn", vim.diagnostic.goto_next, { buffer = 0 })
    vim.keymap.set("n", "<leader>ldp", vim.diagnostic.goto_prev, { buffer = 0 })
    vim.keymap.set("n", "<leader>ldk", vim.diagnostic.open_float, { buffer = 0 })
    vim.keymap.set("n", "<leader>ldq", vim.diagnostic.setloclist, { buffer = 0 })
    -- refactoring
    vim.keymap.set("v", "<C-M-/>", vim.lsp.buf.formatting, { buffer = 0 })
    vim.keymap.set("n", "<leader>lrr", vim.lsp.buf.rename, { buffer = 0 })
    -- searching
    vim.keymap.set("n", "gsb", require'telescope.builtin'.lsp_document_symbols, { buffer = 0 })
    vim.keymap.set("n", "gsw", require'telescope.builtin'.lsp_dynamic_workspace_symbols, { buffer = 0 })
end

M.on_attach = function(client)
    if client.name == "sumneko_lua" then
        client.resolved_capabilities.document_formatting = false
    end

    lsp_keymaps()

    local status_ok, illuminate = pcall(require, "illuminate")

    if not status_ok then
        return
    end

    illuminate.on_attach(client)
end

return M
