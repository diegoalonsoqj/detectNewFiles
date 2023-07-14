# detectNewFiles
Este script de Bash se utiliza para monitorizar cambios en un directorio específico y cambiar los permisos de cualquier archivo nuevo que se coloque en ese directorio.

##Monitoreo y Modificación de Permisos de Archivos en Bash

Este repositorio contiene un script de Bash, detectNewFiles.sh, que monitorea de manera continua un directorio específico para detectar la creación de nuevos archivos o el movimiento de archivos hacia el directorio. Cuando se detecta un nuevo archivo, el script cambia sus permisos a 777 (lectura, escritura y ejecución para todos los usuarios) y registra la acción y su resultado en un archivo de log.

##Funcionamiento Detallado
Definición de Variables: El script define dos variables. MONITOR_DIR se refiere al directorio que se va a monitorear y LOG_FILE a la ruta del archivo de log donde se registrará la información de los eventos.

Monitorización de Eventos: El comando inotifywait se utiliza con la opción -m para mantener la monitorización de manera indefinida. Se monitorean dos tipos de eventos, create (creación de un archivo) y moved_to (movimiento de un archivo al directorio). La salida de inotifywait se canaliza hacia un bucle while.

Procesamiento de Eventos: Dentro del bucle while, se leen los detalles del evento, incluyendo el directorio, el tipo de acción y el archivo.

Registro de Eventos: Se registra en el archivo de log la fecha y hora del evento, el archivo involucrado, el directorio donde ocurrió y la acción.

Modificación de Permisos: Se utiliza el comando chmod para cambiar los permisos del archivo a 777.

Registro de Cambio de Permisos: Se verifica si el cambio de permisos fue exitoso comprobando el valor de $?. Si es igual a 0, el cambio fue exitoso y se registra en el archivo de log. Si no es 0, el cambio falló y también se registra en el archivo de log.

##Cómo Utilizar
Para utilizar este script, clone este repositorio, navegue al directorio del script en la terminal y ejecute el script con el comando ./detectNewFiles.sh. Asegúrese de que el script tenga permisos de ejecución y actualice las variables MONITOR_DIR y LOG_FILE según sea necesario.
