#!/bin/bash
# Actualizar e instalar Apache
apt update -y
apt install -y apache2

# Habilitar módulos de proxy y balanceador en Apache
a2enmod proxy
a2enmod proxy_http
a2enmod proxy_balancer
a2enmod lbmethod_byrequests

# Crear configuración para el balanceador de carga
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/load-balancer.conf

# Comentar DocumentRoot
sed -i 's|^\(.*DocumentRoot /var/www/html\)|#\1|' /etc/apache2/sites-available/load-balancer.conf

# Configurar el balanceador de carga
sed -i '/<\/VirtualHost>/i \
<Proxy balancer://mycluster>\n\
	# Server 1\n\
	BalancerMember http://172.50.140.33\n\
	# Server 2\n\
	BalancerMember http://172.50.141.148\n\
</Proxy>\n\
\n\
# Todas las peticiones se enviarán al balanceador\n\
ProxyPass / balancer://mycluster/\n\
ProxyPassReverse / balancer://mycluster/' /etc/apache2/sites-available/load-balancer.conf

# Activar el nuevo sitio y desactivar el sitio por defecto
a2ensite load-balancer.conf
a2dissite 000-default.conf

# Reiniciar Apache
systemctl restart apache2
