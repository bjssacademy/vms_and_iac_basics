#!/usr/bin/env bash

#unlink /etc/resolv.conf
rm /etc/resolv.conf
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "[network]" > /etc/wsl.conf
echo "generateResolvConf = false" >> /etc/wsl.conf
sudo chattr +i /etc/resolv.conf

echo "Done. You might need to restart WSL form a windows CMD prompt with the CMD: wsl --shutdown"
