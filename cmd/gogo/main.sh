args=( $@ )
arg=${args[0]}
args=${args[@]:1}
args=${args:-"''"}

path=$( dirname $BASH_SOURCE )
file=$path/$arg/main.sh

if [[ -z $arg || ! -f $file ]]
then
    ls $path | grep -v main.sh
    return 1
fi

eval ". $file $args"

unset args
unset arg
unset path
unset file
