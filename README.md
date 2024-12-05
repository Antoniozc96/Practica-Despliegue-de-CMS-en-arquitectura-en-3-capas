# Antonio Zancada Cáceres
# Índice

1. [Introducción](#introducción)
2. [Objetivos](#objetivos)
3. [Requisitos](#requisitos)
4. [Pasos de la configuración](#pasos-de-la-configuración)
5. [Aprovisionamientos](#aprovisionamientos)
6. [Wordpress](#wordpress)

## Introducción
En esta tarea, implementaremos una arquitectura LAMP para WordPress dividida en tres capas. En la primera capa, un balanceador de carga distribuirá el tráfico entre dos servidores backend en la segunda capa, donde se ejecutarán Apache y PHP conectados a un servidor NFS para el almacenamiento compartido. Por último, en la tercera capa, un servidor MySQL gestionará la base de datos, garantizando un diseño escalable, redundante y eficiente.

## Objetivos
El objetivo de este proyecto es desplegar un CMS WordPress en alta disponibilidad y escalabilidad utilizando AWS. Para ello, se implementará una arquitectura distribuida en tres capas:

Capa 1: Capa pública. En esta capa se ubicará un balanceador de carga que distribuirá las peticiones entrantes a los servidores de backend.

Capa 2: Capa privada. Esta capa alojará los servidores backend y un servidor NFS. Los servidores backend serán responsables de ejecutar el servidor web Apache y PHP, mientras que el servidor NFS proporcionará almacenamiento compartido para todos los recursos del CMS.

Capa 3: Capa privada. Aquí se encontrará el servidor de base de datos, que se encargará de gestionar todas las operaciones de base de datos utilizando MySQL o MariaDB.

## Requisitos
Cuenta de AWS configurada: Necesitarás una cuenta activa de AWS y configurada para usar los servicios requeridos.

CLI de AWS instalado: Debes tener la CLI de AWS instalada y configurada para gestionar tus recursos.

Claves SSH: Asegúrate de tener las claves SSH necesarias para acceder a las instancias.

Conocimientos básicos de Linux: Es fundamental tener conocimientos básicos de comandos de Linux para la instalación y configuración de los servidores.

## Pasos de la configuración
### Configuración de las VPCs

En esta práctica que llevaremos a cabo en AWS, es necesario crear una Red Privada Virtual (VPC). Esta VPC constará de tres subredes distintas. La primera subred será de tipo pública y se conectará a una instancia ubicada en la primera capa de nuestra infraestructura, cuyo propósito será actuar como un balanceador de carga.
Las otras dos subredes serán privadas. Estas subredes estarán conectadas a las instancias en la segunda y tercera capa de nuestra arquitectura, lo que incluye servidores backend, servidores NFS y el servidor de base de datos MySQL.

### Configuración de la VPC

* Asignar un nombre adecuado a la nueva VPC.
* Definir el bloque CIDR IPv4 para esta VPC.

Este paso inicial es crucial para establecer una red eficiente y segura, asegurando que los componentes de nuestra arquitectura estén correctamente segregados y accesibles según las necesidades de cada capa.
* Establecemos un nombre a nuestra nueva VPC y establecer su rango de direcciones IP utilizando el bloque CIDR IPv4.
![VPC 1](https://github.com/user-attachments/assets/5d204d22-d1e5-448a-981f-df1edea43632)

* Determinamos la cantidad de zonas de disponibilidad y especificamos el número de subredes tanto públicas como privadas.
![VPC 2](https://github.com/user-attachments/assets/6ab85d86-57ae-4bce-ab6e-4e081ccae2f4)

* Le damos "Crear VPC" y esperamos a que el proceso se complete.
![vpc 3](https://github.com/user-attachments/assets/d0bfcebd-ba20-4da8-8dde-6c2b25fa483d)

* Verificamos que la VPC y sus subredes se han creado correctamente.
![vpc 4](https://github.com/user-attachments/assets/eac91753-1798-4d81-932f-5f8392e5095f)
![vpc 5](https://github.com/user-attachments/assets/2fd38885-4a6c-4fbd-98f2-2bddb5b557ac)

### Creación de las instancias.
A continuación, procederemos a crear varias instancias utilizando una AMI de Ubuntu-Server 24.04. Una de estas instancias actuará como balanceador de carga, gestionando las solicitudes provenientes de internet en la primera capa de nuestra arquitectura. Este balanceador dirigirá el tráfico hacia los servidores backend ubicados en la segunda capa, que a su vez estarán conectados al servidor MySQL en la tercera capa de nuestra estructura de tres niveles. En este ejemplo, mostraré cómo se configura el balanceador de carga como modelo para todas las instancias, explicando el resultado final esperado y el número de máquinas que deben estar disponibles al finalizar el proceso.

## Paso 1: Asignación de Nombre y Selección de AMI
Primero, le damos un nombre a la instancia y seleccionamos la AMI (Amazon Machine Image) que vamos a utilizar.

## Paso 2: Definición del Tipo de Instancia y Creación de Claves SSH
Luego, definimos el tipo de instancia que utilizaremos y generamos las claves SSH necesarias para acceder a la instancia de forma segura.

## Paso 3: Configuración de la Red
A continuación, configuramos los parámetros de red, asegurándonos de que la instancia esté correctamente conectada a la red deseada.

## Paso 4: Creación del Grupo de Seguridad para la Instancia
Finalmente, creamos un grupo de seguridad para la instancia, especificando las reglas de tráfico que controlarán el acceso a la misma.

# Creación instancia Balanceador
![instancia1](https://github.com/user-attachments/assets/1c66dc7a-aa02-4c69-866a-391cfeea1c2b)
![instancia2](https://github.com/user-attachments/assets/61961769-5b45-44a5-9245-de470be69a5e)
![instancia3](https://github.com/user-attachments/assets/eead9855-1c79-42c0-b27b-e3386d916ade)
![instancia4](https://github.com/user-attachments/assets/04a452e3-9649-454a-9f6c-dfbc5a843934)
![instancia5](https://github.com/user-attachments/assets/6060229b-f9c0-4ce3-adb3-7dda007b3e85)

# Creación de la instancia Server 1 y Server 2
![instanciaSer1](https://github.com/user-attachments/assets/2a0c4734-9c06-4880-9e0f-c2b44d76696d)
![instanciaSer2](https://github.com/user-attachments/assets/7c380dd1-b845-4d81-a263-4ab01c1f2984)
![instanciaSer3](https://github.com/user-attachments/assets/9cb7be7f-62be-493e-8479-4fd2cf59b146)

# Grupos de seguridad

## Capa 1: Capa pública (Balanceador de carga)

**Grupo de Seguridad del Balanceador de Carga:**

- **Reglas de Ingreso:**
  - **Puerto 80 (HTTP):** Protocolo TCP desde cualquier lugar (0.0.0.0/0) para permitir tráfico HTTP público.
  - **Puerto 443 (HTTPS):** Protocolo TCP desde cualquier lugar (0.0.0.0/0) para permitir tráfico HTTPS público.

## Capa 2: Capa privada (Servidores Backend + NFS)

**Grupo de Seguridad de los Servidores Web:**

- **Reglas de Ingreso:**
  - **Puerto 80 (HTTP):** Protocolo TCP desde el grupo de seguridad del Balanceador de Carga, permitiendo tráfico HTTP desde el balanceador.
  - **Puerto 2049 (NFS):** Protocolo TCP desde el grupo de seguridad del Servidor NFS, permitiendo comunicación con el servidor NFS.

**Grupo de Seguridad del Servidor NFS:**

- **Reglas de Ingreso:**
  - **Puerto 2049 (NFS):** Protocolo TCP desde el grupo de seguridad de los Servidores Web, permitiendo compartir archivos con los servidores web.

## Capa 3: Capa privada (Servidor de Base de Datos)

**Grupo de Seguridad del Servidor de Base de Datos:**

- **Reglas de Ingreso:**
  - **Puerto 3306 (MySQL):** Protocolo TCP desde el grupo de seguridad de los Servidores Web, permitiendo tráfico MySQL desde los servidores web.

## Resumen de las configuraciones
- **Acceso externo restringido** solo a la capa pública.
- **Impedir conectividad directa** entre las capas 1 y 3.
- **Protección mediante grupos de seguridad** con reglas específicas para cada capa.

## Aprovisionamientos
### Aprovisionamiento Balanceador

1. Actualizar e instalar Apache: Actualiza la lista de paquetes e instala el servidor web Apache.
````
apt update -y
apt install -y apache2
````

2. Habilitar módulos: Activa los módulos de proxy, proxy HTTP, balanceador y el método de balanceo por solicitudes en Apache.
````
a2enmod proxy
a2enmod proxy_http
a2enmod proxy_balancer
a2enmod lbmethod_byrequests
````
3. Crear configuración del balanceador: Copia el archivo de configuración por defecto para crear uno nuevo específico para el balanceador de carga.
````
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/load-balancer.conf
````
4. Comentar DocumentRoot: Comenta la línea DocumentRoot en el archivo de configuración del balanceador para evitar conflictos.
````
sed -i 's|^\(.*DocumentRoot /var/www/html\)|#\1|' /etc/apache2/sites-available/load-balancer.conf
````
5. Configurar balanceador de carga: Añade la configuración del proxy y los miembros del balanceador en el archivo de configuración. Define que todas las peticiones se envíen y se respondan a través del balanceador.
````
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
````
6. Activar y desactivar sitios: Activa el nuevo sitio del balanceador de carga y desactiva el sitio por defecto de Apache.
````
# Activar el nuevo sitio y desactivar el sitio por defecto
a2ensite load-balancer.conf
a2dissite 000-default.conf
````
7. Reiniciar Apache: Reinicia el servicio de Apache para aplicar los cambios de configuración.
````
systemctl restart apache2
````

# Aprovisionamiento Servidor NFS
1. Actualizar e instalar NFS y utilidades: Actualiza la lista de paquetes disponibles e instala los paquetes necesarios: el servidor NFS, unzip, curl, PHP, el módulo PHP para MySQL y el cliente de MySQL.
````
apt update -y
apt install -y nfs-kernel-server unzip curl php php-mysql mysql-client
````
2. Crear carpeta compartida y asignar permisos: Crea el directorio /var/nfs/shared para compartir archivos y cambia el propietario del directorio a nobody:nogroup para controlar el acceso.
````
mkdir -p /var/nfs/shared
chown -R nobody:nogroup /var/nfs/shared
````
3. Configurar acceso desde los servidores: Agrega entradas al archivo /etc/exports para permitir el acceso al directorio compartido desde las direcciones IP 172.50.130.70 y 172.50.143.215 con permisos de lectura/escritura y sincronización (rw,sync).
````
# Configurar acceso desde los servidores con las nuevas IPs
sed -i '$a /var/nfs/shared  172.50.130.70(rw,sync,no_subtree_check)' /etc/exports
sed -i '$a /var/nfs/shared  172.50.143.215(rw,sync,no_subtree_check)' /etc/exports
````
4. Descargar e instalar WordPress:
   *  curl -O https://wordpress.org/latest.zip: Descarga el archivo zip de WordPress desde el sitio oficial.
   *  unzip -o latest.zip -d /var/nfs/shared/: Descomprime el archivo zip descargado en el directorio /var/nfs/shared/.
   *  chmod 755 -R /var/nfs/shared/: Cambia los permisos de los archivos descomprimidos a 755 para que sean legibles y ejecutables.
   *  chown -R www-data:www-data /var/nfs/shared/:* Cambia el propietario de los archivos descomprimidos a www-data, el usuario del servidor web.
````
curl -O https://wordpress.org/latest.zip
unzip -o latest.zip -d /var/nfs/shared/
chmod 755 -R /var/nfs/shared/
chown -R www-data:www-data /var/nfs/shared/*
````
5. Reiniciar el servidor NFS: Reinicia el servicio NFS para aplicar todos los cambios de configuración realizados.
````
systemctl restart nfs-kernel-server
````

#Aprovisionamiento Servidores 1 y 2
1. Actualizar e instalar Apache y PHP con módulos necesarios: Actualiza la lista de paquetes disponibles e instala el servidor web Apache, los módulos NFS y varios módulos PHP necesarios para ejecutar WordPress.
````
# Actualizar e instalar Apache y PHP con módulos necesarios
apt update -y
apt install -y apache2 nfs-common php libapache2-mod-php php-mysql php-curl php-gd php-xml php-mbstring php-xmlrpc php-zip php-soap
````
2. Habilitar el módulo rewrite: Activa el módulo rewrite de Apache, necesario para la reescritura de URLs.
````
a2enmod rewrite
````
3. Configurar el sitio web para que use la carpeta compartida de NFS: Modifica el archivo de configuración del sitio web de Apache para usar el directorio compartido de NFS como raíz del documento.
````
sed -i 's|DocumentRoot .*|DocumentRoot /nfs/shared/wordpress|' /etc/apache2/sites-available/000-default.conf
````
4. Configurar permisos del directorio: Añade una sección de configuración al archivo de Apache para establecer los permisos del directorio compartido de NFS.
````
# Configurar permisos del directorio
sed -i '/<\/VirtualHost>/i \
<Directory /nfs/shared/wordpress>\
    Options Indexes FollowSymLinks\
    AllowOverride All\
    Require all granted\
</Directory>' /etc/apache2/sites-available/000-default.conf
````
5. Crear configuración personalizada: Copia el archivo de configuración por defecto para crear uno nuevo específico para el sitio web.
````
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/websv.conf
````
6. Montar la carpeta compartida desde el servidor NFS: Crea el directorio para el montaje y monta el directorio compartido desde el servidor NFS.
````
mkdir -p /nfs/shared mount 172.50.138.11:/var/nfs/shared /nfs/shared
````
7. Configurar montaje automático en /etc/fstab: Añade la configuración de montaje al archivo /etc/fstab para que el montaje se realice automáticamente en el arranque del sistema y monta todas las entradas del archivo de fstab.
````
echo "172.50.138.11:/var/nfs/shared /nfs/shared nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" | sudo tee -a /etc/fstab
mount -a
````
8. Desactivar el sitio por defecto y activar el nuevo sitio: Desactiva el sitio por defecto de Apache y activa el nuevo sitio configurado.
````
a2dissite 000-default.conf
a2ensite websv.conf
````
9. Reiniciar Apache: Reinicia el servicio de Apache para aplicar los cambios de configuración.
````
systemctl restart apache2
systemctl reload apache2
````

#Aprovisionamiento Server Base de datos
1. Actualizar e instalar MySQL y PhpMyAdmin: Actualiza la lista de paquetes disponibles e instala MySQL Server y PhpMyAdmin.
````
apt update -y
apt install -y mysql-server phpmyadmin
````
2. Configurar MySQL para conexiones remotas: Modifica el archivo de configuración de MySQL para permitir conexiones remotas desde la dirección IP 172.50.151.207
````
sed -i "s/^bind-address.*/bind-address = 172.50.151.207/" /etc/mysql/mysql.conf.d/mysqld.cnf
````
3. Reiniciar MySQL: Reinicia el servicio de MySQL para aplicar los cambios de configuración.
````
systemctl restart mysql
````
4. Crear base de datos y usuario con acceso remoto: Accede a MySQL y ejecuta los comandos para crear la base de datos db_wordpress, crear el usuario antonio con acceso desde las direcciones IP que empiezan por 172.50.%, y otorgar todos los privilegios en la base de datos db_wordpress a este usuario. Finalmente, refresca los privilegios para aplicar los cambios.
````
mysql <<EOF
CREATE DATABASE db_wordpress;
CREATE USER 'antonio'@'172.50.%' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON db_wordpress.* TO 'antonio'@'172.50.%';
FLUSH PRIVILEGES;
EOF
````
# Wordpress
* Ponemos la dirección pública de la instancia Balanceador en el buscador para comprobar que se conecta con Wordpress.

![WORDPRESS 1](https://github.com/user-attachments/assets/edc0bc4b-162f-4e71-af45-67e35f248da8)
![WORDPRESS 2](https://github.com/user-attachments/assets/59c0ec1b-0940-4229-8f2e-dd59cbb3522a)
![WORDPRESS 3](https://github.com/user-attachments/assets/6c7db645-c228-4e4f-837a-693cd0648937)

* A continuación, procederemos correcta instalación de Wordpress.
![WORDPRESS 4](https://github.com/user-attachments/assets/ae86698f-0994-4410-8a81-da66b71f11b2)
![WORDPRESS 5](https://github.com/user-attachments/assets/34a2eb92-103a-4040-9f5f-dc8ad5c079cd)
![WORDPRESS 6](https://github.com/user-attachments/assets/912ce064-d808-4c09-8176-86ab22d5c895)

* Worpress con HTTPS
Después de completar la configuración, ahora he creado un dominio y lo he asociado con la dirección pública del balanceador de carga.
Esto significa que puedes acceder a tu sitio de WordPress de manera segura utilizando HTTPS.
![Captura de pantalla 2024-12-05 173443](https://github.com/user-attachments/assets/a8eef011-c579-490d-ae27-d6a862615a90)

