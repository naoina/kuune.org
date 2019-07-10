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
publishdir=$(hugo config | awk '/^publishdir/ {gsub("\"", ""); print $3}')
minify -r -o $publishdir $publishdir
