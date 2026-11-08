-- In-buffer markdown rendering. ft-lazy so non-markdown buffers pay nothing.
return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown",
  opts = {},
  config = function(_, opts)
    require("render-markdown").setup(opts)
    -- Catppuccin links all three code groups to ColorColumn (mocha surface0 #313244),
    -- which reads as a heavy grey slab on the transparent background. surface1 is lighter.
    local function code_bg()
      vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#45475a" })
      vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { link = "RenderMarkdownCode" })
      vim.api.nvim_set_hl(0, "RenderMarkdownCodeBorder", { link = "RenderMarkdownCode" })
    end
    code_bg()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = code_bg })
  end,
}
