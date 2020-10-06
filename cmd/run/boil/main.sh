docker stop ddd 2> /dev/null || :

# <install boilerplate>
# ...
# </install boilerplate>

cd $DDD_PATH/data/boilerplate
ddd -
ddd run ddd
