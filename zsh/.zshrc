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
