#export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit



test -s ~/.alias && . ~/.alias || true
set -o vi


# START alias
alias l='ls -lartF'
## FFR formatting
alias frr_clang='git clang-format-10.0.0 HEAD~1'
# END alias
alias st='git status'

export PATH=~/Dropbox/script:$PATH # cloud scripts
export PATH=/home/ramp/.local/bin:$PATH # pip env
export PATH=/home/ramp/bin:$PATH # Local utilities
export PATH=/home/ramp/bin/cov-analysis-linux64-2020.09/bin:$PATH # coverity

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



if [ "$SSH_TTY" ]
then
	if [ -x /usr/bin/cowsay -a -x /usr/bin/fortune ]; then
		fortune | cowsay
	fi
#else
	# Tooooo slow in x86 but in arm :-O
	#if [ -x "$(command -v screenfetch)" ]; then
	#	screenfetch
	#elif [ -x "$(command -v neofetch)" ]; then
	#	neofetch
	#fi
fi

### kernel stuff: build scope db, ...
export TMPDIR=~/tmp # To use /home fs instead of root that is bloated.
ulimit -c unlimited # To allow create core


### bash git prompt
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    GIT_PROMPT_SHOW_UPSTREAM=1
    GIT_PROMPT_THEME="TruncatedPwd_WindowTitle"
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

# START sonar
export PATH=/home/jg/volta/sonar_local/sonar-scanner-4.2.0.1873-linux/bin:$PATH
# END sonar

# INI : pyenv config
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# END : pyenv config
