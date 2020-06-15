echo $1
echo $@
echo $( eval $INTRO )

seohasong

cd data/SEOHASONG
cat env/KEY
echo
git pull origin master
git reset --hard HEAD

seohasong

mv data/boilerplate/.git data/SEOHASONG/boilerplate
rm -r data/boilerplate
mv data/SEOHASONG/boilerplate data
