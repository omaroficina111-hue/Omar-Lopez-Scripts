# omarsp31-3.ps1
# Menú dinámico con los registros de eventos que existen en ESTA máquina.
# Muestra el total de eventos y los 12 últimos del registro elegido.

$logs = Get-EventLog -List        # registros reales del sistema (no escritos a mano)

while ($true) {
    Clear-Host
    Write-Host '=== REGISTROS DE EVENTOS ===' -ForegroundColor Cyan
    for ($i = 0; $i -lt $logs.Count; $i++) {
        Write-Host ('{0}. {1}' -f ($i + 1), $logs[$i].Log)
    }
    Write-Host '0. Salir'
    $op = Read-Host 'Elige una opción'

    if ($op -eq '0') {
        Write-Host 'Saliendo...'
        break
    }
    elseif ($op -match '^[0-9]+$' -and [int]$op -ge 1 -and [int]$op -le $logs.Count) {
        $nombre = $logs[[int]$op - 1].Log
        $total  = (Get-EventLog -LogName $nombre | Measure-Object).Count
        Write-Host "Registro '$nombre': $total eventos en total" -ForegroundColor Green
        Write-Host 'Últimos 12 eventos:'
        Get-EventLog -LogName $nombre -Newest 12 |
            Format-Table TimeGenerated, EntryType, Source, Message -AutoSize -Wrap
        Read-Host 'Pulsa Enter para volver al menú'
    }
    else {
        Write-Host 'Opción no válida' -ForegroundColor Red
        Start-Sleep -Seconds 2
    }
}