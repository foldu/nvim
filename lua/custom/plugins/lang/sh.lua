return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        bashls = {},
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        bash = { 'shfmt' },
        sh = { 'shfmt' },
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'bash' } },
  },
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'shfmt', 'bash-language-server', 'shellcheck' },
    },
  },
}
