#!/bin/bash
# omarsp31-9.sh
# Mantiene /bacomar/espejo como copia exacta de /home/omar
# -a conserva permisos, fechas y propietarios; --delete elimina lo borrado en origen
ORIGEN="/home/omaradd/"
DESTINO="/bacomar/espejo/"
mkdir -p "$DESTINO"
rsync -a --delete --itemize-changes --stats "$ORIGEN" "$DESTINO"
