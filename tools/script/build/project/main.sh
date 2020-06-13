(
    trap 'raise-e $BASH_SOURCE $LINENO' ERR
    main() {
        trap 'raise-e $BASH_SOURCE $LINENO 1' ERR
        name=$1
        cp -r $HOME_PATH/SEOHASONG/scripts/PROJECT $name
        cd $name
        rm .git
        rm -r tools/shell/_MODULE
        case $client in
        "") rm -r tools/shell/build ;;
        *)
            ng new client --style scss --routing --skip-git
            cd client
            ng add @angular/material
            ng add @angular/pwa --project client
            ng add @nguniversal/express-engine --client-project client
            old_files="webpack.server.config.js"
            for v in $old_files; do rm $v; done
            dir_path=$HOME_PATH/SEOHASONG/scripts/angular
            new_files="webpack.server.config.js prerender.ts static.paths.ts"
            for v in $new_files; do cp $dir_path/$v $v; done
        ;;
        esac
    }
    opts="client:0" n_arg=1
    cmd=$( set-argument "$opts" $n_arg $@ ) || { echo "$cmd"; return; }
    eval "$cmd"
)
