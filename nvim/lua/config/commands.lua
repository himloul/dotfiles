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

-- Pi in a full-screen terminal. Run again to hide it; the session keeps running.
local pi_buf = nil

local function pi_alive()
  return pi_buf ~= nil
    and vim.api.nvim_buf_is_valid(pi_buf)
    and vim.fn.jobwait({ vim.b[pi_buf].terminal_job_id }, 0)[1] == -1
end

local function pi_win()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if pi_buf and vim.api.nvim_win_get_buf(win) == pi_buf then return win end
  end
end

cmd("Pi", function()
  local win = pi_win()
  if win then
    pcall(vim.api.nvim_win_close, win, true) -- hide: buffer and process stay alive
    return
  end

  vim.cmd.tabnew()
  if not pi_alive() then
    -- first run, or the last session exited: start a fresh one in the project root
    if pi_buf and vim.api.nvim_buf_is_valid(pi_buf) then
      vim.api.nvim_buf_delete(pi_buf, { force = true })
    end
    -- cmd.exe /c so the pi shim (.cmd) starts on Windows
    vim.fn.termopen({ "cmd.exe", "/c", "pi --continue" }, { cwd = LazyVim.root() })
    pi_buf = vim.api.nvim_get_current_buf()
    vim.bo[pi_buf].bufhidden = "hide"
    -- Ctrl+` hides Pi, in terminal and normal mode. Buffer-local, so toggleterm's
    -- global <C-`> mapping cannot open a new terminal here.
    vim.keymap.set("t", "<C-`>", "<cmd>Pi<cr>", { buffer = pi_buf, desc = "Hide Pi" })
    vim.keymap.set("n", "<C-`>", "<cmd>Pi<cr>", { buffer = pi_buf, desc = "Hide Pi" })
  else
    vim.api.nvim_win_set_buf(0, pi_buf)
  end
  vim.cmd.startinsert()
end, "Open Pi full screen; run again to hide")
