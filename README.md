Dotfiles of programs I end up using the most. At least on my machines.

As with everything else in life, use at your own risk.

# Hotkey Cheatsheet

## i3 — `$mod` = Super

### Focus & Movement
| Key | Action |
|-----|--------|
| `$mod + h/j/k/l` | Focus left/down/up/right |
| `$mod + Shift + h/j/k/l` | Move window left/down/up/right |
| `$mod + 1-0` | Switch to workspace 1–10 |
| `$mod + Shift + 1-0` | Move window to workspace 1–10 |
| `$mod + space` | Toggle focus tiling/floating |
| `$mod + a` | Focus parent container |

### Layout
| Key | Action |
|-----|--------|
| `$mod + f` | Fullscreen toggle |
| `$mod + Shift + space` | Toggle tiling/floating |
| `$mod + e` | Toggle split layout |
| `$mod + s` | Stacking layout |
| `$mod + w` | Tabbed layout |
| `$mod + CTRL + v` | Split horizontal |
| `$mod + CTRL + h` | Split vertical |
| `$mod + r` | Enter resize mode (`h/j/k/l` to resize, `Esc` to exit) |

### Apps & System
| Key | Action |
|-----|--------|
| `$mod + Return` | Open Alacritty |
| `$mod + d` | dmenu launcher |
| `$mod + Shift + q` | Kill focused window |
| `$mod + Shift + c` | Reload i3 config |
| `$mod + Shift + r` | Restart i3 |
| `$mod + BackSpace` | System mode (see below) |
| `$mod + x` | Close all dunst notifications |
| `Ctrl + BackSpace` | Pop last dunst notification |
| `$mod + Shift + m` | Open Emacs client |

### System Mode (`$mod + BackSpace`)
| Key | Action |
|-----|--------|
| `l` | Lock screen |
| `e` | Logout |
| `s` | Suspend |
| `h` | Hibernate |
| `r` | Reboot |
| `Ctrl + s` | Shutdown |
| `Esc / Enter` | Exit mode |

---

## tmux — Prefix = `C-Space`

### Sessions & Windows
| Key | Action |
|-----|--------|
| `PREFIX + w` | New window (current path) |
| `PREFIX + n` | Rename window |
| `PREFIX + x` | Kill pane |
| `PREFIX + X` | Kill window |
| `PREFIX + s` | Session chooser |
| `PREFIX + r` | Reload config |
| `M-j / M-k` | Previous/next window |

### Panes
| Key | Action |
|-----|--------|
| `PREFIX + v` | Vertical split (current path) |
| `PREFIX + h` | Horizontal split (current path) |
| `PREFIX + h/j/k/l` | Navigate panes |
| `PREFIX + H/J/K/L` | Resize pane (repeatable) |
| `PREFIX + z` | Zoom pane (toggle fullscreen) |

### Copy Mode (vi keys)
| Key | Action |
|-----|--------|
| `PREFIX + Enter` | Enter copy mode |
| `v` | Begin selection |
| `V` | Line selection |
| `C-v` | Rectangle selection |
| `y` | Yank to clipboard |
| `Esc` | Cancel |
| `/ / ?` | Search forward/backward |

### Sessions (tmux-resurrect)
| Key | Action |
|-----|--------|
| `PREFIX + C-s` | Save session |
| `PREFIX + C-r` | Restore session |

---

## Neovim — `<leader>` = Space, `<localleader>` = `\`

### Files & Navigation
| Key | Action |
|-----|--------|
| `<leader>sf` | Find files |
| `<leader>sg` | Live grep |
| `<leader>sw` | Grep word under cursor |
| `<leader>sb` | Search open buffers |
| `<leader>s.` | Recent files |
| `<leader>sn` | Search nvim config |
| `<leader>sr` | Resume last search |
| `<leader>/` | Fuzzy find in current buffer |
| `<C-h/j/k/l>` | Move between splits |

### Harpoon
| Key | Action |
|-----|--------|
| `<leader>a` | Add file to harpoon |
| `<C-e>` | Toggle harpoon menu |
| `<leader>1/2/3/4` | Jump to harpoon slot 1–4 |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Goto definition |
| `gr` | Goto references |
| `gI` | Goto implementation |
| `gD` | Goto declaration |
| `<leader>D` | Type definition |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>ds` | Document symbols |
| `<leader>ws` | Workspace symbols |
| `<leader>th` | Toggle inlay hints |
| `K` | Hover documentation |

### Diagnostics & Trouble
| Key | Action |
|-----|--------|
| `<leader>q` | Diagnostics → quickfix |
| `<leader>xx` | Toggle Trouble |
| `]d / [d` | Next/prev diagnostic |

### Git
| Key | Action |
|-----|--------|
| `<leader>gs` | Git status (fugitive) |
| `<leader>gb` | Git blame |
| `<leader>gd` | Git diff split |
| `]h / [h` | Next/prev hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |

### Flash
| Key | Mode | Action |
|-----|------|--------|
| `<leader>s` | Normal | Flash jump |
| `<leader>S` | Normal | Flash treesitter |
| `r` | Operator-pending | Flash remote (act without moving cursor) |

### Text Objects (mini.ai + treesitter)
| Key | Object |
|-----|--------|
| `af / if` | Around/inside function |
| `ac / ic` | Around/inside class |
| `aa / ia` | Around/inside argument |
| `aq / iq` | Around/inside quote |
| `]f / [f` | Next/prev function |
| `]c / [c` | Next/prev class |

### Surround (mini.surround)
| Key | Action |
|-----|--------|
| `saiw)` | Surround word with `()` |
| `sd'` | Delete surrounding `'` |
| `sr)'` | Replace `)` with `'` |

### Formatting
| Key | Action |
|-----|--------|
| `<leader>f` | Format buffer |
| auto | Format on save: lua, python, go, rust, ocaml |
| auto | Lint on save: python, markdown |

### Debug (DAP)
| Key | Action |
|-----|--------|
| `<F5>` | Start/continue |
| `<F1/2/3>` | Step into/over/out |
| `<F7>` | Toggle DAP UI |
| `<leader>b` | Toggle breakpoint |
| `<leader>B` | Conditional breakpoint |
| `<leader>du` | Toggle DAP UI |
| `<leader>dr` | Open REPL |

### REPL — iron.nvim
| Key | Action |
|-----|--------|
| `\rs{motion}` | Send motion to REPL |
| `\rr` | Send line |
| `\rp` | Send paragraph |
| `\rf` | Send file |
| `\rb` | Send code block |
| `\rn` | Send block and move |
| `\ri` | Open/focus REPL |
| `\rq` | Quit REPL |
| `\rx` | Clear REPL |

**Power combos:** `\rsif` send inner function · `\rsac` send class · `\rsip` send paragraph

### Quarto
| Key | Action |
|-----|--------|
| `<leader>qp` | QuartoPreview |
| `<leader>qq` | QuartoClosePreview |
| `\rc` | Run cell |
| `\ra` | Run cell and above |
| `\rA` | Run all cells |
| `\rl` | Run line |
| `\rR` | Run all cells (all languages) |

### Sessions
| Key | Action |
|-----|--------|
| `<leader>qs` | Restore session (cwd) |
| `<leader>ql` | Restore last session |
| `<leader>qd` | Stop saving session |

### Terminal
| Key | Action |
|-----|--------|
| `:terminal` | Open terminal buffer |
| `<Esc><Esc>` | Exit terminal mode |
| `:vsplit \| terminal` | Terminal in vertical split |

