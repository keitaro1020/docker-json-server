#!/bin/bash

args="$@"

args="$@ -p 80"

file=/data/db.json
if [ -f $file ]; then
    echo "Found db.json, trying to open"
    args="$args db.json"
fi

file=/data/file.js
if [ -f $file ]; then
    echo "Found file.js seed file, trying to open"
    args="$args file.js"
fi

middleware=/data/middleware/*.js
middlewares=()
for mf in $middleware; do
	if [ -f $mf ]; then
		middlewares+=( $mf )
	fi
done
if [ ${#middlewares[*]} -gt 0 ]; then
	args="$args --middlewares $(IFS=' '; echo "${middlewares[*]}")"
fi

json-server $args
