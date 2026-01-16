#!/bin/sh
set -e

INSTALL_DIR="/srv/hytale"
VOLUME_DIR="/srv/data"

mkdir -p "$INSTALL_DIR"
mkdir -p "$VOLUME_DIR"

install_hytale() {
    DST="$1"
    curl https://downloader.hytale.com/hytale-downloader.zip -o /tmp/hytale-downloader.zip
    unzip /tmp/hytale-downloader.zip -d /tmp/hytale/
    rm /tmp/hytale-downloader.zip
    /tmp/hytale/hytale-downloader-linux-amd64 -download-path /tmp/game.zip
    rm -rf /tmp/hytale
    unzip /tmp/game.zip -d "$DST"
    rm /tmp/game.zip
}

setup_volume() {
    SRC="$1"
    DST="$2"

    for f in "$SRC"/*; do
        rm -rf "$DST/$(basename "$f")"
        cp -rf "$f" "$DST"/
    done
}

if [ -z "$(ls "$INSTALL_DIR")" ]; then
    echo "Installing Hytale..."
    install_hytale "$INSTALL_DIR"
    echo "Installation complete!"
fi

setup_volume "$INSTALL_DIR/Server" "$VOLUME_DIR"

exec "$@"
