#!/bin/sh
set -e

install_hytale() {
    curl https://downloader.hytale.com/hytale-downloader.zip -o /tmp/hytale-downloader.zip
    unzip /tmp/hytale-downloader.zip -d /tmp/hytale/
    rm /tmp/hytale-downloader.zip
    /tmp/hytale/hytale-downloader-linux-amd64 -download-path /tmp/game.zip
    rm -rf /tmp/hytale
    unzip /tmp/game.zip -d /srv/hytale/
    rm /tmp/game.zip
}

setup_volume() {
    SRC="/srv/hytale/Server"
    DST="/srv/data"

    mkdir -p "$DST"

    for f in "$SRC"/*; do
        rm -rf "$DST/$(basename "$f")"
        mv "$f" "$DST"/
    done
}

install_hytale
setup_volume

exec "$@"
