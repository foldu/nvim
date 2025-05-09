return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            if not vim.fn.executable("nix") then
                vim.notify("FIXME: Missing powershell lsp config for windows", vim.log.levels.ERROR)
                return
            end

            local editor_services = vim.fn.exepath("powershell-editor-services")
            if editor_services == nil then
                return
            end
            editor_services = vim.uv.fs_realpath(editor_services)
            if editor_services == nil then
                return
            end

            local editor_services_bundle = vim.fs.dirname(vim.fs.dirname(editor_services))
                .. "/lib/powershell-editor-services"
            vim.lsp.config("powershell_es", {
                bundle_path = editor_services_bundle,
                shell = "pwsh",
            })
            vim.lsp.enable("powershell_es")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "powershell" } },
    },
}
