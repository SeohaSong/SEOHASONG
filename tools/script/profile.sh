paths=$( echo "${PATH//':'/$'\n'}" | sort | uniq )
export PATH=${paths//$'\n'/':'}
unset paths
case ${HOSTNAME%.*} in
"SEOHASONG-S0")
    export HOME_PATH=/mnt/c/Users/seohasong
    export DOCKER_HOME_PATH=/c/Users/seohasong
    export HOST_HOME_PATH=/Users/seohasong
    export PROFILE_PATH=/home/seohasong/.profile
    file=$( dirname $BASH_SOURCE )/PATH.txt
    if [ -z $SSH_TTY ]
    then echo $PATH > $file
    else export PATH=$( cat $file )
    fi
    unset file
    chk=$( ps -ax | grep -v grep | grep sshd )
    if [ "$chk" == "" ]; then sudo service ssh restart; fi
    unset chk
;;
esac

# built in function
(
    str=". $HOME_PATH/SEOHASONG/env/profile.sh"
    txt=$( cat $PROFILE_PATH | grep -v "$str" )
    echo "$txt" > $PROFILE_PATH
    echo "$str" >> $PROFILE_PATH
)

if ! [[ "$-" =~ "i" ]]; then return; fi
export CLICOLOR=1
export PS1="\[\e[1;30m\]\u\[\e[0m\]@\[\e[1;31m\]\h\[\e[0m\]:\[\e[1;32m\]\w\[\e[0m\]\$"
alias seohasong="cd $HOME_PATH/SEOHASONG"
shs() {
    $HOME_PATH/SEOHASONG/shs.sh $@
}
