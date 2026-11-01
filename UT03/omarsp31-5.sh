#!/bin/bash
# omarsp31-5.sh
# Recorre /var/log, busca líneas con "error" o "fail" (sin distinguir mayúsculas)
# y genera un informe separando visualmente cada fichero de origen.

INFORME="$HOME/informe_errores_$(date +%F_%H-%M).txt"   # fuera de /var/log

{
    echo "INFORME DE ERRORES - $(date '+%d/%m/%Y %H:%M:%S') - equipo $(hostname)"
    echo "=========================================================="
} > "$INFORME"

find /var/log -type f 2>/dev/null | sort | while read -r fichero; do
    # -I ignora binarios, -i no distingue mayúsculas, -E permite el OR
    coincidencias=$(grep -IiE 'error|fail' "$fichero" 2>/dev/null)
    if [ -n "$coincidencias" ]; then
        {
            echo
            echo "##########################################################"
            echo "# ARCHIVO: $fichero"
            echo "##########################################################"
            echo "$coincidencias"
        } >> "$INFORME"
    fi
done

echo "Informe generado en: $INFORME"
