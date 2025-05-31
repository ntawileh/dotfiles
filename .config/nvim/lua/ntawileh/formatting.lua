local conform = require("conform")

conform.setup({
    formatters = {
        biome = {
            require_cwd = true,
        },
        prettier = {
            require_cwd = true,
        },
    },
    formatters_by_ft = {
        javascript = { "prettier", "biome" },
        typescript = { "prettier", "biome" },
        javascriptreact = { "prettier", "biome" },
        typescriptreact = { "prettier", "biome" },
        astro = { "prettier", "biome" },
        svelte = { "prettier" },
        css = { "prettier", "biome" },
        html = { "prettier" },
        json = { "prettier", "biome" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
    },
    format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    },
})
