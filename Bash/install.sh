#!/data/data/com.termux/files/usr/bin/bash
#
# Script "Build Essential" para configurar um ambiente de desenvolvimento
# completo no Termux, incluindo Python, GTK e outras ferramentas.
# O script finaliza compilando o 'yad' v14.1 como um teste do ambiente.
#

# Aborta o script imediatamente se qualquer comando falhar.
set -e

echo "=========================================================="
echo "Iniciando a configuração do ambiente de desenvolvimento..."
echo "=========================================================="

# Bloco 1: Atualização do Sistema
echo "[1/7] Atualizando o sistema de pacotes do Termux..."
pkg update -y && pkg upgrade -y

# Bloco 2: Instalação de Todas as Dependências de Compilação
# Lista unificada e corrigida com os nomes de pacotes para Termux.
echo "[2/7] Instalando todas as dependências de compilação..."
pkg install -y \
    autoconf \
    automake \
    bison \
    build-essential \
    docbook-xsl \
    gettext \
    git \
    gobject-introspection \
    gtk-doc \
    gtk3 \
    intltool \
    libandroid-shmem \
    libcairo \
    libffi \
    libjpeg-turbo \
    libpng \
    libtiff \
    libtool \
    libxml2 \
    pango \
    perl \
    pkg-config \
    python \
    wget \
    xorgproto

# Bloco 3: Configuração do Ambiente Python (pip, ninja, meson)
echo "[3/7] Configurando o ambiente Python e instalando módulos..."
python3 -m pip install --upgrade pip
python3 -m pip install ninja meson

# Bloco 4: Instalação do Módulo Perl 'XML::Parser'
# Este módulo é uma dependência do 'intltool' e é instalado via CPAN.
echo "[4/7] Instalando o módulo Perl 'XML::Parser' via CPAN..."
cpan install XML::Parser

# Bloco 5: Download e Extração do Código-Fonte do 'yad'
YAD_URL="https://github.com/v1cont/yad/releases/download/v14.1/yad-14.1.tar.xz"
YAD_ARCHIVE="yad-14.1.tar.xz"
YAD_DIR="yad-14.1"

echo "[5/7] Baixando o código-fonte do 'yad' para teste..."
# Remove arquivos antigos para garantir um download limpo
rm -f "$YAD_ARCHIVE"
wget "$YAD_URL"

echo "Descompactando o código-fonte..."
# Remove o diretório antigo para garantir uma extração limpa
rm -rf "$YAD_DIR"
tar -xf "$YAD_ARCHIVE"
cd "$YAD_DIR"

# Bloco 6: Compilação e Instalação do 'yad' (Teste do Ambiente)
# Utiliza o método de 2 passos que funcionou: exportar LDFLAGS primeiro.
echo "[6/7] Compilando e instalando o 'yad' como teste..."

# Exporta a variável de ambiente para o linker encontrar a biblioteca de memória compartilhada.
export LDFLAGS="-landroid-shmem"

# Executa a configuração, compilação e instalação em sequência.
./configure --prefix=$PREFIX && make -j$(nproc) && make install

# Bloco 7: Limpeza e Verificação
echo "[7/7] Limpando arquivos de teste e verificando..."
cd..
rm -rf "$YAD_DIR" "$YAD_ARCHIVE"

# Verifica se a instalação foi bem-sucedida.
if command -v yad &> /dev/null; then
    YAD_VERSION=$(yad --version)
    echo "----------------------------------------------------------"
    echo "Ambiente de desenvolvimento configurado com sucesso!"
    echo "'yad' versão $YAD_VERSION foi compilado e instalado como teste."
    echo "=========================================================="
    echo "Para usar o yad, abra o app Termux:X11 e execute um comando como:"
    echo "termux-x11 :0 -xstartup \"yad --title='Teste' --text='Ambiente pronto!'\""
    echo "=========================================================="
else
    echo "Erro: A compilação de teste falhou. Verifique os logs."
    exit 1
fi

exit 0
