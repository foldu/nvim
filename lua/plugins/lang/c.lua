-- stolen from lazyvim
return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                clangd = {
                    opts = {
                        servers = {
                            -- Ensure mason installs the server
                            clangd = {
                                keys = {
                                    {
                                        "<leader>ch",
                                        "<cmd>ClangdSwitchSourceHeader<cr>",
                                        desc = "Switch Source/Header (C/C++)",
                                    },
                                },
                                root_dir = function(bufnr, ondir)
                                    local root_directory = function(fname)
                                        return require("lspconfig.util").root_pattern(
                                            "Makefile",
                                            "configure.ac",
                                            "configure.in",
                                            "config.h.in",
                                            "meson.build",
                                            "meson_options.txt",
                                            "build.ninja"
                                        )(fname) or require("lspconfig.util").root_pattern(
                                            "compile_commands.json",
                                            "compile_flags.txt"
                                        )(fname) or vim.fs.dirname(
                                            vim.fs.find(".git", { path = fname, upward = true })[1]
                                        )
                                    end
                                    if type(bufnr) == "string" then
                                        return root_directory(bufnr)
                                    else
                                        local fname = vim.api.nvim_buf_get_name(bufnr)
                                        ondir(root_directory(fname))
                                    end
                                end,
                                capabilities = {
                                    offsetEncoding = { "utf-16" },
                                },
                                cmd = {
                                    "clangd",
                                    "--background-index",
                                    "--clang-tidy",
                                    "--header-insertion=iwyu",
                                    "--completion-style=detailed",
                                    "--function-arg-placeholders",
                                    "--fallback-style=llvm",
                                },
                                init_options = {
                                    usePlaceholders = true,
                                    completeUnimported = true,
                                    clangdFileStatus = true,
                                },
                            },
                        },
                        setup = {
                            clangd = function(_, opts)
                                require("clangd_extensions").setup(vim.tbl_deep_extend("force", {}, { server = opts }))
                                return false
                            end,
                        },
                    },
                },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                c = { "clang-format" },
                cpp = { "clang-format" },
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "c", "cpp" } },
    },
    {
        "p00f/clangd_extensions.nvim",
        lazy = true,
        config = function() end,
        opts = {
            inlay_hints = {
                inline = false,
            },
            ast = {
                --These require codicons (https://github.com/microsoft/vscode-codicons)
                role_icons = {
                    type = "",
                    declaration = "",
                    expression = "",
                    specifier = "",
                    statement = "",
                    ["template argument"] = "",
                },
                kind_icons = {
                    Compound = "",
                    Recovery = "",
                    TranslationUnit = "",
                    PackExpansion = "",
                    TemplateTypeParm = "",
                    TemplateTemplateParm = "",
                    TemplateParamObject = "",
                },
            },
        },
    },
    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = { "clangd", "clang-format" },
        },
    },
}
