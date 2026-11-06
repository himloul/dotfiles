-- Autocmds are loaded on the VeryLazy event

-- No spell checking in markdown
vim.api.nvim_create_autocmd({ "BufEnter", "BufLeave" }, {
  pattern = "*.md",
  callback = function()
    vim.opt_local.spell = false
  end,
})
