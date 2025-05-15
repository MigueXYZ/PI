#!/bin/bash

echo "Detectar o sistema operativo..."

# Verifica se o comando uname está disponível
if ! command -v uname &> /dev/null; then
    echo "Erro: o comando 'uname' não está disponível."
    exit 1
fi

# Detectar o sistema base
OS_NAME=$(uname -s)

case "$OS_NAME" in
    Linux)
        # Mais detalhes sobre distribuições Linux
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            echo "Sistema operativo: $NAME ($ID)"
            echo "Versão: $VERSION"
        else
            echo "Sistema operativo: Linux (distribuição desconhecida)"
        fi
        ;;
    Darwin)
        echo "Sistema operativo: macOS"
        sw_vers 2>/dev/null
        ;;
    FreeBSD)
        echo "Sistema operativo: FreeBSD"
        ;;
    CYGWIN*|MINGW*|MSYS*)
        echo "Sistema operativo: Windows (via terminal compatível)"
        ;;
    *)
        echo "Sistema operativo desconhecido: $OS_NAME"
        ;;
esac
