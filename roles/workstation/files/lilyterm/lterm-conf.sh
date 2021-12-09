#!/bin/bash

PATH="/bin:usr/bin"

i=0

while [ $i -lt 42 ]; do
  cat ~/.config/lilyterm/default.conf | \
    sed "s#^background_image.*#background_image = /home/${1}/wallpaper/resized${i}.jpg#" \
    > /home/${1}/.config/lilyterm/lilyterm${i}.conf
  i=$(($i+1))
done
