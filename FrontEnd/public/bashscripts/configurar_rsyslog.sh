#!/bin/bash

# Verificar se o script está a ser corrido como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor corre como root (sudo $0)"
  exit 1
fi

# Verificar se foi fornecido o IP como argumento
if [ -z "$1" ]; then
  echo "Uso: sudo $0 <ip-do-servidor>"
  exit 1
fi

IP_SERVIDOR="$1"

echo "1. Atualizar pacotes e instalar rsyslog..."
apt update && apt install -y rsyslog

echo "2. Verificar se o rsyslog está ativo..."
systemctl enable rsyslog
systemctl start rsyslog
systemctl status rsyslog --no-pager

echo "3. Fazer backup do ficheiro original..."
cp /etc/rsyslog.conf /etc/rsyslog.conf.bak

echo "4. Adicionar IP do servidor de logs ao fim do ficheiro..."
echo "" >> /etc/rsyslog.conf
echo "# Envio de logs para servidor remoto" >> /etc/rsyslog.conf
echo "*.* @$IP_SERVIDOR" >> /etc/rsyslog.conf

echo "5. Reiniciar o rsyslog para aplicar alterações..."
systemctl restart rsyslog

echo "✅ Configuração concluída. Logs a ser enviados para $IP_SERVIDOR"
