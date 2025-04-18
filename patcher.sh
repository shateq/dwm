#! /usr/bin/env bash

apply() {
    for file in $(sortbysize); do
        echo "this: $file"
        patch <"patches/$file"
        
        if [ -n "$(find . -iname "*.rej")" ]; then
            echo "FOUND REJECTS, BREAKING THE LOOP"
            break
        else
            continue
        fi

        break
    done
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
        ;;
    c)  echo "cleanup ran"
        cleanup
        ;;
    d)  echo "curl ran"
        download
        ;;
    *)  echo "patcher.sh 
    c - cleanup 
    d - download patches from 'Patches' file
    a - apply './patches' sorted by file binary size"
        ;;
esac
