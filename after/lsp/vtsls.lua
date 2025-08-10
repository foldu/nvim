return {
    filetypes = { "typescript", "javascript", "vue" },
    settings = {
        tsserver = {
            globalPlugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = vim.fn.stdpath("data")
                        .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                    languages = { "vue" },
                    configNamespace = "typescript",
                    enableForWorkspaceTypeScriptVersions = true,
                },
            },
        },
    },
}
