﻿#28/05/2023
#Scrip:Scan_Alive2
#Nombre: Eduardo Flores Smith | Matricula:1722592
#Escaneo de equipos activos en la subred
#
#Determinando gateway
$subred = (Get-NetRoute -DestinationPrefix 0.0.0.0/0).NextHop
Write-Host "== Determinando tu gateway ..."
Write-Host "Tu gateway es: " $subred
#
# Determinando rango de subred
#
$rango = $subred.Substring(0,$subred.IndexOf('.') + 1 + $subred.Substring($subred.IndexOf('.') + 1).IndexOf('.') + 3)
Write-Host "== Determinando tu rando de subred ..."
echo $rango
#
##Determinando si $rango termina en "."
## En ocasiones el rango de subred no termina en punto, necesitamos formarlo
#
$punto = $rango.EndsWith('.')
if ($punto -like "False")
{
    $rango= $rango + '.' #agregamos el punto en caso de que no estuviera
}
#
## Creamos un array con 254 numeros (1 a 254)  y se almacenan
## en una variable que se llamra $rango_ip
#
$rango_ip = @(1..254)
#
## Generamos bucle foreach para vlidar hosts activos en nuestra subred
#
Write-Output ""
Write-Host "-- Subred actual:"
Write-Host "Escaneando: " -NoNewline ; Write-Host $rango -NoNewline; Write-Host "0/24" -ForegroundColor Red
Write-Output ""
foreach ($r in $rango_ip)
{
    $actual= $rango + $r #se genera direccion IP
    $responde= Test-Connection $actual -Quiet -Count 1 #Validamos conexion contra ip en $actual
    if ( $responde -eq "True" )
    {
        Write-Output ""
        Write-Host " Host responde: " -NoNewline; Write-Host $actual -ForegroundColor Green
    }
 
}
#
##Fin del script
#