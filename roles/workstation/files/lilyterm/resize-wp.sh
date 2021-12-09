#!/bin/bash

PATH='/bin:/usr/bin'

cd /usr/local/share/wp
convert '*.jpg['$1'x]' resized%d.jpg
