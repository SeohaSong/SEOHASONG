(
    cd $HOME/SEOHASONG/src/python/modelbuilder
    o_path=$HOME/SEOHASONG/app/modelbuilder
    rm $o_path
    docker run \
        --interactive --rm --tty --detach \
        --name python-builder \
        --workdir /root/workdir \
        --volume $PWD:/root/workdir \
        python-builder
    docker exec --user root python-builder pyinstaller --onefile main.py
    docker stop python-builder
    sudo mv dist/main $o_path 
    sudo rm -rf __pycache__ build dist main.spec
)
