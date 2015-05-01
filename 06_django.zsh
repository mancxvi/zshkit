if [[ -x `which django-admin` ]]; then

	alias dj-new='django-admin startproject'
	
	function dj() {
		if [[ -x `ls | grep manage.py` ]]; then
			case $1 in
				run)
					python manage.py runserver 0.0.0.0:8000
					;;
				sa)
					python manage.py startapp $2
					;;
				*)
					python manage.py $@
					;;
			esac
		else
			echo 'manage.py not found, not in django directory'
		fi
	}
fi
