return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            inlay_hints = { enabled = false },
            diagnostics = {
                virtual_text = false,
                underline = true,
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = true,
                },
            },
            servers = {
                cssls = {
                    settings = {
                        css = {
                            lint = {
                                unknownAtRules = "ignore",
                            },
                        },
                    },
                },
            },
        },
    },
}
