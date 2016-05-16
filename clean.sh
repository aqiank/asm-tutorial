#!/bin/sh

for dir in *; do
    if [ -d $dir ]; then
        cd $dir
        for srcfile in *.s; do
            name=${srcfile%*.s}
            rm ${name} "${name}.o"
        done
        cd ..
    fi
done
