-- In-buffer markdown rendering. ft-lazy so non-markdown buffers pay nothing.
return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown",
  opts = {},
  config = function(_, opts)
    require("render-markdown").setup(opts)
    -- Catppuccin links the code groups to ColorColumn (surface0), which reads as a
    -- heavy slab. Go one step lighter, from the live palette so it follows the flavour:
    -- mocha surface0 -> surface1, latte surface0 -> crust (latte has no lighter surface).
    local function code_bg()
      local p = require("catppuccin.palettes").get_palette()
      local bg = vim.o.background == "light" and p.crust or p.surface1
      vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = bg })
      vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { link = "RenderMarkdownCode" })
      vim.api.nvim_set_hl(0, "RenderMarkdownCodeBorder", { link = "RenderMarkdownCode" })
    end
    code_bg()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = code_bg })
  end,
}
