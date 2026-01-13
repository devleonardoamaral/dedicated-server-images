#!/bin/sh
set -e

SRC="/srv/hytale/Server"
DST="/srv/data"

mkdir -p "$DST"

if [ -z "$(ls -A "$DST" 2>/dev/null)" ]; then
    cp -r "$SRC"/* "$DST"/
fi

exec "$@"
