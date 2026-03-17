#!/bin/zsh

compress() {
	tar cvzf $1.tar.gz $1
}

# THIS ENTIRE THING IS BROKEN DO NOT USED THIS NEEDS TO BE FIXED
ftmuxp() {
	if [[ -n $TMUX ]]; then
		return
	fi

	# get IDs
	ID="$(ls ~/.config/tmuxp | sed -e 's/\.yml$//')"
	if [[ -z "$ID" ]]; then
		tmux new-session
	fi

	create_new_session="Create New Session"

	ID="${create_new_session}\n$ID"
	ID="$(echo $ID | fzf | cut -d: -f1)"

	if [[ "$ID" = "${create_new_session}" ]]; then
		tmux new-session
	elif [[ -n "$ID" ]]; then
		# WTF ARE U DOING
		printf '\033]777;tabbedx;set_tab_name;%s\007' "$ID"
		tmuxp load "$ID"
	fi
}

wikipedia() {
	lynx -vikeys -accept_all_cookies "https://en.wikipedia.org/wiki/$@"
}

duckduckgo() {
	lynx -vikeys -accept_all_cookies "https://lite.duckduckgo.com/lite/?q='$@'"
}

weather() {
  local location="${*:-}"
  curl -s "wttr.in/${location// /+}?u"
}

_ex() {
    case $1 in
        *.tar.bz2)  tar xjf $1      ;;
        *.tar.gz)   tar xzf $1      ;;
        *.bz2)      bunzip2 $1      ;;
        *.gz)       gunzip $1       ;;
        *.tar)      tar xf $1       ;;
        *.tbz2)     tar xjf $1      ;;
        *.tgz)      tar xzf $1      ;;
        *.zip)      unzip $1        ;;
        *.7z)       7z x $1         ;; # require p7zip
        *.rar)      7z x $1         ;; # require p7zip
        *.iso)      7z x $1         ;; # require p7zip
        *.Z)        uncompress $1   ;;
        *)          echo "'$1' cannot be extracted" ;;
    esac
}
