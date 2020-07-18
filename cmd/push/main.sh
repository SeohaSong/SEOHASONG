push()
{(
    $DDD .-trap

    cd $1
    $DDD echo Update \'$apath\' repo
    
    git config user.email "tisutoo@gmail.com"
    git config user.name "seohasong"
    git add .
    git commit -m "continue previous working" || :
    git push
)}

if [[ -d .git && $PWD != $DDD_PATH ]]
then
    push
    return
fi

for apath in $DDD_PATH/ddd $DDD_PATH
do
    if [ -d $apath ]
    then
        push $apath
    fi
done
