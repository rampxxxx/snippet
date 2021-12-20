#export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit



test -s ~/.alias && . ~/.alias || true
set -o vi


LOCAL_ID=$(grep -w ID /etc/os-release|awk -F= '{print $2}'|awk -F\" '{print $2}') # TO adapt to the distro
echo "La distro es " $LOCAL_ID
if [ "$LOCAL_ID" = "rhel" ]; 
then
	echo "Adapting rhel"
	export PS1='\u:\w>'
else
	echo "Adapting unkown distro " $LOCAL_ID
fi


# START alias
alias l='ls -lartF'
## FFR formatting
alias frr_clang='git clang-format-10.0.0 HEAD~1'
# END alias
alias st='git status'

export PATH=~/Dropbox/script:$PATH # cloud scripts
export PATH=~/.local/bin:$PATH # pip env
export PATH=~/bin:$PATH # Local utilities
export PATH=~/bin/cov-analysis-linux64-2020.09/bin:$PATH # coverity

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


# START git prompt
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    GIT_PROMPT_SHOW_UPSTREAM=1
    GIT_PROMPT_THEME="TruncatedPwd_WindowTitle"
    source $HOME/.bash-git-prompt/gitprompt.sh
fi
# END git prompt

# START git completion
# In rhel seems no have this , so copy from opensuse and source
if [ -f "$HOME/bin/git.sh" ]; then
    source $HOME/bin/git.sh
fi
# END git completion

# START sonar
export PATH=~/volta/sonar_local/sonar-scanner-4.2.0.1873-linux/bin:$PATH
# END sonar

# INI : pyenv config
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"
# END : pyenv config

# START GOLANG
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin # IS REALLY NECESSARY
export PATH=~/ibm/go-1.17.3/go/bin:$PATH:$GOBIN # Point to local 1.17
# END GOLANG

# START ltex markdown lsp server
export PATH=~/bin/ltex-ls-15.2.0/bin:$PATH
# END ltex markdown lsp server

# START protocol utility,create ascii headers
export PATH=~/bin/protocol:$PATH
# END protocol utility,create ascii headers

# START fzf bash completion
source /usr/share/bash-completion/completions/fzf-key-bindings && source /usr/share/bash-completion/completions/fzf
# END fzf bash completion


# START TERRAFORM
terraform -install-autocomplete
complete -C ~/bin/terraform terraform
# END TERRAFORM



#export DRI_PRIME=0 #Used to use only gpu #0 but now rhel/lenovo is boot with nvidia blacklisted

complete -C ~/bin/terraform terraform


complete -C /home/jg/bin/terraform terraform
