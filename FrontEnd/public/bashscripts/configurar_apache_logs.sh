#!/bin/bash

# Verifica se o IP foi passado como argumento
if [ -z "$1" ]; then
  echo "Erro: tens de fornecer o IP do servidor como argumento."
  echo "Uso: sudo ./configurar_apache_logs.sh <ip-do-servidor>"
  exit 1
fi

IP_SERVIDOR="$1"

CONF_FILE="/etc/apache2/sites-available/000-default.conf"
RSYSLOG_FILE="/etc/rsyslog.d/20-apache.conf"
BACKUP_FILE="/etc/apache2/sites-available/000-default.conf.bak.$(date +%Y%m%d%H%M%S)"

echo "Criando backup do ficheiro original em $BACKUP_FILE"
sudo cp "$CONF_FILE" "$BACKUP_FILE"

echo "Comentando linhas originais de logs se estiverem descomentadas..."
sudo sed -i -r 's/^([[:space:]]*)(ErrorLog[[:space:]]+\$\{APACHE_LOG_DIR\}\/error\.log)/#\1\2/' "$CONF_FILE"
sudo sed -i -r 's/^([[:space:]]*)(CustomLog[[:space:]]+\$\{APACHE_LOG_DIR\}\/access\.log combined)/#\1\2/' "$CONF_FILE"

echo "Verificando se as novas linhas de logs já existem..."
if ! grep -q 'ErrorLog "syslog:local1"' "$CONF_FILE"; then
    echo "Adicionando ErrorLog \"syslog:local1\"..."
    sudo sed -i '/<VirtualHost \*:80>/a \    ErrorLog "syslog:local1"' "$CONF_FILE"
fi

if ! grep -q 'CustomLog "syslog:local2" combined' "$CONF_FILE"; then
    echo "Adicionando CustomLog \"syslog:local2\" combined..."
    sudo sed -i '/ErrorLog "syslog:local1"/a \    CustomLog "syslog:local2" combined' "$CONF_FILE"
fi

echo "A reiniciar o Apache para aplicar as mudanças..."
sudo systemctl restart apache2

echo "Criando e preenchendo o ficheiro rsyslog: $RSYSLOG_FILE"
sudo tee "$RSYSLOG_FILE" > /dev/null <<EOF
local1.* @$IP_SERVIDOR:514
local2.* @$IP_SERVIDOR:514
EOF

echo "A reiniciar o Rsyslog..."
sudo systemctl restart rsyslog

echo " Teste de resposta do Apache local:"
curl -I http://localhost

echo "Script concluído com sucesso."
