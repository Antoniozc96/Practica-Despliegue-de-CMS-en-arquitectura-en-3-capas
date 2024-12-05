#!/bin/bash
# Actualizar e instalar NFS y utilidades
apt update -y
apt install -y nfs-kernel-server unzip curl php php-mysql mysql-client

# Crear carpeta compartida y asignar permisos
mkdir -p /var/nfs/shared
chown -R nobody:nogroup /var/nfs/shared

# Configurar acceso desde los servidores con las nuevas IPs
sed -i '$a /var/nfs/shared	172.50.130.70(rw,sync,no_subtree_check)' /etc/exports
sed -i '$a /var/nfs/shared	172.50.143.215(rw,sync,no_subtree_check)' /etc/exports

# Descargar e instalar WordPress
curl -O https://wordpress.org/latest.zip
unzip -o latest.zip -d /var/nfs/shared/
chmod 755 -R /var/nfs/shared/
chown -R www-data:www-data /var/nfs/shared/*

# Reiniciar el servidor NFS
systemctl restart nfs-kernel-server
