#!/bin/bash

read -p "Ingrese la IP del servidor: " ipServidor;

echo "sudo ifconfig enp0s3 $ipServidor netmask 255.255.255.0"

sudo ifconfig enp0s3 $ipServidor netmask 255.255.255.0