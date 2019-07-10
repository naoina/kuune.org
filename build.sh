#!/bin/sh

set -eu

usage() {
    cat << EOF
Usage: `basename $0`
EOF
    exit $1
}

go get -u -v -tags extended github.com/gohugoio/hugo
go get -u -v github.com/tdewolff/minify/cmd/minify
hugo
local publishdir=$(hugo config | grep "publishdir" | cut -d ' ' -f 3)
minify -r -o $publishdir $publishdir
