#!/bin/sh
# https://superuser.com/questions/1248528/remove-blank-pages-from-pdf-from-command-line
IN="$1"
PAGES=$(pdfinfo $IN.pdf | grep ^Pages: | tr -dc '0-9')

non_blank() {
    for i in $(seq 1 $PAGES)
    do
        if [ $(convert -density 35 "$IN.pdf[$((i-1))]" -define histogram:unique-colors=true -format %c histogram:info:- | wc -l) -ne 1 ]
        then
            echo $i
            #echo $i 1>&2
        fi
        echo -n . 1>&2
    done | tee out.tmp
    echo 1>&2
}

set +x
pdftk $IN.pdf cat $(non_blank) output $IN.rm.pdf 
