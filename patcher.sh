#! /usr/bin/env bash

apply() {
    for file in $(sortbysize); do
        echo -e "\n>>= THIS: $file"

        if [ -n "$(find . -iname "*.rej")" ]; then
            echo -e "A .rej file found, you might want to resolve the conflicts.\nPrinting to stdout\n\n"
            cat *.rej
            break
        fi

        patch <"patches/$file"
        
        sidedir=./patches/.applied
        mkdir -p $sidedir
        mv "./patches/$file" $sidedir
        echo -e ">>= File $file moved to '.applied' directory, POTENTIAL rejects are printed below.\n"
        #debug with that
        #break
    done

    
    if [ -n "$(find . -iname "*.rej")" ]; then
        echo -e "A .rej file found, you might want to resolve the conflicts.\nPrinting to stdout\n\n"
        cat *.rej
    fi

    if [ -n "$(find -prune -type f -path './patches/*' -iname "*.diff")" ]; then
        echo "Directory 'patches/' is empty, use 'patcher.sh d' to download patch files."
        exit 0
    fi
}

cleanup() {
    make clean
    rm -i *.orig *.rej
}

download() {
    mkdir -p ./patches

    while read -r line; do
        echo "now: $line"
        curl -O --output-dir ./patches $line
    done < ./Patches
}

sortbylines() {
    find ./patches/* -maxdepth 0 -type f -exec wc -l --total=never {} + | sort -n 
}

sortbysize() {
    ls -S -r ./patches
}

case $1 in
    a)  echo "applying until .rej file detected"
        apply
        ;;
    c)  echo "cleanup ran"
        cleanup
        ;;
    d)  echo "curl ran"
        download
        ;;
    *)  echo -e "patcher.sh\n  c - cleanup\n  d - download patches from 'Patches' file\n  a - apply './patches' sorted by file binary size"
        ;;
esac
