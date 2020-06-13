(
    trap 'raise-e $BASH_SOURCE $LINENO' ERR
    main() {
        trap 'raise-e $BASH_SOURCE $LINENO 1' ERR
        cd $HOME_PATH/SEOHASONG
        docker.exe build -t seohasong scripts/dockerfile
    }
    opts="" n_arg=0
    cmd=$( set-argument "$opts" $n_arg $@ ) || { echo "$cmd"; return; }
    eval "$cmd"
)
