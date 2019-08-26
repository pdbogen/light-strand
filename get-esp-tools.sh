#!/bin/sh

set -e
set -x

TMP="$(mktemp -d)"

trap 'rm -rf "$TMP"' EXIT

curl -s -f https://api.github.com/repos/espressif/arduino-esp32/releases > "$TMP/releases.json"
tag="$(jq -r 'map(select(.prerelease|not))[0].tag_name' < "$TMP/releases.json")"
curl -L -s -f "https://github.com/espressif/arduino-esp32/releases/download/${tag}/esp32-${tag}.zip" > "$TMP/release.zip"
unzip "$TMP/release.zip"
mv "esp-${tag}" "esp32"
