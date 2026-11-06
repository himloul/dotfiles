return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    lazy = true,
    event = "VeryLazy",
    cond = function()
      -- Only load if make is available
      return vim.fn.executable("make") == 1
    end,
    config = function()
      pcall(require("telescope").load_extension, "fzf")
    end,
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
}
