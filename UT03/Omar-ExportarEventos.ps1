# Crea la carpeta de destino
New-Item -ItemType Directory -Path C:\Logs -Force | Out-Null

# Acción: exportar el registro Sistema con la fecha en el nombre
$accion = New-ScheduledTaskAction -Execute 'powershell.exe' `
    -Argument '-NoProfile -Command "wevtutil epl System (\"C:\Logs\System_\" + (Get-Date -Format yyyyMMdd) + \".evtx\")"'

# Desencadenador: todos los días a las 02:00
$disparador = New-ScheduledTaskTrigger -Daily -At 2:00AM

# Se ejecuta como SYSTEM con privilegios máximos
$principal = New-ScheduledTaskPrincipal -UserId 'SYSTEM' -RunLevel Highest

# Registro de la tarea
Register-ScheduledTask -TaskName 'Omar-ExportarEventos' -Action $accion `
    -Trigger $disparador -Principal $principal `
    -Description 'Exporta el registro Sistema cada día'

# Comprobación del estado (debe ser Ready)
Get-ScheduledTask -TaskName 'Omar-ExportarEventos' | Select-Object TaskName, State