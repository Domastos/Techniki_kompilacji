#!/bin/bash

make comp
rm Tests/output/*.asm

# usage: ./xsame3.sh
for file in Tests/pascal/*.pas; do
    ./comp "$file" "Tests/output/$(basename "$file" .pas)"
done


for file in Tests/assembly/*.asm; do
    python3 compare.py "$file" "Tests/output/$(basename "$file" .asm).asm"
done

