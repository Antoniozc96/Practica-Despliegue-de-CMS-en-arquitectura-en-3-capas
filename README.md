# Practica-Despliegue-de-CMS-en-arquitectura-en-3-capas

# Antonio Zancada Cáceres
# Índice

1. [Introducción](#introducción)
2. [Objetivos](#objetivos)
3. [Requisitos](#requisitos)
4. [Pasos de la configuración](#pasos-de-la-configuración)
5. [Aprovisionamientos](#aprovisionamientos)

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
### Establecemos un nombre a nuestra nueva VPC y establecer su rango de direcciones IP utilizando el bloque CIDR IPv4.
![VPC 1](https://github.com/user-attachments/assets/5d204d22-d1e5-448a-981f-df1edea43632)

#### Determinamos la cantidad de zonas de disponibilidad y especificamos el número de subredes tanto públicas como privadas.
![VPC 2](https://github.com/user-attachments/assets/6ab85d86-57ae-4bce-ab6e-4e081ccae2f4)

### Le damos "Crear VPC" y esperamos a que el proceso se complete.
![vpc 3](https://github.com/user-attachments/assets/d0bfcebd-ba20-4da8-8dde-6c2b25fa483d)

### Verificamos que la VPC y sus subredes se han creado correctamente.
![vpc 4](https://github.com/user-attachments/assets/eac91753-1798-4d81-932f-5f8392e5095f)

![vpc 5](https://github.com/user-attachments/assets/2fd38885-4a6c-4fbd-98f2-2bddb5b557ac)


## Aprovisionamientos
Aquí va el contenido de la sección Aprovisionamientos.


  
