echo
echo seoha-song
cat $DDD_PATH/env/SR-KEY
echo

nxt_path=$DDD_PATH/data/boilerplate_
git clone https://github.com/seoha-song/boilerplate.git $nxt_path

cd $DDD_PATH/data/boilerplate
mv .git $DDD_PATH/data/git
mv $nxt_path/.git .git
rm -rf $nxt_path

git submodule deinit --all -f || :
git add .
git reset --hard HEAD
rm -rf .git
mv $DDD_PATH/data/git .git
