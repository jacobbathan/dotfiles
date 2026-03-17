# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal Emacs configuration. The primary file is `init.el`. `custom.el` is machine-managed by Emacs (via `M-x customize`) and should not be edited directly. `elfeed.org` holds RSS feed subscriptions for the elfeed package.

## Applying changes

Changes to `init.el` take effect after reloading:
- Reload a specific `use-package` block: place cursor inside it, then `C-M-x` (`eval-defun`)
- Reload entire config: `M-x load-file RET ~/.config/emacs/init.el`
- Full restart: restart Emacs

To install a new package declared with `use-package`, evaluate the block or restart Emacs (`:ensure t` triggers auto-install).

Package updates run automatically every 7 days via `auto-package-update`. Manual update: `M-x auto-package-update-now`.

## Architecture

All configuration lives in a single `init.el`. Packages are managed via the built-in `package.el` with `use-package`. Repositories: MELPA, GNU ELPA, NonGNU ELPA, Org ELPA. The tokyonight-themes package is installed via `package-vc` (`:vc (:url ...)`) since it's not on any registry.

**Completion stack:**
- `vertico` — vertical minibuffer completion UI
- `corfu` — in-buffer completion popup (global, with history and popupinfo)
- `orderless` — space-separated fuzzy matching style
- `marginalia` — annotations in minibuffer
- `consult` — enhanced commands (buffer switching, grep, line search, yank-pop)
- `embark` — context actions on completion candidates
- `cape` — completion-at-point extensions (dabbrev, file, elisp-block)

**LSP / language support:**
- `eglot` — built-in LSP client, hooks into all `prog-mode` buffers
- `treesit-auto` — auto-installs and enables tree-sitter grammars
- Go: `go-ts-mode` with gopls inlay hints configured via `eglot-workspace-configuration`
- Rust: `rust-mode` with `rustfmt-on-save`, `flycheck-rust`
- Haskell: `haskell-mode` with `fourmolu` formatter (via `reformatter`)
- GDScript: `gdscript-mode` with eglot
- R: `ess`

**Org ecosystem:**
- Notes directory: `~/Notes/org` (also used as `org-agenda-files`)
- `org-capture` bound to `C-c c`; templates defined inline in `init.el`
- `org-fragtog` — auto-preview LaTeX fragments on cursor leave
- `org-appear` — reveal emphasis markers on hover
- `org-modern` — visual improvements (keywords/checkboxes/tables disabled)
- `ox-hugo` — export org to Hugo markdown
- `olivetti` + `distraction-free` function — toggle centered writing mode (`<f9>`)

**RSS reading:**
- `elfeed` — feed reader (`C-c w e`)
- Feed list defined in `elfeed.org` (loaded via `elfeed-org`)
- `elfeed-tube` — fetches YouTube transcripts inside elfeed
- `elfeed-tube-mpv` — open YouTube entries in mpv

**AI:**
- `ellama` — LLM interface; keymap prefix `C-c e`; uses Ollama locally

**Popup frame pattern:**
The macro `ntgo-window-define-with-popup-frame` creates commands that open a feature in a new X frame and auto-close it on finalize. Used for `org-capture` and `tmr`.

## Key custom keybindings

| Key | Command |
|-----|---------|
| `C-x b` | `consult-buffer` |
| `M-l` | `consult-git-grep` |
| `M-s` | `consult-line` |
| `M-y` | `consult-yank-pop` |
| `C-.` | `embark-act` |
| `C-;` | `embark-dwim` |
| `C-x g` | `magit-status` |
| `C-c a` | `org-agenda` |
| `C-c c` | `org-capture` |
| `C-c e` | ellama prefix |
| `C-c w e` | `elfeed` |
| `C-c c a/o/r/f` | eglot actions/organize-imports/rename/format |
| `C-c p` | `cape-prefix-map` |
| `<f3>` | `flymake-goto-next-error` |
| `<f5>` / `S-<f5>` | `project-compile` / `project-recompile` |
| `<f9>` | `distraction-free` |
| `C-g` | `ntgo/keyboard-quit-dwim` (region-aware quit) |

## Important file locations

- `~/.config/emacs/init.el` — main config (edit this)
- `~/.config/emacs/custom.el` — Emacs-managed custom variables (do not edit)
- `~/.config/emacs/elfeed.org` — RSS feed list
- `~/.config/emacs/elfeed/` — elfeed database
- `~/.config/emacs/ellama-sessions/` — ellama chat history
- `~/.config/emacs/backups/` — file backups
- `~/Notes/org` — org-mode notes and agenda files
- `~/.local/bin` — added to `exec-path` (place local scripts here)
