#!/data/data/com.termux/files/usr/bin/bash
pkg update -y && pkg upgrade -y
pkg install -y build-essential python
python3 -m pip install --upgrade pip
python3 -m pip install ninja
python3 -m pip install meson
