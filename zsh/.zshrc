autoload -Uz compinit; compinit

_comp_options+=(globdots)

fpath=($ZDOTDIR/external $fpath)
autoload -Uz prompt_purification_setup; prompt_purification_setup

# push current directory visited onto stack
setopt AUTO_PUSHD

# don't store duplicated in stack
setopt PUSHD_IGNORE_DUPS

# do no print directory stack after pushd/popd
setopt PUSHD_SILENT

bindkey -v
export KEYTIMEOUT=1

# Vim mapping for completion menu cuz everything is vim these days
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

# clear shell
bindkey -r '^l'
bindkey -r '^g'
bindkey -s '^g' 'clear\n'

# bd source
source ~/.config/zsh/external/bd.zsh


# fuzzy finder
if [ $(command -v "fzf") ]; then
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh
fi

# source things?
source ~/.config/zsh/aliases
source ~/.config/zsh/scripts.sh

# for things
export PATH="$HOME/.cargo/bin:$PATH"
# syntax highlighting, needs to be at bottom
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

