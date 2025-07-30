return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'typst' },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        tinymist = {},
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        typst = { 'typstyle' },
      },
    },
  },
  {
    'chomosuke/typst-preview.nvim',
    cmd = { 'TypstPreview', 'TypstPreviewToggle', 'TypstPreviewUpdate' },
    keys = {
      {
        '<leader>cp',
        ft = 'typst',
        '<cmd>TypstPreviewToggle<cr>',
        desc = 'Toggle Typst Preview',
      },
    },
    opts = {
      dependencies_bin = {
        tinymist = 'tinymist',
      },
    },
  },
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'tinymist', 'typstyle' },
    },
  },
}
