# shellcheck disable=SC1090,SC1091,SC2148


export EDITOR=nvim

node_version_manager_config() {
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
}
#export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit

set -o vi

if [ "$SSH_TTY" ] || [ "$DISPLAY" ]; then
	LOCAL_ID=$(grep -w ID /etc/os-release | awk -F= '{print $2}') # TO adapt to the distro
	echo "La distro es  $LOCAL_ID"
	if [ "$LOCAL_ID" = "\"rhel\"" ]; then
		echo "Adapting rhel"
		export PS1='\u:\w>'
	elif [ "$LOCAL_ID" = "debian" ]; then
		echo "Adapting debian"
		# in debian nvim appimage need extracto to squash,
		export PATH=~/bin/squashfs-root/usr/bin:$PATH
	elif [ "$LOCAL_ID" = "fedora" ]; then
		echo "Adapting fedora"
		export PS1='\u:\w>'
	else
		echo "Adapting unkown distro  $LOCAL_ID"
	fi
fi

if [ -f "$HOME/ibm/.env.sh" ]; then
	# Adapt all env vars,etc for go devel
	source ~/ibm/.env.sh
fi

# START alias
alias l='ls -lartF'
## FFR formatting
alias frr_clang='git clang-format-10.0.0 HEAD~1'
## git alias
alias gs='git status; ls *\.go 2>/dev/null  || ls *\.c 2>/dev/null || ls *\.cpp 2>/dev/null || ls *\.sh 2>/dev/null && echo "Src files in repo root BE Careful" '
alias gl='git log'
alias gls='git log -5 --pretty=format:"%h %s"'
alias gd='git diff'
alias st='git status'
alias j='jobs'
# END alias

export PATH=~/Dropbox/script:$PATH                       # cloud scripts
export PATH=~/.local/bin:$PATH                           # pip env
export PATH=~/bin:$PATH                                  # Local utilities
export PATH=~/bin/cov-analysis-linux64-2020.09/bin:$PATH # coverity

# START : History between terminals sync
# Avoid duplicates
HISTCONTROL=ignoredups:erasedups # Add ignorespace to avoid adding cmd's starting with space
export HISTSIZE=100000           # big big history
export HISTFILESIZE=100000       # big big history
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
# END : History between terminals sync
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

if [ "$SSH_TTY" ]; then
	if [ -x /usr/bin/cowsay ] && [ -x /usr/bin/fortune ]; then
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
export TMPDIR=~/tmp && mkdir -p $TMPDIR || echo "====>>>> Cannot crate $TMPDIR <<<<=====" # To use /home fs instead of root that is bloated.
ulimit -c unlimited                                                                       # To allow create core

# START git prompt
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
	# shellcheck disable=SC2034
	GIT_PROMPT_ONLY_IN_REPO=1
	# shellcheck disable=SC2034
	GIT_PROMPT_SHOW_UPSTREAM=1
	# shellcheck disable=SC2034
	GIT_PROMPT_THEME="TruncatedPwd_WindowTitle"
	source "$HOME/.bash-git-prompt/gitprompt.sh"
fi
# END git prompt

# START git completion
# In rhel seems no have this , so copy from opensuse and source
if [ -f "$HOME/bin/git.sh" ]; then
	source "$HOME/bin/git.sh"
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
export PATH=$GOBIN:$PATH # Point to local 1.17
# END GOLANG

# START ltex markdown lsp server
export PATH=~/bin/ltex-ls-15.2.0/bin:$PATH
# END ltex markdown lsp server

# START protocol utility,create ascii headers
export PATH=~/bin/protocol:$PATH
# END protocol utility,create ascii headers

if [ "$SSH_TTY" ] || [ "$DISPLAY" ]; then
	# fzf bash completion
	[ -f /etc/profile.d/fzf-bash.sh ] && source /etc/profile.d/fzf-bash.sh # zypper
	[ -f ~/.fzf.bash ] && source ~/.fzf.bash                               # github
	# END fzf bash completion
	[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm" && gvm list
	# gh generate completion https://cli.github.com/manual/gh_completion
	eval "$(gh completion -s bash)"
	node_version_manager_config
fi

# gh generate completion https://cli.github.com/manual/gh_completion
if [ "$SSH_TTY" ] || [ "$DISPLAY" ]; then
	eval "$(gh completion -s bash)"
fi

# k8s better environment.
if type kubectl >/dev/null 2>&1; then
	# kubectl autocompletion
	eval "$(kubectl completion bash)"
	# Prompt with context/cluster/namespace
	function setK8sPrompt() {
		if [ ! -d .git ]; then # Avoid clash with git prompt
			k8sprompt=$(kubectl config get-contexts | grep "^\*" | awk '{print substr($5,1,10)"/"substr($3,1,10)}')
			export PS1="[\u@\h \w]-\<$k8sprompt\>"
		fi
	}
	PROMPT_COMMAND="$PROMPT_COMMAND;setK8sPrompt"
fi

# START rust
# ...set PATH to toolchain by hand :-(
export PATH=~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin:$PATH

# END rust

# START nvim , from nvim site package instead rpm,etc?
export PATH=/opt/nvim-linux64/bin:$PATH
# END nvim

# source /etc/bash_completion.d/hzn_bash_autocomplete.sh # Horizon agent autocomplete, not using now
#
#


# INI JWT utils https://gist.github.com/thomasdarimont/46358bc8167fce059d83a1ebdb92b0e7
decode_base64_url() {
  local len=$((${#1} % 4))
  local result="$1"
  if [ $len -eq 2 ]; then result="$1"'=='
  elif [ $len -eq 3 ]; then result="$1"'=' 
  fi
  echo "$result" | tr '_-' '/+' | openssl enc -d -base64
}

decode_jwt(){
   decode_base64_url $(echo -n $2 | cut -d "." -f $1) | jq .
}

# Decode JWT header
alias jwth="decode_jwt 1"

# Decode JWT Payload
alias jwtp="decode_jwt 2"

# Example jwtp eyJhbGciOiJSUzI1NiIsInR5.....   # Payload
# Example jwtp eyJhbGciOiJSUzI1NiIsInR5.....   # Header

# END JWT utils
