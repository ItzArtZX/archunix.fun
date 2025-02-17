#!/bin/bash

OS_RELEASE="/etc/os-release"
OS_RELEASE_LIB="/usr/lib/os-release"
ICON1="/usr/share/pixmaps/archlinux-logo-text-dark.svg"
ICON2="/usr/share/pixmaps/archlinux-logo-text.svg"

BACKUP_DIR="./archunix_bak"

URL1="https://archunix.fun/logos/archlinux-logo-text-dark.svg"
URL2="https://archunix.fun/logos/archlinux-logo-text.svg"

DOWNLOAD_DIR="/usr/share/pixmaps"

echo "Creating backup directory if needed..."
mkdir -p "$BACKUP_DIR"

cp --preserve=mode "$OS_RELEASE" "$BACKUP_DIR/os-release.bak"
echo "Backup of /etc/os-release saved."

if [ -f "$OS_RELEASE_LIB" ]; then
    cp --preserve=mode "$OS_RELEASE_LIB" "$BACKUP_DIR/os-release-lib.bak"
    echo "Backup of /usr/lib/os-release saved."
fi

sed -i 's/^NAME=.*/NAME="Arch Unix"/' "$OS_RELEASE"
sed -i 's/^PRETTY_NAME=.*/PRETTY_NAME="Arch Unix"/' "$OS_RELEASE"
sed -i 's/^HOME_URL=.*/HOME_URL="https:\/\/archunix.fun"/' "$OS_RELEASE"

if [ -f "$OS_RELEASE_LIB" ]; then
    sed -i 's/^NAME=.*/NAME="Arch Unix"/' "$OS_RELEASE_LIB"
    sed -i 's/^PRETTY_NAME=.*/PRETTY_NAME="Arch Unix"/' "$OS_RELEASE_LIB"
    sed -i 's/^HOME_URL=.*/HOME_URL="https:\/\/archunix.fun"/' "$OS_RELEASE_LIB"
    echo "os-release files modified."
fi

cp --preserve=mode "$ICON1" "$BACKUP_DIR/$(basename "$ICON1").bak"
cp --preserve=mode "$ICON2" "$BACKUP_DIR/$(basename "$ICON2").bak"
echo "Backup of icons saved."

echo "Creating download directory if needed..."
mkdir -p "$DOWNLOAD_DIR"

if [ -f "$ICON1" ]; then
    mv -f "$ICON1" "$ICON1.bak"
    echo "Renamed $ICON1 to $ICON1.bak"
fi

if [ -f "$ICON2" ]; then
    mv -f "$ICON2" "$ICON2.bak"
    echo "Renamed $ICON2 to $ICON2.bak"
fi

if command -v wget &>/dev/null; then
    wget -O "$ICON1" "$URL1"
    wget -O "$ICON2" "$URL2"
elif command -v curl &>/dev/null; then
    curl -o "$ICON1" "$URL1"
    curl -o "$ICON2" "$URL2"
else
    echo "Error: Neither wget nor curl is installed. Cannot download icons."
    exit 1
fi

echo "New icons downloaded and replaced in $DOWNLOAD_DIR."