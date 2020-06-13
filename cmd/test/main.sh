args=( $@ )
arg=${args[0]} nxt_args=${args[@]:1}
apath=$( dirname $( eval $INTRO ) )
afile=$apath/$arg/main.sh
if [[ ! -f $afile || -z $arg ]]; then
    ls $apath | grep -v main.sh
    return 1
else
    cmd=". $afile $nxt_args"
    if [ -z "$nxt_args" ]; then cmd=". $afile ''"; fi
    $cmd; fi
