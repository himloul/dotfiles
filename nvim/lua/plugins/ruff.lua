return {
  {
    -- <leader>cf formats Python with Ruff (conform.nvim had no Python formatter)
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_format" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {},
        pyright = {},
      },
    },
  },
}