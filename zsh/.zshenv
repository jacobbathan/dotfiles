# Dotfiles
export XDG_CONFIG_HOME="$HOME/.config"

# XDG spec: data files go in ~/.local/share
export XDG_DATA_HOME="$HOME/.local/share"

# Cached files
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# NOTE: EDITOR and VISUAL are intentionally NOT set here.
# They are set in .zshrc with context-sensitivity:
#   - inside a Neovim terminal buffer: nvr (neovim-remote)
#   - everywhere else: nvim
# Setting them here would override that logic in subshells.

export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# History filepath
export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

. "$HOME/.cargo/env"
