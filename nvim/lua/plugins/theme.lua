-- Catppuccin: Mocha (dark) or Latte (light), following the terminal's background (system dark/light mode)
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "auto", -- latte when background=light, mocha when background=dark
      background = { light = "latte", dark = "mocha" },
      transparent_background = true,
    },
    -- LazyVim applies the colorscheme before this plugin's setup() runs, so the
    -- options above (transparency, auto flavour) are ignored. Apply it once more here.
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } },
  -- LazyVim's default theme, unused: Catppuccin is the only one in use
  { "folke/tokyonight.nvim", enabled = false },
  -- LazyVim themes bufferline for catppuccin itself (specs in lazyvim.plugins.colorscheme),
  -- so no local override is needed.
}
