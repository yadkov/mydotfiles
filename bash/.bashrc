# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w \$\[\033[00m\] '
# Bash editor vi style
set -o vi
export EDITOR=vim
xbindkeys

alias ll="ls -la --group-directories-first"
alias tor='torbrowser-launcher'
alias hma='hma-vpn.sh -c ~/.config/hma.conf -d'
alias jazz='vlc http://streaming.radionomy.com/101SMOOTHJAZZ?lang=en-US%2cen%3bq%3d0.5 --daemon'
alias myip='curl eth0.me'
