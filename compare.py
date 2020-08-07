#!/usr/bin/env python3
import os
import sys
import re


if len(sys.argv) != 3:
    print("TEST ERROR: wrong number of arguments")

file = (sys.argv[1], sys.argv[2])
lines = []

with open(file[0]) as f:
    lines.append(f.readlines())

with open(file[1]) as f:
    lines.append(f.readlines())

fail = True if len(lines[0]) != len(lines[1]) else False

if fail:
    print(f"TEST FAILED: {sys.argv[1]}")

comment = re.compile(r";.*")
white = re.compile(r"[ \t]+")

def fix_line(line):
    line = comment.sub("", line)
    line = white.sub(" ", line)
    line = line.strip()
    return line



 






