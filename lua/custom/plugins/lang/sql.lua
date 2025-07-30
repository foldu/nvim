return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        postgres_lsp = {},
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'sql' } },
  },
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'postgrestools' },
    },
  },
}
