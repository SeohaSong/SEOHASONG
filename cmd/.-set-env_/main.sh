main()
{
    if [ -z "$( ps -ax | grep -v grep | grep sshd )" ]
    then
        sudo service ssh restart
    fi

    exe()
    {
        eval 'cmd.exe /c "$@"'
    }
}

main
