#!/bin/bash

# Uso: ./detetar_os_remoto.sh utilizador@ip

DESTINO="$1"

if [ -z "$DESTINO" ]; then
    echo "Uso: $0 utilizador@ip_ou_hostname"
    exit 1
fi

echo "A ligar a $DESTINO..."

# Primeiro, tenta uname (Linux/macOS)
OS_INFO=$(ssh -o BatchMode=yes "$DESTINO" 'uname -a' 2>/dev/null)

if [ $? -eq 0 ]; then
    echo "Detetado sistema Unix-like:"
    echo "$OS_INFO"
    exit 0
fi

# Se falhar, tenta PowerShell (Windows)
OS_INFO=$(ssh -o BatchMode=yes "$DESTINO" 'powershell -Command "Get-CimInstance Win32_OperatingSystem | Select-Object Caption, Version, OSArchitecture"' 2>/dev/null)

if [[ "$OS_INFO" == *"Caption"* ]]; then
    echo "Detetado sistema Windows:"
    echo "$OS_INFO"
    exit 0
fi

# Última tentativa: comando ver (cmd)
OS_INFO=$(ssh -o BatchMode=yes "$DESTINO" 'ver' 2>/dev/null)

if [[ "$OS_INFO" == *"Microsoft"* ]]; then
    echo "Detetado sistema Windows (cmd):"
    echo "$OS_INFO"
    exit 0
fi

echo "Não foi possível identificar o sistema operativo remotamente."
exit 2
