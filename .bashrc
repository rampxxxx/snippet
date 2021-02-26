#export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit



test -s ~/.alias && . ~/.alias || true
set -o vi



alias l='ls -lartF'


export PATH=~/Dropbox/script:$PATH # cloud scripts
export PATH=/home/ramp/.local/bin:$PATH # pip env
export PATH=/home/ramp/bin:$PATH # Local utilities

export HISTSIZE=10000


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

# INI : pyenv config
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# END : pyenv config
