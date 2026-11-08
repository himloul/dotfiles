# dotfiles

My personal configuration files, one folder per tool.

## Layout

- `nvim/`: Neovim config (LazyVim). See [nvim/README.md](nvim/README.md) for install steps.
- `pwsh/`: PowerShell 7 profile (`Documents\PowerShell`).
- `terminal/`: Windows Terminal `settings.json` (`LocalState`).

## Install

`nvim` and `pwsh` are not copied, they are junctions into this repo, so an edit in
`~/dotfiles/x` is an edit at the real path and vice versa. Junctions need no admin
rights, but the real path must not exist first.

```powershell
# once per machine, from the folder holding dotfiles\
New-Item -ItemType Junction -Path "$HOME\Documents\PowerShell" -Target "$HOME\dotfiles\pwsh"
New-Item -ItemType Junction -Path "$env:LOCALAPPDATA\nvim"        -Target "$HOME\dotfiles\nvim"
```

`terminal/settings.json` is a plain copy: Windows Terminal rewrites its own file, so a
junction there would be edited by the app rather than reviewed. Copy it back to
`%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json`
by hand when it changes.

The `pwsh` profile expects `eza` for `ls`/`ll`/`la`/`lt`. Without it the profile skips
those functions and `ls` stays PowerShell's own alias for `Get-ChildItem`:

```powershell
winget install --id eza-community.eza
```
