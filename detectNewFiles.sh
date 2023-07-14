#!/bin/bash

MONITOR_DIR="/Documentos"
LOG_FILE="/var/log/scriptsDBA/detectNewFiles.log"

inotifywait -m $MONITOR_DIR -e create -e moved_to |
    while read dir action file; do
        echo "[date '+%Y-%m-%d %H:%M:%S'] - El archivo '$file' aparecio en el directorio '$dir' por accion '$action'" >> $LOG_FILE
        chmod 777 "$dir$file"
        if [ $? -eq 0 ]
        then
            echo "[date '+%Y-%m-%d %H:%M:%S'] - El archivo '$file' ha sido modificado con exito a 777" >> $LOG_FILE
        else
            echo "[date '+%Y-%m-%d %H:%M:%S'] - La modificacion de permisos fallo para el archivo '$file'" >> $LOG_FILE
        fi
    done