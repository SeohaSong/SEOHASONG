(
    main() {
        trap 'raise-e $BASH_SOURCE $LINENO 1' ERR
        while :; do
            containers=( $( docker.exe ps -a | grep -v CONTAINER || : ) )
            [ "$containers" == "" ] && break || {
                docker.exe stop ${containers[0]}
                docker.exe rm ${containers[0]} || :
            }
        done
        while :; do
            images=$( docker.exe images | grep '<none>' || : )
            images=( ${images//'<none>'/''} )
            [ "$images" == "" ] && break || docker.exe rmi ${images[0]}
        done
    }
    opts=""
    args=$( get-args "$@" "$opts" )
    echo "Arguments: $args"
    echo "Options  :"
    for opt in $opts; do
        val=$( get-opt "$@" "$opt" )
        opt=${opt%;*}
        eval "$opt=$val"
        echo "  $opt: $val"
    done
    [ "$args" == '' ] && main || { for v in $args; do main $v; done; }
)
