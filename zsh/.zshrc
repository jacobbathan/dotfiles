source "$XDG_CONFIG_HOME/zsh/aliases"

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

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
# Sourcing in langauges
source "$HOME/.cargo/env"


source ~/.config/zsh/scripts.sh
source ~/.config/zsh/external/bd.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"


export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.local/bin:$PATH"

. "$HOME/.config/local/share/../bin/env"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# bun completions
[ -s "/home/antigo/.bun/_bun" ] && source "/home/antigo/.bun/_bun"


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/antigo/.opam/opam-init/init.zsh' ]] || source '/home/antigo/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration
