#!/bin/bash

PATH="/bin:usr/bin"

i=0

FOLDER=${1:-ubuntu}

while [ $i -lt 42 ]; do
  cat /home/${FOLDER}/.config/lilyterm/default.conf | \
    sed "s#^background_image.*#background_image = /usr/local/share/wp/resized${i}.jpg#" \
    > /home/${FOLDER}/.config/lilyterm/lilyterm${i}.conf
  i=$(($i+1))
done
