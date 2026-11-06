# Neovim config (LazyVim)

Based on the [LazyVim starter](https://github.com/LazyVim/starter). Plugins are pinned in `lazy-lock.json`.

## Install on Windows

1. Install the prerequisites: `winget install Neovim.Neovim Git.Git BurntSushi.ripgrep.MSVC sharkdp.fd`, plus Node.js if you use LSPs that need it.
   For the fzf extension (`telescope-fzf-native`) you also need `make` and a C compiler. Install MSYS2 (`winget install MSYS2.MSYS2`), open its UCRT64 shell, run `pacman -S make mingw-w64-ucrt-x86_64-gcc`, and add `C:\msys64\ucrt64\bin` to your PATH. Without them the extension is skipped and Telescope uses its slower default sorter.
2. Link this folder into Neovim's config path (a junction needs no admin rights):

   ```powershell
   # run from the dotfiles repo root, so the target is wherever you cloned it
   New-Item -ItemType Junction -Path "$env:LOCALAPPDATA\nvim" -Target (Resolve-Path .\nvim).Path
   ```

   If `%LOCALAPPDATA%\nvim` already exists, move or delete it first.
3. Start `nvim`. lazy.nvim installs the plugins on first launch. Run `:Lazy restore` to match `lazy-lock.json` exactly.
4. Run `:Mason` to install the language servers and formatters, then `:checkhealth` to verify.

## Layout

- `init.lua`: entry point, loads `lua/config/lazy.lua`.
- `lua/config/`: options, keymaps, autocmds, user commands.
- `lua/plugins/`: one file per plugin group.
- `lazy-lock.json`: pinned plugin versions. Commit changes to it when you update plugins (`:Lazy update`).
- `NEOVIM-GUIDE.md`: personal keybinding and usage notes.

Plugin downloads and state live in `%LOCALAPPDATA%\nvim-data` and are not part of this repo.
