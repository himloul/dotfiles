-- In-buffer markdown rendering. ft-lazy so non-markdown buffers pay nothing.
return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown",
  opts = {},
  config = function(_, opts)
    require("render-markdown").setup(opts)
    -- No opaque boxes anywhere: the theme is transparent, so a slab reads as an
    -- editor artifact rather than typography. Code keeps its treesitter colors and
    -- border glyph; headings keep their color and gain weight, since catppuccin
    -- sets no bold and the bars were doing the only hierarchy work.
    local function restyle()
      local p = require("catppuccin.palettes").get_palette()
      vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "none" })
      vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { bg = "none" })
      vim.api.nvim_set_hl(0, "RenderMarkdownCodeBorder", { bg = "none", fg = p.surface1 })
      for i = 1, 6 do
        local h = vim.api.nvim_get_hl(0, { name = "RenderMarkdownH" .. i, link = false })
        vim.api.nvim_set_hl(0, "RenderMarkdownH" .. i, { fg = h.fg, bold = i <= 3 })
        vim.api.nvim_set_hl(0, "RenderMarkdownH" .. i .. "Bg", { bg = "none" })
      end
    end
    restyle()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = restyle })
  end,
}
