#!/bin/bash
# /scromar/copia_diferencial.sh
# Copia diferencial semanal de /home: solo lo modificado desde la última copia total.
NOMBRE="CopDifSem-$(date +%V)"
MARCA="/bacomar/.marca_total"
tar -czf "/bacomar/$NOMBRE.tar.gz" -N "$(date -r "$MARCA" '+%Y-%m-%d %H:%M:%S')" /home 2>/dev/null
