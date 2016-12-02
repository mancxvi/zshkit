if which pyenv > /dev/null; then
    eval "$(pyenv init -)";
fi
function python-version-prompt () {
    python_version=`pyenv version-name`
    if [[ $python_version != "system" ]]; then
	    echo "py:$python_version ";
    fi
}
