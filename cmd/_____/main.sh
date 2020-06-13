local chk="$( ps -ax | grep -v grep | grep sshd )"
if [ -z "$chk" ]; then sudo service ssh restart; fi
alias seohasong="cd $DDD_PATH"
