return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash", "c", "cpp", "css", "glsl", "html", "javascript", "json", "lua", "markdown",
        "markdown_inline", "php", "python", "query", "regex", "tsx", "typescript", "vim", "yaml",
      })
    end,
  },
}
