# .bashrc
[ -z "$PS1" ] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
################################################################################
# PS1 modification
function jobcount {
   stopped="$(jobs -s | wc -l | tr -d " ")"
   running="$(jobs -r | wc -l | tr -d " ")"
   echo -n "${running}r/${stopped}s"
}

PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w \[\033[01;36m\][$(jobcount)] \$\[\033[00m\] '


################################################################################
# some defaults
export PATH=$PATH:~/.local/bin
export EDITOR=vim

# Performing calculations
calc()
{
	echo "scale=2;${1}" | bc -l
}

################################################################################
# alt+. paste last argument
bind '"\e."':yank-last-arg
bind -m vi-insert "\C-l.":clear-screen
bind -m vi-insert "\C-a.":beginning-of-line
bind -m vi-insert "\C-e.":end-of-line
bind -m vi-insert "\C-w.":backward-kill-word

# C+l clear screen
bind -m vi-insert "\C-l":clear-screen 


################################################################################
## Manage bash history
# set to never delete history
export HISTSIZE=-1
export HISTFILESIZE=-1

# auto append every command in the history file - https://askubuntu.com/a/67306
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

################################################################################
# git
alias gs='git status'
alias ga='git add'
alias gcm='git commit -m'
alias gf='git diff'

################################################################################
# aliases
alias ll="ls -la --group-directories-first --color=auto"
alias jazz='flatpak run org.videolan.VLC http://streaming.radionomy.com/101SMOOTHJAZZ?lang=en-US%2cen%3bq%3d0.5 --daemon'
alias myip='curl eth0.me'
#alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias usd='curl -s www.bnb.bg | grep USD | awk -F'"'"'[<|>]'"'"' '"'"'{ print $11 }'"'"' | awk '"'"'{ print $1 }'"'"
alias gbp='curl -s www.bnb.bg | grep GBP | awk -F'"'"'[<|>]'"'"' '"'"'{ print $11 }'"'"' | awk '"'"'{ print $1 }'"'"
