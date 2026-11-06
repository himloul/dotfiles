-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local keymap = vim.keymap.set

-- Fewer keystrokes: "jk" leaves insert mode
keymap("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Command palette: type to filter every command (built-in and your own)
keymap("n", "<leader>p", function() Snacks.picker.commands() end, { desc = "Command palette" })

-- Copy the mouse selection to the Windows clipboard on release, keep it selected
keymap("v", "<LeftRelease>", '"+ygv', { desc = "Copy selection on mouse release" })

-- Editor-style shortcuts (Vim keys still work)
keymap({ "n", "i" }, "<C-z>", "<cmd>undo<cr>", { desc = "Undo" })
keymap({ "n", "i" }, "<C-y>", "<cmd>redo<cr>", { desc = "Redo" })
keymap("v", "<C-c>", '"+y', { desc = "Copy to Windows clipboard" })
keymap("i", "<C-v>", '<C-r>+', { desc = "Paste from Windows clipboard" })

-- Select the whole file (replaces Vim's Ctrl+a number increment)
keymap("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Move focus between the file tree and the file: Alt+Left / Alt+Right
keymap("n", "<M-Left>", "<C-w>h", { desc = "Focus window left (tree)" })
keymap("n", "<M-Right>", "<C-w>l", { desc = "Focus window right (file)" })

-- Load your own commands
require("config.commands")
