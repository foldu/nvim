return {
    recommended = function()
        return LazyVim.extras.wants({
            ft = "vue",
            root = { "vue.config.js" },
        })
    end,

    -- depends on the typescript extra
    { import = "lazyvim.plugins.extras.lang.typescript" },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "vue", "css" } },
    },

    -- Add LSP servers
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                volar = {
                    init_options = {
                        vue = {
                            hybridMode = true,
                        },
                    },
                },
                vtsls = {},
            },
        },
    },

    -- Configure tsserver plugin
    {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
            table.insert(opts.servers.vtsls.filetypes, "vue")
            local exe = vim.fn.exepath("vue-language-server")
            if exe == "" then
                -- vim.notify("Can't find vue-language-server", vim.log.levels.ERROR)
                return
            end
            exe = vim.uv.fs_realpath(exe)
            local elems = vim.split(exe, "/")
            local package_root = table.concat(elems, "/", 1, #elems - 2)
            LazyVim.extend(opts.servers.vtsls, "settings.vtsls.tsserver.globalPlugins", {
                {
                    name = "@vue/typescript-plugin",
                    location = package_root .. "/lib/node_modules/@vue/language-server",
                    languages = { "vue" },
                    configNamespace = "typescript",
                    enableForWorkspaceTypeScriptVersions = true,
                },
            })
        end,
    },
}
