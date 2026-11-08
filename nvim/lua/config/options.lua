-- Options are loaded before lazy.nvim startup (see https://www.lazyvim.org/configuration/general)

-- Shell for :! and vim.fn.system(): cmd.exe (pwsh took ~3.4 s per call here, cmd ~0.9 s)
vim.o.shell = "cmd.exe"
vim.o.shellcmdflag = "/s /c"
vim.o.shellquote = ""
vim.o.shellxquote = '"'

-- Truecolor for the Catppuccin theme
vim.o.termguicolors = true

-- Terminal tab title: 'title' is off by default, so the tab would keep saying "PowerShell 7".
-- Folder, not filename: tabs map to projects, and the cwd basename is never empty.
vim.o.title = true
vim.o.titlestring = "nvim - %{fnamemodify(getcwd(), ':t')}"

-- One file explorer only: neo-tree (instead of the default Snacks explorer)
vim.g.lazyvim_explorer = "neo-tree"

-- Productivity
vim.opt.undofile = true        -- keep undo history across restarts
vim.opt.swapfile = false       -- no swap-file prompts
vim.opt.clipboard = "unnamedplus" -- y/p use the Windows clipboard
vim.opt.ignorecase = true      -- case-insensitive search...
vim.opt.smartcase = true       -- ...unless the pattern has a capital letter
