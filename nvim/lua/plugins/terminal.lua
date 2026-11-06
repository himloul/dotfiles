return {
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { [[<C-`>]], desc = "Toggle terminal" },
      { "<leader>t", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then return 15 end
        if term.direction == "vertical" then return vim.o.columns * 0.3 end
      end,
      open_mapping = [[<C-`>]],
      direction = "horizontal",
      -- interactive shell only; options.lua keeps cmd.exe for :! (much faster)
      shell = "pwsh",
      float_opts = { border = "curved", winblend = 10 },
      start_in_insert = true,
      close_on_exit = true,
    },
  },
}
