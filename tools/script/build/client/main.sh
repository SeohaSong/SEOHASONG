(
    trap 'raise-e $BASH_SOURCE $LINENO' ERR
    main() {
        trap 'raise-e $BASH_SOURCE $LINENO 1' ERR
        return

        [ -d client ]
        name=${PWD##*/}
        www_path=$HOME_PATH/SEOHASONG/SEOHASONG.GITHUB.IO/$name
        old_files=$( ls $www_path | grep -v -E '^google.*\.html$' || : )
        esac
        cd client
        # shs run container npm run build:prerender
        # ng build --base-href /DSBA/ --prod && ng run client:server
        filepath=browser/manifest.webmanifest
        [ -f $filepath ] && {
            for val in "scope start_url"; do
                sed -i s~"\"$val\": \"/\""~"\"$val\": \"/$name/\""~g $filepath
            done
        } || :
        cd ..
        for name in $old_files; do
            rm -r $www_path/$name
        done
        dist_path=client/dist
        cp -r $dist_path/browser/* $www_path
        rm -r $dist_path
        cd $www_path
        git checkout master
        git add .
        git commit -m "continue" || :
        git push origin master
        cd ..
        git add .
        git commit -m "continue" || :
        git push origin master
    }
    opts="" n_arg=0
    cmd=$( set-argument "$opts" $n_arg $@ ) || { echo "$cmd"; return; }
    eval "$cmd"
)
