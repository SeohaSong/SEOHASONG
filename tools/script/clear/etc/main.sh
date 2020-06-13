(
    main() {
        trap 'raise-e $BASH_SOURCE $LINENO 1' ERR
        # ======================================================================
        dir_path=$( cd $( dirname "$BASH_SOURCE" ) && pwd )
        filepath=${dir_path##'/mnt/c'}/clear.py
        shs run prompt python $filepath $git
    }
    opts="git;0"
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
