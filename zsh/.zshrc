# sources
source "$XDG_CONFIG_HOME/zsh/aliases"

# completion
autoload -U compinit; compinit

# auto complete hidden files too
_comp_options+=(globdots)
source ~/dotfiles/zsh/external/completion.zsh

# Search this directory for autoloaded functions
fpath=($ZDOTDIR/external $fpath)

# prompt tingz
autoload -Uz prompt_purification_setup; prompt_purification_setup

# push current directory visited onto stack
setopt AUTO_PUSHD

# don't store duplicated in stack
setopt PUSHD_IGNORE_DUPS

# do no print directory stack after pushd/popd
setopt PUSHD_SILENT

# Vi mode
bindkey -v
export KEYTIMEOUT=1

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# cursor mode
autoload -Uz cursor_mode && cursor_mode

# edit commands in nvim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# fuzzy finder
if [ $(command -v "fzf") ]; then
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh
fi

# auto start i3
if [ "$(tty)" = "/dev/tty1" ];
then
    pgrep i3 || exec startx "$XDG_CONFIG_HOME/X11/.xinitrc"
fi

source $DOTFILES/zsh/external/bd.zsh

source $DOTFILES/zsh/scripts.sh

ftmuxp

# Clearing the shell is now done with CTRL+g
bindkey -r '^l'
bindkey -r '^g'
bindkey -s '^g' 'clear\n'

# scripts
# syntax highlighting, needs to be at bottom
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 
