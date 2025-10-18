vim.lsp.enable({
    "bashls",

    "lua_ls",

    "vtsls",
    "vue_ls",
    "tailwindcss",
    "denols",

    "rust-analyzer",

    "ruff",
    "basedpyright",

    "tombi",

    "postgres_lsp",

    "yamlls",

    "nixd",

    "clangd",
    "neocmake",

    "json-lsp",

    "bashls",
})

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
-- vim.diagnostic.config({
--     severity_sort = true,
--     float = { border = "rounded", source = "if_many" },
--     signs = {
--         text = {
--             [vim.diagnostic.severity.ERROR] = "󰅚 ",
--             [vim.diagnostic.severity.WARN] = "󰀪 ",
--             [vim.diagnostic.severity.INFO] = "󰋽 ",
--             [vim.diagnostic.severity.HINT] = "󰌶 ",
--         },
--     },
--     virtual_text = {
--         source = "if_many",
--         spacing = 2,
--     },
--     -- Display multiline diagnostics as virtual lines
--     virtual_lines = true,
-- })
vim.diagnostic.config({
    severity_sort = true,
    -- float = {
    --     focus = false,
    --     scope = "cursor",
    --     border = "rounded",
    -- },
    float = {
        max_width = 90,
        wrap = true,
        source = "if_many",
        border = "rounded",
        close_events = {},
    },
    signs = {
        numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
        },
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.WARN] = "",
        },
    },
    update_in_insert = true,
    virtual_text = false,
    virtual_lines = false,
})

local function close_floating_window(win_id)
    if type(win_id) == "number" and vim.api.nvim_win_is_valid(win_id) then
        vim.api.nvim_win_close(win_id, true)
    end
end

local lnum, win_id = nil, nil

vim.api.nvim_create_autocmd({ "BufEnter", "CursorMoved" }, {
    desc = "line change to close floating window",
    group = vim.api.nvim_create_augroup("diagnostic_float", { clear = true }),
    callback = function()
        if lnum == nil then
            lnum = vim.fn.line(".")
            _, win_id = vim.diagnostic.open_float(nil)
        else
            local currentline = vim.fn.line(".")
            if lnum ~= currentline then
                close_floating_window(win_id)
                lnum = currentline
                _, win_id = vim.diagnostic.open_float(nil)
            end
        end
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
        -- NOTE: Remember that Lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map("gra", function()
            require("tiny-code-action").code_action()
        end, "[G]oto Code [A]ction", { "n", "x" })

        -- Find references for the word under your cursor.
        map("grr", ":FzfLua lsp_references<CR>", "[G]oto [R]eferences")

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map("gri", ":FzfLua lsp_implementations<CR>", "[G]oto [I]mplementation")

        map("gd", ":FzfLua lsp_definitions<CR>", "[G]oto [D]efinition")

        map("gD", ":FzfLua lsp_declarations<CR>", "[G]oto [D]eclaration")

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        --map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        --map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        --map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

        -- Toggle to show/hide diagnostic messages
        --map('<leader>td', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, '[T]oggle [D]iagnostics')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if
            client
            and client:supports_method(
                vim.lsp.protocol.Methods.textDocument_documentHighlight,
                event.buf
            )
        then
            local highlight_augroup =
                vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({
                        group = "kickstart-lsp-highlight",
                        buffer = event2.buf,
                    })
                end,
            })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if
            client
            and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
        then
            map("<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
        end
    end,
})
