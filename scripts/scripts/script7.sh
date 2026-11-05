#!/bin/bash
if ! command -v cal >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y ncal
fi
cal
echo "Tiempo encendida:"
uptime -p
echo "Usuarios conectados:"
who
