#!/usr/bin/env python3
import os
import sys
import re


if len(sys.argv) != 3:
    print("\033[1;31;40m TEST ERROR: wrong number of arguments")
    sys.exit(-1)

file = (sys.argv[1], sys.argv[2])
lines = []

with open(file[0]) as f:
    lines.append(f.readlines())

with open(file[1]) as f:
    lines.append(f.readlines())

fail = True if len(lines[0]) != len(lines[1]) else False

if fail:
    print(f"\033[1;31;40m TEST FAILED: {sys.argv[1]}")
    sys.exit(-1)

comment = re.compile(r";.*")
white = re.compile(r"[ \t]+")

def fix_line(line):
    line = comment.sub("", line)
    line = white.sub(" ", line)
    line = line.strip()
    return line

lines = [fix_line(line) for line in lines[i] for i in range(len(lines))]

if not fail:
    for i,k in enumerate(lines[0]):
        if lines[0][i] != lines[1][i]:
            fail = True
            print("\033[1;31;40m FAIL (%d)" % (i+1))
            print(f"{lines[0][i]}\n{lines[1][i]}")
            break

    if not fail:
        print("\033[1;32;40m TEST PASSED")


 






