# Sample .bashrc for SUSE Linux
# Copyright (c) SUSE Software Solutions Germany GmbH

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.
export PS1="\u@\h`cat quien.txt`:\w>"

test -s ~/.alias && . ~/.alias || true
set -o vi
export PATH=~/Dropbox/script:~/bin:$PATH
export PATH=/home/jg/.local/bin:$PATH

# START sonar
export PATH=/home/jg/volta/sonar_local/sonar-scanner-4.2.0.1873-linux/bin:$PATH
# END sonar


if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
fi



# START : History between terminals sync
# Avoid duplicates
HISTCONTROL=ignoredups:erasedups  
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
# END : History between terminals sync
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8


alias l='ls -lartF'

## FFR formatting
alias frr_clang='git clang-format-10.0.0 HEAD~1'
