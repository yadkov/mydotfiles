# .bashrc

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
export EDITOR=vim

# needed for custom shortcuts
if [ command -v xbindkeys ]
then
	xbindkeys
fi

# Performing calculations
calc()
{
	echo "scale=2;${1}" | bc -l
}

################################################################################
## Set Bash vi style
set -o vi

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

#this section is for having persistent history on my bash
# copied from http://eli.thegreenplace.net/2013/06/11/keeping-persistent-history-in-bash

log_bash_persistent_history()
{
  local rc=$?
  [[ $(history 1) =~ ^\ *[0-9]+\ +([^\ ]+\ [^\ ]+)\ +(.*)$ ]]
  local date_part="${BASH_REMATCH[1]}"
  local command_part="${BASH_REMATCH[2]}"
  if [ "$command_part" != "$PERSISTENT_HISTORY_LAST" ]
  then
    echo $date_part "|" "$command_part" >> ~/.persistent_history
    export PERSISTENT_HISTORY_LAST="$command_part"
  fi
}

# Stuff to do on PROMPT_COMMAND
run_on_prompt_command()
{
    log_bash_persistent_history
}

# history -a is to append it to history
PROMPT_COMMAND="history -a;run_on_prompt_command"


################################################################################
# aliases
alias ll="ls -la --group-directories-first"
alias jazz='rhythmbox-client --play-uri=http://streaming.radionomy.com/101SMOOTHJAZZ?lang=en-US%2cen%3bq%3d0.5'
#alias jazz='vlc http://streaming.radionomy.com/101SMOOTHJAZZ?lang=en-US%2cen%3bq%3d0.5 --daemon'
alias myip='curl eth0.me'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias usd='curl -s www.bnb.bg | grep USD | awk -F'"'"'[<|>]'"'"' '"'"'{ print $11 }'"'"' | awk '"'"'{ print $1 }'"'"
alias gbp='curl -s www.bnb.bg | grep GBP | awk -F'"'"'[<|>]'"'"' '"'"'{ print $11 }'"'"' | awk '"'"'{ print $1 }'"'"
alias IE11="vboxmanage startvm IE11"
