#!/bin/sh

set -e
set -x

git clone --depth=1 --recursive https://github.com/espressif/arduino-esp32.git  esp32
cd esp32/tools
python get.py
