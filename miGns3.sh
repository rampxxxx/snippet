export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

echo "Number of params <" $# ">"
if [ $# -lt 1 ]
then
	echo "Usage : " $0 " python_version_number"
	echo "Example : " $0 " 3.6.10"
else


	python_version=$1
	pyenv install $python_version
	pyenv global $python_version
	pip install --upgrade pip
	pip3 install virtualenv
	virtualenv -p python$python_version ./private_python$python_version
	source ./private_python$python_version/bin/activate
	pip3 install gns3-gui==2.1.21 PyQt5
	gns3
	rm -rf private_python$python_version
fi
