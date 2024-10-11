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
export HISTTIMEFORMAT="%F %T "

# auto append every command in the history file - https://askubuntu.com/a/67306
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

################################################################################
# git
source /usr/share/git-core/contrib/completion/git-prompt.sh

alias gs='git status'
alias ga='git add'
alias gcm='git commit -m'
alias gf='git diff'

# ref. https://git-scm.com/book/id/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Bash
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w \[\033[01;36m\][$(jobcount)] $(__git_ps1 " (%s)")\$\[\033[00m\] '

################################################################################
# aliases
alias ll="ls -la --group-directories-first --color=auto"
#alias jazz='vlc https://listen.radiocoalition.org/b22139_128mp3 --daemon'
alias jazz='vlc https://bcast.vigormultimedia.com:48888/sjcompl192aac --daemon'
alias jazzfm='vlc https://cdn.bweb.bg/radio/jazz-fm.mp3 --daemon'
alias myip='curl eth0.me'
#alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias usd='curl -s www.bnb.bg | grep USD | awk -F'"'"'[<|>]'"'"' '"'"'{ print $11 }'"'"' | awk '"'"'{ print $1 }'"'"
alias gbp='curl -s www.bnb.bg | grep GBP | awk -F'"'"'[<|>]'"'"' '"'"'{ print $11 }'"'"' | awk '"'"'{ print $1 }'"'"

if [ -x /usr/games/cowsay -a -x /usr/games/fortune ]; then
   fortune | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1)
fi

################################################################################
# google cloud
#export USE_GKE_GCLOUD_AUTH_PLUGIN=True
#if [ -f $HOME/.googlerc ]; then
#  source $HOME/.googlerc
#fi
#
#################################################################################
## kubectl
#source <(kubectl completion bash)
#alias k=kubectl
#complete -o default -F __start_kubectl k
#if [ -f /opt/kube-ps1/kube-ps1.sh ]; then
#  source /opt/kube-ps1/kube-ps1.sh
#  export PS1='$(kube_ps1)'-$PS1
#fi
#
#################################################################################
## terraform
#alias tf=terraform
#export PATH="$HOME/.tfenv/bin:$PATH"
#
#. <(flux completion bash)
