source "$XDG_CONFIG_HOME/zsh/aliases"

# NOTE: zmodload and menuselect bindings live in external/completion.zsh.
# They are NOT duplicated here — completion.zsh is sourced below and owns them.

autoload -U compinit; compinit

# autocomplete hidden files
_comp_options+=(globdots)
source ~/.config/zsh/external/completion.zsh

fpath=($ZDOTDIR/external $fpath)
autoload -Uz prompt_purification_setup; prompt_purification_setup

setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

bindkey -v
export KEYTIMEOUT=1

bindkey -r '^l'
bindkey -r '^g'
bindkey -s '^g' 'clear\n'

autoload -Uz cursor_mode && cursor_mode

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Emacs eshell + eat
[ -n "$EAT_SHELL_INTEGRATION_DIR" ] && \
  source "$EAT_SHELL_INTEGRATION_DIR/zsh"

if [ $(command -v "fzf") ]; then
	source /usr/share/fzf/completion.zsh
	source /usr/share/fzf/key-bindings.zsh
fi

# SO I KNOW WHERE THE FUCK I AM
PROMPT='%n@%~$ '

export GOROOT=
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

# Cargo — explicit path, not relative to XDG_DATA_HOME
source "$HOME/.cargo/env"

source ~/.config/zsh/scripts.sh
source ~/.config/zsh/external/bd.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PATH="$HOME/.local/bin:$PATH"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "/home/antigo/.bun/_bun" ] && source "/home/antigo/.bun/_bun"

# BEGIN opam configuration
[[ ! -r '/home/antigo/.opam/opam-init/init.zsh' ]] || source '/home/antigo/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

# =============================================================================
# Neovim + tmux
# =============================================================================

# EDITOR / VISUAL — context-sensitive.
# Inside a Neovim terminal buffer ($NVIM is set by nvim for all children),
# use nvr to open files in the existing instance instead of nesting.
# Install: pip install neovim-remote  (lands in ~/.local/bin, already in PATH)

if [ -n "$NVIM" ]; then
    export VISUAL="nvr -cc split --remote-wait"
    export EDITOR="nvr -cc split --remote-wait"
    alias nvim="nvr -cc split --remote-wait"
else
    export VISUAL="nvim"
    export EDITOR="nvim"
fi

# Prompt indicator when inside a Neovim terminal buffer
if [ -n "$NVIM" ]; then
    PROMPT="%F{yellow}[nvim]%f $PROMPT"
fi

# Auto-attach to tmux on new terminal.
# Creates a session named 'main' if none exists.
# Guards: interactive only, not already in tmux, not inside nvim terminal.
if command -v tmux &>/dev/null && [ -z "$TMUX" ] && [ -z "$NVIM" ]; then
    tmux attach-session -t main 2>/dev/null || tmux new-session -s main
fi
