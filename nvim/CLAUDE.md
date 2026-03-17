# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). It uses `lazy.nvim` as the plugin manager and is written entirely in Lua.

## Architecture

The config loads in this order via `init.lua`:
1. `lua/options.lua` — vim options (line numbers, clipboard, scrolloff, etc.)
2. `lua/keymaps.lua` — global keymaps and autocommands
3. `lua/lazy-bootstrap.lua` — installs lazy.nvim if not present
4. `lua/lazy-plugins.lua` — registers all plugins with lazy.nvim

### Plugin structure

Each plugin lives in its own file under `lua/kickstart/plugins/`. `lazy-plugins.lua` `require()`s each one directly (they return a lazy.nvim plugin spec table).

- **`lspconfig.lua`** — Mason + mason-lspconfig + nvim-lspconfig. LSP servers configured: `clangd`, `gopls`, `pyright`, `rust_analyzer`, `ts_ls`, `perlnavigator`, `r_language_server`, `lua_ls`. Mason auto-installs them plus `stylua`.
- **`conform.lua`** — Autoformatter. Runs on `BufWritePre`. Lua uses `stylua`; C/C++ formatting disabled (no LSP fallback). `<leader>f` formats manually.
- **`lint.lua`** — `nvim-lint`. Markdown uses `markdownlint`. Runs on `BufEnter`, `BufWritePost`, `InsertLeave`.
- **`cmp.lua`** — Completion via `nvim-cmp` + `LuaSnip`. Sources: LSP, luasnip, path, lazydev.
- **`telescope.lua`** — Fuzzy finder. Key bindings use `<leader>;f` (files), `<leader>;g` (grep), `<leader>;h` (help), `<leader><leader>` (buffers).
- **`treesitter.lua`** — Syntax highlighting and text objects.
- **`molten.lua`** — Jupyter-style notebook execution (`benlubas/molten-nvim`), requires `:UpdateRemotePlugins` after install.
- **`r.lua`** — R language integration.
- **`copilot.lua`** — GitHub Copilot.
- **`tokyonight.lua`** — Colorscheme.

Custom/user plugins go in `lua/custom/plugins/` (currently empty `init.lua`). The `{ import = 'custom.plugins' }` line in `lazy-plugins.lua` is commented out — uncomment to auto-load that directory.

## Key Settings

- **Leader key**: `<Space>` (both `mapleader` and `maplocalleader`)
- **Indentation**: 2-space tabs (`ts=2 sts=2 sw=2 et`) enforced by modelines in every file; `vim-sleuth` auto-detects per project
- **Clipboard**: synced with system clipboard (`unnamedplus`)
- **Nerd Font**: enabled (`vim.g.have_nerd_font = true`)

## In-editor Commands

- `:Lazy` — plugin manager UI (update, sync, clean)
- `:Mason` — LSP/tool installer UI
- `:ConformInfo` — show active formatters for current buffer
- `:checkhealth` — diagnose config issues
- `:UpdateRemotePlugins` — required after installing molten-nvim

## Adding Plugins

Add a new file `lua/kickstart/plugins/myplugin.lua` returning a lazy.nvim spec, then `require()` it in `lua/lazy-plugins.lua`. Alternatively, add to `lua/custom/plugins/` and uncomment the `{ import = 'custom.plugins' }` line.
