#!/bin/bash

read -p "Ingrese la MAC del servidor: " macServidor; 

echo "ifconfig enp1s0 down";
ifconfig enp1s0 down

echo "ifconfig enp1s0 hw ether $macServidor";
ifconfig enp1s0 hw ether $macServidor

echo "ifconfig enp1s0 up";
ifconfig enp1s0 up