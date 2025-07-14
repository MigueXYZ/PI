#!/bin/bash

FICHEIRO_CONF="/etc/mysql/mysql.conf.d/mysqld.cnf"

echo " A criar diretório de configuração se necessário..."
sudo mkdir -p /etc/mysql/mysql.conf.d

echo " A escrever configuração em $FICHEIRO_CONF..."

sudo tee "$FICHEIRO_CONF" > /dev/null <<EOF
[mysqld]
log_error = syslog
general_log = 1
general_log_file = syslog
slow_query_log = 1
slow_query_log_file = syslog
EOF

echo " A reiniciar o serviço MySQL..."
if sudo systemctl restart mysql; then
    echo " MySQL reiniciado com sucesso."
    echo " A escrever log de teste..."
    logger -t mysql "Teste de log do MySQL"
    echo "️ Verifica os logs do sistema com: sudo journalctl -t mysql"
else
    echo " Erro ao reiniciar o MySQL. Consulta os logs com: journalctl -xe"
fi
