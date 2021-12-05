# dotfiles
export XDG_CONFIG_HOME="$HOME/.config"

# specfic data
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"

# cached files
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# editor
export EDITOR="nvim"
export VISUAL="nvim"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# history filepath
export HISTFILE="$ZDOTZIR/.zhistory"

# max events for internal history
export HISTZISE=10000

# max events for history file
export SAVEHIST=10000

# fzf now uses ripgrep get in there lads
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export DOTFILES="$HOME/dotfiles"
