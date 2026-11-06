# Neovim config (LazyVim)

Based on the [LazyVim starter](https://github.com/LazyVim/starter). Plugins are pinned in `lazy-lock.json`.

## Install on Windows

1. Install the prerequisites: `winget install Neovim.Neovim Git.Git BurntSushi.ripgrep.MSVC sharkdp.fd`, plus a C compiler (`winget install MSYS2.MSYS2`) and Node.js if you use LSPs that need them.
2. Link this folder into Neovim's config path (a junction needs no admin rights):

   ```powershell
   New-Item -ItemType Junction -Path "$env:LOCALAPPDATA\nvim" -Target "C:\Users\himloul\personal\projects\dotfiles\nvim"
   ```

   If `%LOCALAPPDATA%\nvim` already exists, move or delete it first.
3. Start `nvim`. lazy.nvim installs the plugins on first launch. Run `:Lazy restore` to match `lazy-lock.json` exactly.
4. Run `:Mason` to install the language servers and formatters, then `:checkhealth` to verify.

## Layout

- `init.lua`: entry point, loads `lua/config/lazy.lua`.
- `lua/config/`: options, keymaps, autocmds, user commands.
- `lua/plugins/`: one file per plugin group. `ai.lua.txt` is disabled; rename it to `ai.lua` to enable it. It has a key placeholder, so keep real keys out of the repo.
- `lazy-lock.json`: pinned plugin versions. Commit changes to it when you update plugins (`:Lazy update`).
- `NEOVIM-GUIDE.md`: personal keybinding and usage notes.

Plugin downloads and state live in `%LOCALAPPDATA%\nvim-data` and are not part of this repo.
