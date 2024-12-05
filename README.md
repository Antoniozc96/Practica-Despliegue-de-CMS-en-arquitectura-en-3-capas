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
````
Actualizar e instalar Apache
apt update -y
apt install -y apache2
````





  
