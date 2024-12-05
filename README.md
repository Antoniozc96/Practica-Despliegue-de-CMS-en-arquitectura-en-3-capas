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
Aquí va el contenido de la sección Requisitos.

## Pasos de la configuración
Aquí va el contenido de la sección Pasos de la configuración.

## Aprovisionamientos
Aquí va el contenido de la sección Aprovisionamientos.


  
