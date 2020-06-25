if [[ -d .git ]]
then
    git add .
    git commit -m "continue previous working"
    git push
    return
fi

paths="$DDD_PATH/ddd $DDD_PATH"
apaths=$( for v in $paths; do ( cd $v && pwd ); done )
for apath in $apaths
do (
    $DDD __init__
    if [ ! -d $apath ]; then continue; fi
    $DDD echo Update \'$apath\' repo
    cd $apath
    git config user.email "tisutoo@gmail.com"
    git config user.name "seohasong"
    git add .
    git commit -m "continue previous working" || :
    git push origin master )
done
