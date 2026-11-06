# Neovim Guide (LazyVim, Windows)

> `<leader>` is **Space**. `<C-x>` means Ctrl+x, `<S-x>` means Shift+x.
> Not sure of a key? Press `<leader>` and wait (which-key shows the menu), or run `:Telescope keymaps`.

---

## 0. Must-know first (beginners)

**Modes**
- **Normal** (default): keys move and act. `Esc` returns here.
- **Insert**: type text. Press `i` to start, `jk` to leave.
- **Visual**: select text with `v` (or `V` for lines). Then `y` copies, `d` deletes.

**Moving:** `h j k l` (left, down, up, right), `w` / `b` (next / previous word), `gg` / `G` (top / bottom of file).

**Saving and quitting:** `Ctrl+s` saves. `:q` quits, `:wq` saves and quits, `:q!` quits without saving, `<leader>qq` quits everything.

**Editing:** `u` undo, `Ctrl+r` redo, `y` copy, `p` paste, `dd` delete line.

**Finding things:** `<leader><space>` finds files. `<leader>sg` searches text across the project. `/text` searches in the current file, then `n` / `N` jump between matches.

**Files, buffers, terminal:** `<leader>e` toggles the file tree. `Shift+h` / `Shift+l` switch open files. `<leader>bd` closes a file. `Ctrl+\`` toggles the terminal.

**Stuck:** press `<leader>` and wait for the menu, or run `:Tutor` once (about 30 minutes).

**Search keys:** `sg` = **s**earch **g**rep (text across the project), `sw` = **s**earch **w**ord (the word under the cursor). The `s` prefix means "search" in LazyVim's keymaps.

**Ctrl+F:** Neovim uses it to scroll a page down, so it isn't a search key. Use `<leader>sg` instead.

---

## 1. Cheat sheet (one page)

| Task | Keys |
|---|---|
| Command palette | `<leader>p` |
| Find a file | `<leader><space>` |
| Search text in project | `<leader>/` |
| Open / close file tree | `<leader>e` |
| Switch buffer | `<leader>,` |
| Next / previous buffer | `<S-l>` / `<S-h>` |
| Terminal (PowerShell) | `<C-`>` |
| Pi (full screen) | `<leader>a` |
| Leave insert mode | `jk` |
| Save | `<C-s>` (or `:w`) |
| Quit | `:q` (`:qa` quits all) |
| Go to definition | `gd` |
| References | `gr` |
| Hover docs | `K` |
| Next / previous diagnostic | `]d` / `[d` |
| Code actions | `<leader>ca` |
| Rename symbol | `<leader>cr` |
| Format buffer | `<leader>cf` |
| Toggle comment | `gcc` (line) / `gc` (selection) |
| Jump anywhere on screen | `s`, type 1-2 letters, pick the label |
| Undo / redo | `u` / `<C-r>` |

---

## 2. Modes (the basics)

- **Normal** (default): move and run commands. Press `Esc` to get here.
- **Insert**: type text. `i` starts insert before the cursor, `a` after it, `o` opens a new line below.
- **Visual**: select text. `v` for characters, `V` for lines, `<C-v>` for blocks.
- **Command**: `:` opens the command line. Press `Esc` to cancel.

---

## 3. Movement

- `h j k l` move left, down, up, right. Words: `w` (next), `b` (back), `e` (end).
- Lines: `0` start, `^` first non-blank, `$` end. Screen: `gg` top, `G` bottom, `<C-d>` / `<C-u>` half page down/up.
- Find on line: `f<char>` jumps to that character, `t<char>` stops before it, `;` repeats.
- Jump to a line: `:42` or `42G`.
- Previous cursor position: `<C-o>` (back), `<C-i>` (forward).

**Flash** (already installed): `s` then 1-2 letters jumps to any visible match. `S` selects by code block.

---

## 4. Files, folders and search

**Finding files**
- `<leader><space>`: find a file in the project.
- `<leader>/`: grep the project for text.
- `<leader>fp`: find files inside plugin folders (rarely needed).
- In a Telescope list: type to filter, `<C-j>` / `<C-k>` to move, `Enter` to open, `Esc` to close.

**File tree (neo-tree)**
- `<leader>e` toggles the tree.
- Inside the tree:
  - `Enter` opens a file, `s` opens it in a vertical split, `t` in a new tab.
  - `a` creates a file (end the name with `/` for a folder), `A` creates a folder.
  - `r` renames, `d` deletes (asks first), `m` moves.
  - `c` copies, `x` cuts, `p` pastes, `y` copies the name.
  - `R` refreshes, `?` shows all keys, `q` closes.

**Renaming the file you're editing**: `:saveas newname`, then delete the old file in the tree.

**Opening a folder**: `nvim C:\path\to\folder` opens the project there.

---

## 5. Editing

- **Delete:** `x` (char), `dd` (line), `dw` (word), `D` (to end of line).
- **Change:** `cw` (word), `cc` (line), `C` (to end of line).
- **Copy / paste:** `yy` (line), `yw` (word), `p` paste after, `P` paste before. With the clipboard set to Windows, `y` and `p` use the system clipboard.
- **Text objects** (the fastest way to edit inside things):
  - `ciw` change inside word, `diw` delete word.
  - `ci"` change inside quotes, `da"` delete around quotes.
  - `ci(` change inside parentheses, `ci{` inside braces.
- **Repeat:** `.` repeats the last change.
- **Macros:** `qa` starts recording into `a`, `q` stops, `@a` replays.
- **Indent:** `>>` / `<<` in normal mode, `>` / `<` on a visual selection.

**Code tools (when a language server is running)**
- `<leader>ca` code actions (auto-fixes, imports).
- `<leader>cr` rename a symbol across files.
- `<leader>cf` format the buffer (uses the formatter configured for that file type).
- `]d` / `[d` jump between errors and warnings.

---

## 6. Windows, buffers, terminal

- **Splits:** `:vsplit` (side by side), `:split` (stacked). Move between them with `<C-w>` then `h`/`j`/`k`/`l`. Close with `<C-w>c`.
- **Buffers:** a buffer is an open file. `<leader>,` lists them, `<leader>bd` closes one.
- **Terminal:** `<C-`>` toggles a PowerShell terminal at the bottom. Press `<C-`>` again to hide it. Inside a terminal you're typing into the program, so press `Ctrl+\` then `Ctrl+n` to reach normal mode, and `i` to type again.
- **Pi:** `<leader>a` opens Pi full screen in a new tab, continuing a session in the project folder. Press `<leader>a` again, or `<C-`>` inside it, to hide it. The session keeps running.

---

## 7. Commands and the palette

- `<leader>p` opens the **command palette**. Type to filter, Enter to run.
- `:` opens the classic command line. Type `:` then a few letters and press `Tab` to complete.
- Your own commands (in `lua/config/commands.lua`):
  - `:CopyPath` copies the current file's full path to the clipboard.
  - `:OpenConfig` opens `init.lua`.

**Add your own command**

Open `lua/config/commands.lua` and add:

```lua
cmd("Name", function()
  -- your code here
end, "Short description shown in the palette")
```

Restart Neovim and it appears in `<leader>p`.

---

## 8. Config map (where to change things)

| File | What it controls |
|---|---|
| `init.lua` | Entry point, loads everything else |
| `lua/config/lazy.lua` | Plugin manager, LazyVim extras (language support) |
| `lua/config/options.lua` | Shell, clipboard, search, undo, theme settings |
| `lua/config/keymaps.lua` | Your keys, including the palette `<leader>p` |
| `lua/config/commands.lua` | Your own `:commands` |
| `lua/config/autocmds.lua` | Automatic behavior (e.g., no spellcheck in markdown) |
| `lua/plugins/theme.lua` | Catppuccin (follows light/dark mode) |
| `lua/plugins/neotree.lua` | File tree options (hidden files, skipped Windows folders) |
| `lua/plugins/lsp.lua` | Treesitter parsers (syntax highlighting) |
| `lua/plugins/mason.lua` | Tools Mason installs automatically |
| `lua/plugins/ruff.lua` | Python linting and formatting (Ruff) |
| `lua/plugins/terminal.lua` | Terminal toggle and PowerShell |
| `lua/plugins/telescope*.lua` | Search (Telescope) options |
| `lua/plugins/dashboard.lua` | Start screen header |

**Useful maintenance commands**
- `:Lazy` plugin manager window. `:Lazy sync` installs and updates. `:Lazy clean` removes unused plugins.
- `:Mason` shows language tools and lets you install or remove them.
- `:checkhealth` lists problems and what to install.

---

## 9. Troubleshooting

| Symptom | Fix |
|---|---|
| Black flash before the theme | Already fixed (Catppuccin base color set early). |
| Theme didn't switch after changing Windows light/dark mode | Restart Neovim (the terminal reports background only at startup). |
| `[Neo-tree ERROR] EPERM` when opening a folder | Already fixed: Windows junction folders are skipped. |
| Mason warnings (7z, luarocks, ruby, php...) | Harmless: optional tools you don't use. |
| Two file trees on the left | Only neo-tree should load. Check `lua/config/options.lua` has `vim.g.lazyvim_explorer = "neo-tree"`. |
| Import-order warning on startup | Keep LazyVim extras imported in `lua/config/lazy.lua` before `{ import = "plugins" }`. |
| Code has no colors | Check `:set ft?` (file type) and `:set termguicolors?` (should be `on`). Run `:checkhealth vim.treesitter`. |
| Something is broken and you don't know why | Run `nvim --clean .` (no config). If it works there, the problem is in your config. |
| Need the exact error | `:messages` shows recent messages. |

---

## 10. Starting over safely

- Your original config is backed up at `C:\Users\himloul\AppData\Local\Temp\nvim_backup_142711` (the Temp folder can be cleared by Windows, so copy it elsewhere if you need it).
- To undo a single change, edit the file and remove the lines you added.
