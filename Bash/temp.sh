#!/bin/bash
# temp.sh: Script para compilar GTK+ 3 e YAD no Termux usando JHBuild.

set -e

echo "INFO: Configurando o ambiente e instalando dependências base..."
pkg update -y && pkg upgrade -y
pkg install -y build-essential git python autoconf automake libtool \
    bison gettext pkg-config ninja meson libffi-dev libxml2-dev \
    libjpeg-turbo-dev libpng-dev libtiff-dev gobject-introspection \
    gtk-doc docbook-xsl-legacy |

| { echo "ERRO: Falha ao instalar dependências base."; exit 1; }

export JHBUILD_PREFIX="$HOME/jhbuild"
mkdir -p "$JHBUILD_PREFIX"

export CFLAGS="-I$PREFIX/include -I$JHBUILD_PREFIX/include"
export LDFLAGS="-L$PREFIX/lib -L$JHBUILD_PREFIX/lib"
export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PREFIX/share/pkgconfig:$JHBUILD_PREFIX/lib/pkgconfig:$JHBUILD_PREFIX/share/pkgconfig"
export LD_LIBRARY_PATH="$PREFIX/lib:$JHBUILD_PREFIX/lib"

echo "INFO: Baixando e configurando o JHBuild..."
if [! -d "jhbuild" ]; then
    git clone https://gitlab.gnome.org/GNOME/jhbuild.git |

| { echo "ERRO: Falha ao clonar o repositório do JHBuild."; exit 1; }
fi
cd jhbuild
./autogen.sh --prefix="$PREFIX" |

| { echo "ERRO: Falha no autogen.sh do JHBuild."; exit 1; }
make |

| { echo "ERRO: Falha ao compilar o JHBuild."; exit 1; }
make install |

| { echo "ERRO: Falha ao instalar o JHBuild."; exit 1; }
cd..

cat > ~/.jhbuildrc << EOF
prefix = '$JHBUILD_PREFIX'
checkoutroot = '~/jhbuild/src'
moduleset = 'gnome-apps-3.38'
EOF

echo "INFO: Iniciando a compilação do GTK+ com JHBuild. Isso pode levar muito tempo."
jhbuild build --force --clean --nodeps gtk+ |

| { echo "ERRO: A compilação do GTK+ falhou."; exit 1; }
echo "SUCESSO: GTK+ compilado com sucesso em $JHBUILD_PREFIX"

echo "INFO: Baixando e compilando o YAD..."
YAD_VERSION="13.0"
if [! -d "yad" ]; then
    git clone https://github.com/v1cont/yad.git |

| { echo "ERRO: Falha ao clonar o repositório do YAD."; exit 1; }
fi
cd yad
git checkout $YAD_VERSION

./autogen.sh
./configure --prefix="$JHBUILD_PREFIX" |

| { echo "ERRO: Falha ao configurar o YAD."; exit 1; }
make |

| { echo "ERRO: Falha ao compilar o YAD."; exit 1; }
make install |

| { echo "ERRO: Falha ao instalar o YAD."; exit 1; }
echo "SUCESSO: YAD compilado e instalado em $JHBUILD_PREFIX"

echo "INFO: Processo de compilação concluído."
