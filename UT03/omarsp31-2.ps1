# omarsp31-2.ps1
# Muestra los inicios de sesión (evento 4624 del registro Seguridad) entre dos fechas.
# Uso: .\omarsp31-2.ps1 -FechaInicio 01/10/2026 -FechaFin 31/10/2026
# Ejecutar en PowerShell como administrador (el registro Seguridad lo requiere).

param(
    [Parameter(Mandatory=$true)][datetime]$FechaInicio,   # fecha de inicio
    [Parameter(Mandatory=$true)][datetime]$FechaFin       # fecha de fin
)

# Consulta eficiente: el filtro se aplica en el propio Get-WinEvent
# Se suma un día a FechaFin para incluir completo el último día
$eventos = Get-WinEvent -FilterHashtable @{
    LogName   = 'Security'
    Id        = 4624
    StartTime = $FechaInicio
    EndTime   = $FechaFin.AddDays(1)
} -ErrorAction SilentlyContinue

# Para cada evento se extrae el usuario del XML (campo TargetUserName)
$lista = foreach ($e in $eventos) {
    $xml = [xml]$e.ToXml()
    $usuario = ($xml.Event.EventData.Data | Where-Object { $_.Name -eq 'TargetUserName' }).'#text'
    [PSCustomObject]@{
        Dia     = $e.TimeCreated.ToString('dd/MM/yyyy')
        Hora    = $e.TimeCreated.ToString('HH:mm:ss')
        Usuario = $usuario
    }
}

# Se excluye SYSTEM (no es una persona) y se muestra el listado
$lista | Where-Object { $_.Usuario -ne 'SYSTEM' } | Format-Table -AutoSize