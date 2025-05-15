# detectar_os.ps1

Write-Output "Detectar o sistema operativo..."

$os = Get-CimInstance -ClassName Win32_OperatingSystem

Write-Output "Sistema operativo: $($os.Caption)"
Write-Output "Versão: $($os.Version)"
Write-Output "Arquitetura: $($os.OSArchitecture)"
