#!/bin/zsh

for shift in {0..7500}; do echo -ne "`printf ' \\\\u%x' $((0xe000 + $shift))`"; done
