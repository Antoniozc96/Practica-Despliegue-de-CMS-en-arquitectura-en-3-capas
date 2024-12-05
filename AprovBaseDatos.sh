#!/bin/bash
# Actualizar e instalar MySQL y PhpMyAdmin
apt update -y

apt install -y mysql-server phpmyadmin

# Configurar MySQL para permitir conexiones remotas desde las nuevas IPs
sed -i "s/^bind-address.*/bind-address = 172.50.151.207/" /etc/mysql/mysql.conf.d/mysqld.cnf

# Reiniciar MySQL
systemctl restart mysql

# Crear base de datos y usuario con acceso desde los servidores
mysql <<EOF
CREATE DATABASE db_wordpress;
CREATE USER 'antonio'@'172.50.%' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON db_wordpress.* TO 'antonio'@'172.50.%';
FLUSH PRIVILEGES;
EOF
