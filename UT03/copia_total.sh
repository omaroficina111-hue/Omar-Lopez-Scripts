#!/bin/bash
# /scromar/copia_total.sh
# Copia total mensual de /home. Además actualiza la marca de referencia.
NOMBRE="CopTot-$(date +%B-%Y)"
tar -czf "/bacomar/$NOMBRE.tar.gz" /home 2>/dev/null
touch /bacomar/.marca_total
