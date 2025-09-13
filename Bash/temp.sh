#!/data/data/com.termux/files/usr/bin/bash
set -e
pkg install -y git gtk3 gettext
cd ~
if [ -d "yad" ]; then
    rm -rf yad
fi
git clone https://github.com/v1cont/yad.git
cd yad
meson setup build --prefix=$PREFIX
ninja -C build
