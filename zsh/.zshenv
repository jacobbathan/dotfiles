# Dotfiles
export XDG_CONFIG_HOME="$HOME/.config"

# Specific Data
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"

# Cached files
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

export EDITOR="nvim"
export VISUAL="nvim"

export FZF_DEFAULT_COMMAND="rg --files --hiden --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# History filepath
export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

. "$HOME/.cargo/env"
