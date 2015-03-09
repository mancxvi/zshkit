if [[ -x `which git` ]]; then
	git_enable=1

	alias g=git
	alias gco=git-checkout
	alias gb=git-branch
	alias gam='git-commit -a -m '

	function git-branch-name () {
		git branch 2> /dev/null | grep '^\*' | sed 's/^\*\ //'
	}
	function git-dirty () {
		git status 2> /dev/null | grep "nothing to commit"
		echo $?
	}
	function gsrb () {
		branch=$(git-branch-name) 
		git checkout master
		git svn rebase
		git checkout "${branch}"
		git rebase master
	}
  function git-need-to-push() {
    if pushtime=$(echo $1 | grep 'Your branch is ahead' 2> /dev/null); then
      echo "↑"
    fi
  }
  function git-toggle() {
		if [[ $git_enable = 1 ]]; then
			git_enable=0
		else
			git_enable=1
		fi
	}
	function git-prompt() {
		dirty_color=$fg[cyan]
		if [[ $git_enable = 1 ]]; then
			gstatus=$(git status 2> /dev/null)
      push_status=$(git-need-to-push $gstatus 2> /dev/null)
			branch=$(echo $gstatus | head -1 | sed 's/^On branch //')
			dirty=$(echo $gstatus | sed 's/^#.*$//' | tail -2 | grep 'nothing to commit'; echo $?)
			if [[ x$branch != x ]]; then
				if [[ $dirty = 1 ]] { dirty_color=$fg[magenta] }
				[ x$branch != x ] && echo "%{$dirty_color%}$branch%{$reset_color%} $push_status"
			fi
		else
			echo "%{$dirty_color%}!%{$reset_color%} "
		fi
	}
	function git-scoreboard () {
		git log | grep '^Author' | sort | uniq -ci | sort -r
	}
	function git-track () {
		branch=$(git-branch-name)
		git config branch.$branch.remote origin
		git config branch.$branch.merge refs/heads/$branch
		echo "tracking origin/$origin"
	}
	function github-init () {
		git config branch.$(git-branch-name).remote origin
		git config branch.$(git-branch-name).merge refs/heads/$(git-branch-name)
	}
	
	function github-url () {
		git config remote.origin.url | sed -En 's/git(@|:\/\/)github.com(:|\/)(.+)\/(.+).git/https:\/\/github.com\/\3\/\4/p'
	}
	
	# Seems to be the best OS X jump-to-github alias from http://tinyurl.com/2mtncf
	function github-go () {
		open $(github-url)
	}
	
	function nhgk () {
		nohup gitk --all &
	}
fi
