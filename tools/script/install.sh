(
    raise-e() {
        error_code=$?
        lineno=$1
        echo "[SHS] Error on line $lineno. ($error_code)"
        case $error_code in
        3) echo "[SHS] The required conditions are not met." ;;
        4) echo "[SHS] Argument error." ;;
        esac
        ! [ "$pid" == "" ] && kill $pid
        exit 1
    }
    reset-script() {
        trap 'raise-e $LINENO' ERR
        [ "$1" == "" ] && return 4
        filepath=$1
        bak_path=$filepath.bak
        [ -f "$bak_path" ] && sudo cp "$bak_path" "$filepath" || sudo cp "$filepath" "$bak_path"
    }
    replace-line() {
        trap 'raise-e $LINENO' ERR
        [ "$1" == "" -o "$2" == "" ] && return 4
        filepath=$1 keyword=$2 line=$3
        [ "$line" == "" ] && line=$keyword || :
        tmp_path=$filepath.tmp
        grep -v "$keyword" "$filepath" | sudo tee $tmp_path > /dev/null
        cat $tmp_path | sudo tee "$filepath" > /dev/null
        echo $line | sudo tee -a "$filepath" > /dev/null
        sudo rm $tmp_path
    }
    _download() {
        trap 'raise-e $LINENO' ERR
        [ "$1" == "" -o "$2" == "" ] && return 4
        url=$1 home_path=$2
        filename=$( basename $url )
        filename=${filename//'%20'/' '}
        filepath=$home_path/SEOHASONG/env/$filename
        curl $url -L -o "$filepath"
        tar -xvf "$filepath" -C "$( dirname $filepath )"
        rm "$filepath"
    }
    _native-download() {
        trap 'raise-e $LINENO' ERR
        [ "$1" == "" -o "$2" == "" -o "$3" == "" ] && return 4
        url=$1 home_path=$2 host_home_path=$3
        filename=$( basename $url )
        filename=${filename//'%20'/' '}
        filepath=$home_path/SEOHASONG/env/$filename
        host_filepath=$host_home_path/SEOHASONG/env/$filename
        curl $url -L -o "$filepath"
        case ${url##*.} in
        'exe'|'msi') cmd.exe /c "$host_filepath" || : ;;
        'pkg') open -W "$host_filepath" ;;
        esac
        rm "$filepath"
    }

    check-prerequisite() {
        trap 'raise-e $LINENO' ERR
        [ "$pid" == "" ] && return 3
        [ "$HOSTNAME" == "SEOHASONG-S0" -o "$HOSTNAME" == "SEOHASONG-S1.local" ] || return 3
        # ssh -oStrictHostKeyChecking=no seohasong@crush-on.info "ls" || return 3
        ( cd $( dirname "$BASH_SOURCE" ) && git submodule init && git submodule update )
    }
    install-env() {
        trap 'raise-e $LINENO' ERR
        home_path=$( dirname $( cd $( dirname "$BASH_SOURCE" ) && pwd ) )
        home_script=~/.bashrc
        std_hostname=${HOSTNAME%.*}
        case $std_hostname in
        "SEOHASONG-S0")
            sudo apt update -y
            sudo apt upgrade -y
            sudo apt autoremove -y
            tmp_home_path=${home_path#*/}
            docker_home_path=/${tmp_home_path#*/}
            tmp_home_path=${tmp_home_path#*/}
            host_home_path=/${tmp_home_path#*/}
            os_name=Windows
            # conda_url='https://repo.anaconda.com/archive/Anaconda3-2019.03-Windows-x86_64.exe'
            # docker_url='https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe'
        ;;
        "SEOHASONG-S1")
            [ -f ~/.profile ] || echo "[ -f $home_script ] && . $home_script || :" > .profile
            docker_home_path=$home_path
            host_home_path=$home_path
            os_name=macOS
        ;;
        esac
        [ -f "$home_script" ] || touch $home_script
        reset-script "$home_script"
        sudo rm "$home_script.bak"
        reset-script "$home_script"
        replace-line "$home_script" ". $home_path/SEOHASONG/profile.sh"
        replace-line "$home_script" ". $home_path/SEOHASONG/install.sh 1"
        sub_profile_path=$home_path/SEOHASONG/env/profile-$( uname ).sh
        echo "export OS_NAME=$os_name" > "$sub_profile_path"
        echo "export HOME_PATH=$home_path" >> "$sub_profile_path"
        echo "export DOCKER_HOME_PATH=$docker_home_path" >> "$sub_profile_path"
        echo "export HOST_HOME_PATH=$host_home_path" >> "$sub_profile_path"
        echo "export HOME_SCRIPT=$home_script" >> "$sub_profile_path"
        [ "$std_hostname" == "SEOHASONG-S0" ] && {
            trap 'raise-e $LINENO' ERR
            sudo ssh-keygen -A
            reset-script "/etc/ssh/sshd_config"
            replace-line "/etc/ssh/sshd_config" "PasswordAuthentication" "PasswordAuthentication yes"
            replace-line "/etc/ssh/sshd_config" "Port" "Port 2201"
            sudo service ssh restart
        } &
        # [ "$std_hostname" == "SEOHASONG-S0" ] && {
        #     trap 'raise-e $LINENO' ERR
        #     ssh seohasong@crush-on.info "
        #         eval '$( type raise-e | tail -n +2 )'
        #         eval '$( type reset-script | tail -n +2 )'
        #         eval '$( type replace-line | tail -n +2 )'
        #         reset-script /etc/ssh/sshd_config
        #         replace-line /etc/ssh/sshd_config GatewayPorts 'GatewayPorts yes'
        #         sudo service ssh restart
        #         sudo hostname SEOHASONG-N
        #     "
        # } &
        {
            trap 'raise-e $LINENO' ERR
            reset-script "/etc/ssh/ssh_config"
            replace-line "/etc/ssh/ssh_config" "ServerAliveInterval" "ServerAliveInterval 60"
        } &
        {
            trap 'raise-e $LINENO' ERR
            echo "
                syntax on
                set ruler
                set showmatch
                set encoding=utf8
                set tabstop=4
            " > ~/.vimrc
        } &
        case $std_hostname in
        "SEOHASONG-S0")
            :
            # [ -d "$home_path/Anaconda3" ] || _native-download $conda_url $home_path $host_home_path &
            # docker.exe --version 2> /dev/null || _native-download $docker_url $home_path $host_home_path &
        ;;
        "SEOHASONG-S1") : ;;
        esac
        wait
    }

    update-env() {
        trap 'raise-e $LINENO' ERR
        env_dir_path=$HOME_PATH/SEOHASONG/env
        sub_profile_path=$env_dir_path/profile-$( uname ).sh
        dir_paths=$( ls -d "$env_dir_path"/*/ 2> /dev/null || : )
        [ "$dir_paths" != "" ] && path=${dir_paths//$'\n'/'bin:'}bin:$PATH || path=$PATH
        paths=$( echo "${path//':'/$'\n'}" | sort | uniq )
        export PATH=${paths//$'\n'/':'}
        echo 'export PATH=$PATH:"'$PATH'"' >> "$sub_profile_path"
    }
    install-conda() {
        trap 'raise-e $LINENO' ERR
        cd $HOME_PATH/SEOHASONG
        shs run prompt "conda update --all"
        shs run prompt "pip uninstall --yes shs"
        shs run prompt "pip install $HOST_HOME_PATH/SEOHASONG/scripts/PYTHON"
        jupyter_dir_path=$HOME_PATH/.jupyter
        jupyter_config_path=$jupyter_dir_path/jupyter_notebook_config.py
        jupyter_pw="sha1:e7e60b06724f:66c594d4dc2b2e13f2cd1144c0081e7c5ef955cc"
        [ -d "$jupyter_dir_path" ] && rm -r "$jupyter_dir_path"
        shs run prompt "jupyter-notebook --generate-config"
        replace-line "$jupyter_config_path" "c.NotebookApp.password" "c.NotebookApp.password = '$jupyter_pw'"
        replace-line "$jupyter_config_path" "c.NotebookApp.allow_remote_access" "c.NotebookApp.allow_remote_access = True"
    }
    install-container() {
        trap 'raise-e $LINENO' ERR
        cd $HOME_PATH/SEOHASONG
        shs clear docker
        [ "$( docker.exe images | grep seohasong )" != "" ] || {
            docker.exe build -t seohasong $HOST_HOME_PATH/SEOHASONG/scripts/dockerfile
        }
    }
    finish() {
        trap 'raise-e $LINENO' ERR
        reset-script "$HOME_SCRIPT"
        replace-line "$HOME_SCRIPT" ". $HOME_PATH/SEOHASONG/profile.sh"
    }

    echo 'echo $PPID' | bash > /tmp/pid$$
    pid=$( cat /tmp/pid$$ && rm /tmp/pid$$ )
    case $1 in
    "")
        check-prerequisite
        install-env
    ;;
    1)
        update-env
        case $OS_NAME in
        macOS) : ;;
        Windows) install-conda & install-container & wait ;;
        esac
        finish
    ;;
    esac
)
[ "$?" != "0" ] || exit
