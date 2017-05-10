#!/bin/sh

usage() {
    cat << EOF
Usage: `basename $0`
EOF
    exit $1
}

scrape() {
    tag=$1
    attr=$2
    value=$3
    content_attr=$4
    echo $(grep -P "<$tag\\s*.*?\\s+$attr=\"$value\"" | head -n 1 | grep -oP "(?<=$content_attr=\")(.+?)(?=\")")
}

scrape_og() {
    scrape 'meta' 'property' "$1" 'content'
}

escape() {
    echo $1 | sed -e 's/"/\"/g'
}

url=$1
body=$(curl $url)

path=$(echo $url | grep -oP '(?:(?<=http://)|(?<=https://))(.+)(?=/?)')
data_path="data/$path"
mkdir -p $data_path

title=$(echo "$body" | grep -oP '(?<=<title>)(.+?)(?=<\s*/\s*title\s*>)' | head -n 1)
description=$(echo "$body" | scrape_og "og:description")
if [ -z "$description" ]; then
    description=$(echo "$body" | scrape 'meta' 'name' 'description' 'content')
fi
ogimage=$(echo "$body" | scrape_og "og:image")

cat <<EOF >"$data_path/og.json"
{
  "URL": "$(escape "$url")",
  "Title": "$(escape "$title")",
  "Description": "$(escape "$description")",
  "OgImage": "$(escape "$ogimage")"
}
EOF
