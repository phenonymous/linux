#!/bin/bash

# This script prints a sample of all figlet fonts

pushd /usr/share/figlet

for __font in *; do
  if [[ "$__font" == *.flc ]]; then
    continue
  else
    __subfont=$(echo "$__font" | cut -d '.' -f 1)
    toilet -f "$__font" --gay -w 120 "$__subfont" 2> /dev/null
    echo
  fi
done

popd
