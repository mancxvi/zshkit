if [[ -x `which thefuck` ]]; then
	alias fuck='$(thefuck $(fc -ln -1))'
fi
