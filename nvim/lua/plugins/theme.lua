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
    config = function(_, opts)
      require("catppuccin").setup(opts)
      -- The startup colorscheme load ignores transparent_background here, so reapply once after startup
      -- ponytail: drop this if the startup load honours transparent_background
      vim.api.nvim_create_autocmd("VimEnter", {
        once = true,
        callback = function()
          if vim.g.colors_name == "catppuccin" then vim.cmd.colorscheme("catppuccin") end
        end,
      })
    end,
  },
  { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } },
  {
    -- Local override: catppuccin's bufferline palette falls back to mocha when
    -- flavour is unset (auto), so the bar stays dark on a light editor.
    -- Pick latte/mocha from vim.o.background for the bar only.
    -- ponytail: remove once catppuccin/nvim fixes get_palette() for flavour=auto
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function(_, opts)
      if not (vim.g.colors_name or ""):find("catppuccin") then return end
      local ctp = require("catppuccin")
      local flavour = vim.o.background == "light" and "latte" or "mocha"
      local get_theme = require("catppuccin.special.bufferline").get_theme()
      opts.highlights = function()
        local prev = ctp.flavour
        ctp.flavour = flavour
        local ok, res = pcall(get_theme)
        ctp.flavour = prev
        if not ok then error(res) end
        return res
      end
    end,
  },
}
