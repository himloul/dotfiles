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

-- Claude Code in a full-screen terminal. Run again to hide it; the session keeps running.
local claude_buf = nil

local function claude_alive()
  return claude_buf ~= nil
    and vim.api.nvim_buf_is_valid(claude_buf)
    and vim.fn.jobwait({ vim.b[claude_buf].terminal_job_id }, 0)[1] == -1
end

local function claude_win()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if claude_buf and vim.api.nvim_win_get_buf(win) == claude_buf then return win end
  end
end

cmd("Claude", function()
  local win = claude_win()
  if win then
    pcall(vim.api.nvim_win_close, win, true) -- hide: buffer and process stay alive
    return
  end

  vim.cmd.tabnew()
  if not claude_alive() then
    -- first run, or the last session exited: start a fresh one in the project root
    if claude_buf and vim.api.nvim_buf_is_valid(claude_buf) then
      vim.api.nvim_buf_delete(claude_buf, { force = true })
    end
    -- cmd.exe /c so the claude shim (.cmd) starts on Windows
    vim.fn.termopen({ "cmd.exe", "/c", "claude --resume" }, { cwd = LazyVim.root() })
    claude_buf = vim.api.nvim_get_current_buf()
    vim.bo[claude_buf].bufhidden = "hide"
    -- Ctrl+` hides it from inside the terminal (buffer-local, so toggleterm is unaffected)
    vim.keymap.set("t", "<C-`>", "<C-\\><C-n><cmd>Claude<cr>", { buffer = claude_buf, desc = "Hide Claude" })
  else
    vim.api.nvim_win_set_buf(0, claude_buf)
  end
  vim.cmd.startinsert()
end, "Open Claude Code full screen; run again to hide")
