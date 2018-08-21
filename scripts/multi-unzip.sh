#!/bin/bash
#
# | Extract multipe zip-archives in multiples directories to the same directoy
#
# Credit https://stackoverflow.com/a/2318189

# Multi-threaded
find . -name "*.zip" | xargs -P 5 -I fileName sh -c 'unzip -o -d "$(dirname "fileName")/$(basename -s .zip "fileName")" "fileName"'

# Single thread
# find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`" "$filename"; done;

