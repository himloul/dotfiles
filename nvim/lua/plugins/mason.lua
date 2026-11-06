return {
  {
    "mason-org/mason.nvim",
    -- ruff (formatter, see ruff.lua) and pyright (LSP) are required by this config.
    -- LazyVim also auto-installs them on first use, but listing them keeps a fresh
    -- install deterministic and avoids a stall on the first Python file.
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "ruff", "pyright" })
    end,
  },
}
