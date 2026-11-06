-- Your own commands. Each one shows up in the palette (<leader>p).
local function cmd(name, fn, desc)
  vim.api.nvim_create_user_command(name, fn, { desc = desc })
end

cmd("CopyPath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, "Copy the current file's full path to the clipboard")

cmd("OpenConfig", function()
  vim.cmd.edit(vim.fn.stdpath("config") .. "/init.lua")
end, "Open Neovim's init.lua")
