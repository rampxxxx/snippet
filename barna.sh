#!/bin/bash

allHosts=(192.168.254.193 192.168.254.194 192.168.254.195 192.168.254.196 192.168.254.197 192.168.253.13 192.168.253.8)

echo "Choose position!"
((position=0))
for i in "${allHosts[@]}"; do
  echo "position:" $position" : $i"
  ((position+=1))
done
read -r destination

ssh -i  ~/.ssh/volta_id_rsa javier.garcia@"${allHosts[$destination]}"
