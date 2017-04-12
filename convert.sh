#!/bin/sh

usage() {
    cat << EOF
Usage: `basename $0`
EOF
    exit $1
}

#size=1200x630
size=$2

convert -define jpeg:size=$size -unsharp 12x6+0.5+0 -quality 92 -resize $size $1 $1
exiftool -all= $1
mv $1 $(sha1sum $1 | cut -d ' ' -f 1).jpg
