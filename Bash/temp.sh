#!/data/data/com.termux/files/usr/bin/bash

# Encerra o script imediatamente se qualquer comando falhar.
# Isso previne erros em cascata e comportamentos inesperados.
set -e

# Atualiza os repositórios de pacotes e instala todas as dependências necessárias
# para a compilação do YAD.
# - build-essential: Compiladores C/C++ e ferramentas essenciais.
# - meson: O sistema de compilação usado pelo YAD.
# - ninja: O backend de compilação de alta velocidade que o Meson utiliza.
# - gettext: Ferramentas para internacionalização (i18n), uma dependência do YAD.
# - libgtk-3-dev: Arquivos de desenvolvimento para a biblioteca GTK3, da qual a GUI do YAD depende.
pkg install -y gettext libgtk-3-dev

# Garante que o script opere a partir do diretório home do Termux,
# um ponto de partida conhecido e seguro.
cd /data/data/com.termux/files/home

# Baixa o código-fonte do YAD versão 14.1 do repositório oficial no GitHub.
curl -LO https://github.com/v1cont/yad/releases/download/v14.1/yad-14.1.tar.xz

# Extrai o conteúdo do arquivo tarball. O comando 'tar' criará um
# diretório chamado 'yad-14.1'.
tar -xf yad-14.1.tar.xz

# *** ESTE É O PASSO CRÍTICO QUE FALTAVA ***
# Muda o diretório de trabalho para o diretório do código-fonte recém-extraído.
# Todos os comandos subsequentes serão executados neste contexto.
cd yad-14.1

# Fase de configuração do Meson. Cria um subdiretório 'build' para manter
# os arquivos de compilação separados do código-fonte.
meson setup build

# Fase de compilação. Invoca o Ninja para compilar o projeto dentro do
# diretório 'build'.
ninja -C build

# Mensagem de confirmação para o usuário indicando que o processo foi bem-sucedido.
echo "Compilação do YAD 14.1 concluída com sucesso."
