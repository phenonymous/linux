#!/bin/bash
#
# | Extract multipe rar-archives in multiples directories to the same directoy
#

# Multi-threaded
# find . -name "*.rar" | xargs -P 5 -I fileName sh -c 'unrar e -o+ "$(dirname "fileName")/$(basename -s .rar "fileName")" "fileName"'

# Single thread
unrar e -ad -r -o+ ./*.rar
