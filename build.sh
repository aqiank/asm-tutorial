#!/bin/sh

for dir in *; do
    if [ -d $dir ]; then
        cd $dir
        for srcfile in *.s; do
            name=${srcfile%*.s}
            as $srcfile -o "${name}.o"
            ld "${name}.o" -o ${name}
        done
        cd ..
    fi
done
