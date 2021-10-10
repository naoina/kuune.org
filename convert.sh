#!/bin/sh

usage() {
    cat <<EOF
Usage: $(basename "$0")
EOF
    exit "$1"
}

#size=1200x630
size=$2
out="$1.jpg"

convert \
    -define "jpeg:size=$size" \
    -quality 92 \
    -resize "$size" \
    "$1" "$out"
# -unsharp 12x6+0.5+0 \
exiftool -overwrite_original_in_place -all= "$out"
outfilename="${3:-$(sha1sum "$1" | cut -d ' ' -f 1)}"
outfile="$(dirname "$1")/$outfilename.jpg"
mv "$out" "$outfile"
echo "output to $outfile"
mv "$1" "$1.orig"
