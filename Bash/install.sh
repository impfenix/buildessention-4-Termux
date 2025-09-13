#!/data/data/com.termux/files/usr/bin/bash
pkg update -y && pkg upgrade -y
pkg install -y build-essential python
python3 -m pip install --upgrade pip
python3 -m pip install ninja
python3 -m pip install meson

pkg update -y && pkg upgrade -y
pkg install -y build-essential git python autoconf automake libtool \
    bison gettext pkg-config libffi-dev libxml2-dev \
    libjpeg-turbo-dev libpng-dev libtiff-dev gobject-introspection \
    gtk-doc docbook-xsl-legacy
