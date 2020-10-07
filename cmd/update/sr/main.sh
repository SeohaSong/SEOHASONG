echo
echo seoha-song
cat $DDD_PATH/env/SR-KEY
echo

cd $DDD_PATH/data
git clone https://github.com/seoha-song/boilerplate.git boilerplate_

for val in .git env data
do
    rm -rf boilerplate_/$val
    mv boilerplate/$val boilerplate_/$val
done
rm -rf boilerplate
mv boilerplate_ boilerplate
