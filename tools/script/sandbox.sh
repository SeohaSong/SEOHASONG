(
    A=( 11 22 33 )
    A+=( 44 )
    echo "${A[@]}" > file.txt

    asdf() {
        if [ -p /dev/stdin ]
        then
            echo case1
            echo $( cat /dev/stdin )
        elif [ -f "$1" ]
        then
            echo case2
            echo $( cat $1 )
        else
            echo case3
            echo $( cat /dev/stdin )
        fi
    }

    cat file.txt | asdf
    asdf file.txt
    asdf < file.txt
    asdf <<< "$( cat file.txt )"

    rm file.txt
)
