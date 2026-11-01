#!/bin/bash
# omarsp31-7.sh
# Si alguna partición supera el umbral, registra fecha, hora, partición y % de uso.

UMBRAL=80
LOG="$HOME/disco_omar.log"        # fichero de registro propio

# df -P: formato estable; solo dispositivos reales (/dev/...), sin los loop de snap
df -P | awk 'NR>1 && $1 ~ "^/dev/" && $1 !~ "loop" {print $1, $5}' | while read -r particion uso; do
    uso=${uso%\%}                  # quita el símbolo %
    if [ "$uso" -gt "$UMBRAL" ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Partición: $particion - Uso: ${uso}%" >> "$LOG"
    fi
done
