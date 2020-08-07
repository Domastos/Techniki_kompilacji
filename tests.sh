#!/bin/bash

make comp
rm Tests/assembly/*.asm

# usage: ./xsame3.sh
for file in Tests/pascal/*.pas; do
    ./comp "$file" "Tests/output/$(basename "$file" .pas)"
done


# for f in ../Tests/assembly/*.asm; do
#     echo -n "$f: "
#     python3 xsame2.py $f
# done