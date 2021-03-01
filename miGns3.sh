#!/bin/bash

# To run gns3 with a pythin version 
# Install virtual environment : pyenv, virtualenv
# Install python version : pyenv install x.y.z
# Install gns3 gui : pip3 install gns3-gui ....
# Also upgrade tools : pip

echo "Number of params <" $# ">"
if [ $# -lt 1 ]
then
	echo "Usage : " "$0" " python_version_number"
	echo "Example : " "$0" " 3.6.10"
else


	cd "$HOME" || exit
	if [[ ! -d "$HOME/.pyenv"  ]];then
		if [ "$(git clone https://github.com/pyenv/pyenv.git ~/.pyenv)" -eq 0 ];then
			echo "Sucess installing pyenv ..."
		else
			echo "Error downloading pyenv"
			exit 1
		fi
	fi
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
	python_version=$1
	pyenv install "$python_version"
	pyenv global "$python_version"
	pip install --upgrade pip
	pip3 install virtualenv
	virtualenv -p python"$python_version" "$HOME"/private_python"$python_version"
	source "$HOME"/private_python"$python_version"/bin/activate
	pip3 install gns3-gui==2.1.21 PyQt5
	gns3
	rm -rf private_python"$python_version"
fi
