-- In-buffer markdown rendering. ft-lazy so non-markdown buffers pay nothing.
return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown",
  opts = {},
  config = function(_, opts)
    require("render-markdown").setup(opts)
    -- No backgrounds: the theme is transparent, so a slab is the one opaque box on
    -- the screen. Code text is already colored by treesitter (@markup.raw); only the
    -- border glyph needs a faint color, since ColorColumn has no foreground.
    local function clear_bg()
      local p = require("catppuccin.palettes").get_palette()
      vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "none" })
      vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { bg = "none" })
      vim.api.nvim_set_hl(0, "RenderMarkdownCodeBorder", { bg = "none", fg = p.surface1 })
    end
    clear_bg()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = clear_bg })
  end,
}
