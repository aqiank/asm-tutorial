#!/bin/sh

for dir in *; do
    if [ -d $dir ]; then
        cd $dir
        for srcfile in *.s; do
            name=${srcfile%*.s}
            as --32 $srcfile -o "${name}.o"
            ld -m elf_i386 "${name}.o" -o ${name}
        done
        cd ..
    fi
done
