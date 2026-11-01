#!/bin/bash
# omarsp31-4.sh
# Desinstala los programas indicados en programas.txt (uno por línea).
# El fichero debe estar en el mismo directorio que este script.

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LISTA="$DIR/programas.txt"

if [ "$EUID" -ne 0 ]; then
    echo "Ejecuta el script con sudo."
    exit 1
fi

if [ ! -f "$LISTA" ]; then
    echo "No existe $LISTA"
    exit 1
fi

while IFS= read -r prog || [ -n "$prog" ]; do
    [ -z "$prog" ] && continue                      # ignora líneas vacías
    if dpkg -l "$prog" 2>/dev/null | grep -q '^ii'; then
        echo ">> Desinstalando $prog ..."
        apt-get purge -y "$prog" < /dev/null
    else
        echo "AVISO: $prog no está instalado. Continuo con el siguiente."
    fi
done < "$LISTA"

apt-get autoremove -y < /dev/null
echo "Proceso terminado."
