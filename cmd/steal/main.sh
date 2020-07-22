confirm=$1

[[ "$confirm" == confirm ]]

$DDD pull sr
mv $DDD_PATH/data/boilerplate/.git $DDD_PATH/data/SEOHASONG/boilerplate
rm -rf $DDD_PATH/data/boilerplate
mv $DDD_PATH/data/SEOHASONG/boilerplate $DDD_PATH/data
