#!/bin/sh
set -e

SRC="/srv/hytale/Server"
DST="/srv/data"

mkdir -p "$DST"

for f in "$SRC"/*; do
    rm -rf "$DST/$(basename "$f")"
    mv "$f" "$DST"/
done

exec "$@"
