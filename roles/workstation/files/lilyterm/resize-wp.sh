#!/bin/bash

PATH='/bin:/usr/bin'

WIDTH=${1:-1920}

cd /usr/local/share/wp
convert '*.jpg['$WIDTH'x]' resized%d.jpg
