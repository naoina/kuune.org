#!/bin/sh

set -eu

usage() {
    cat << EOF
Usage: `basename $0`
EOF
    exit $1
}

hugo deploy --maxDeletes -1 --invalidateCDN --target kuune.org
