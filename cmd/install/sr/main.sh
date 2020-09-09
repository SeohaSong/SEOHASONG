echo
echo seoha-song
cat $DDD_PATH/env/SR-KEY
echo

cd $DDD_PATH/data/SEOHASONG
git add .
git reset --hard HEAD
git pull origin master
