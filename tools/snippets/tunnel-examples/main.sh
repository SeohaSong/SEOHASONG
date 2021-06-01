(
    main() {
        trap 'raise-e $BASH_SOURCE $LINENO 1' ERR
        server_name="seohasong@crush-on.info"
        remote_ip="0.0.0.0" host_ip="localhost"
        case $OS_NAME in
        Windows)
            ssh \
            -R $remote_ip:2201:$host_ip:2201 \
            -R $remote_ip:2202:$host_ip:2202 \
            -R $remote_ip:4200:$host_ip:4200 \
            -R $remote_ip:8888:$host_ip:8888 \
            $server_name
        ;;
        macOS)
            echo 'Port for Flutter, Unity, etc ...'
        ;;
        esac
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
