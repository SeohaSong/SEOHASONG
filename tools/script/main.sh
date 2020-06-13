raise-e() {
    echo "[SHS] Error in '$1: $2'"
    case $3 in
    1) echo "[SHS] Main function error" ;;
    2) echo "[SHS] Unknown option '$4'" ;;
    3) echo "[SHS] Require argument to option '$4'" ;;
    4) echo "[SHS] Number of arguments mismatch (target: $4)" ;;
    esac
    exit 1
}
get-opt() {
    args=$1 opt=$2
    opt=( ${opt/;/' '} )
    [[ "$args" =~ ^--${opt[0]}|' --'${opt[0]} ]] && {
        tmp=${args#*"--$opt "}; val=${tmp%%' '*}
        [ ${opt[1]} == 0 ] && echo $opt || echo $val
    } || :
    unset args
    unset opt
    unset tmp
    unset val
}
get-args() {
    args=$1 opts=$2
    [[ "$args" =~ ^--|' --' ]] && {
        args=( ${args##*--} ); val=( ${opts#*$args;} )
        echo ${args[@]:$(( $val+1 )):${#args[@]}}
    } || echo $args
    unset args
    unset opts
    unset val
}
main() {
    dir_path=$1 arg=$2 args=$( echo $@ | cut -d ' ' -f 3- )
    modules=$( ls "$dir_path" | grep -v main.sh )
    case $( echo "$modules" | grep ^$arg$ ) in
    "")
        echo "[SHS]"
        echo "$modules"
    ;;
    *)    
        path="$dir_path/$arg/main.sh"
        . "$path" "$args"
    ;;
    esac
    unset dir_path
    unset arg
    unset args
    unset modules
    unset path
}
main "$( dirname $BASH_SOURCE )" $@
unset -f main
unset -f print-info
unset -f get-args
unset -f get-opt
unset -f raise-e
