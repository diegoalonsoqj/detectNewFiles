#!/bin/bash

# @reboot /scriptsDBA/detectNewFiles.sh

MONITOR_DIR="/Documentos"
LOG_FILE="/var/log/scriptsDBA/detectNewFiles.log"

# Aplica permisos 777 a todos los archivos ya existentes en el directorio
for file in "$MONITOR_DIR"/*
do
    if [ -f "$file" ]
    then
        chmod 777 "$file"
        if [ $? -eq 0 ]
        then
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] - El archivo '$file' se ha modificado con exito a 777 sin vigilancia" >> $LOG_FILE
        else
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] - La modificacion de permisos sin vigilancia fallo para el archivo '$file'" >> $LOG_FILE
        fi
    fi
done

# Captura el PID del script
echo "[$(date '+%Y-%m-%d %H:%M:%S')] - El PID de este script es $$" >> $LOG_FILE

# Se lanza inotifywait en background y se captura su PID
inotifywait -m $MONITOR_DIR -e create -e moved_to --format '%w %e %f' --outfile /tmp/inotify-output.$$ &
INOTIFY_PID=$!

echo "[$(date '+%Y-%m-%d %H:%M:%S')] - El PID de inotifywait es $INOTIFY_PID" >> $LOG_FILE

# Procesa la salida de inotifywait
tail -f /tmp/inotify-output.$$ | while read dir action file
do
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] - El archivo '$file' aparecio en el directorio '$dir' por accion '$action'" >> $LOG_FILE
    chmod 777 "${dir}${file}"
    if [ $? -eq 0 ]
    then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] - El archivo '$file' ha sido modificado con exito a 777" >> $LOG_FILE
    else
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] - La modificacion de permisos fallo para el archivo '$file'" >> $LOG_FILE
    fi
done

# Limpia al salir
trap "rm -f /tmp/inotify-output.$$; kill $INOTIFY_PID" EXIT