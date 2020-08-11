cd $DDD_PATH/data/boilerplate
ddd > /dev/null
if [[ -z $( docker ps -a | grep ddd || : ) ]]; then
    ddd exe ddd
fi
ddd login
