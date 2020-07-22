$DDD pull sr

work_path=$DDD_PATH/data/SEOHASONG/boilerplate

mv $DDD_PATH/data/boilerplate/.git $work_path
rm -rf $DDD_PATH/data/boilerplate
mv $work_path $DDD_PATH/data
