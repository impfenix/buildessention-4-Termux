#!/data/data/com.termux/files/usr/bin/bash
set -e
pkg update -y && pkg upgrade -y
pkg install -y build-essential git python autoconf automake libtool \
    bison gettext pkg-config libffi-dev libxml2-dev \
    libjpeg-turbo-dev libpng-dev libtiff-dev gobject-introspection \
    gtk-doc docbook-xsl-legacy

export JHBUILD_PREFIX="$HOME/jhbuild_root"
mkdir -p "$JHBUILD_PREFIX"

export CFLAGS="-I$PREFIX/include -I$JHBUILD_PREFIX/include"
export LDFLAGS="-L$PREFIX/lib -L$JHBUILD_PREFIX/lib"
export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PREFIX/share/pkgconfig:$JHBUILD_PREFIX/lib/pkgconfig:$JHBUILD_PREFIX/share/pkgconfig"
export LD_LIBRARY_PATH="$PREFIX/lib:$JHBUILD_PREFIX/lib"

if [! -d "jhbuild" ]; then
    git clone https://gitlab.gnome.org/GNOME/jhbuild.git
fi
cd jhbuild
./autogen.sh --prefix="$PREFIX"
make
make install
cd..

cat > ~/.jhbuildrc << EOF
prefix = '$JHBUILD_PREFIX'
checkoutroot = '~/jhbuild_src'
moduleset = 'gnome-apps-3.38'
EOF

jhbuild build --force --clean --nodeps gtk+

if [! -d "yad" ]; then
    git clone https://github.com/v1cont/yad.git
fi
cd yad
git checkout 13.0

./autogen.sh
./configure --prefix="$JHBUILD_PREFIX"
make
make install
