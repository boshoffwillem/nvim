local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")

if not status_ok then
    return
end

local servers = {
    "bashls",
    "clangd",
    "jsonls",
    "lemminx",
    "marksman",
    "omnisharp",
    "rust_analyzer",
    "sumneko_lua",
    "yamlls"
}

lsp_installer.setup({
    automatic_installation = true,
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")

if not lspconfig_status_ok then
    return
end

for _, server in pairs(servers) do
    local opts = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities
    }

    if server == "jsonls" then
        local server_opts = require "user.lsp.settings.jsonls"
        opts = vim.tbl_deep_extend("force", server_opts, opts)
    end

    if server == "omnisharp" then
        local server_opts = require "user.lsp.settings.omnisharp"
        opts = vim.tbl_deep_extend("force", server_opts, opts)
    end

    if server == "sumneko_lua" then
        local server_opts = require "user.lsp.settings.sumneko_lua"
        opts = vim.tbl_deep_extend("force", server_opts, opts)
    end

    if server == "yamlls" then
        local server_opts = require "user.lsp.settings.yamlls"
        opts = vim.tbl_deep_extend("force", server_opts, opts)
    end

    lspconfig[server].setup(opts)
end
