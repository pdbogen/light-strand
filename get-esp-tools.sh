#!/bin/sh

set -e
set -x

TMP="$(mktemp -d)"

trap 'rm -rf "$TMP"' EXIT

curl -s -f https://api.github.com/repos/espressif/arduino-esp32/releases > "$TMP/releases.json"
zip="$(jq -r '.[]|select(.prerelease|not).assets[].browser_download_url' < "$TMP/releases.json" | grep zip | head -1)"

curl -L -s -f "$zip" > "$TMP/release.zip"

unzip -j "$TMP/release.zip"

