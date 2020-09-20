#! /bin/bash

sudo apt install strongswan strongswan-pki libcharon-extra-plugins libcharon-extauth-plugins 
sudo mv /etc/ipsec.conf{,.old}
sudo cp ~/cluster_setup/vpn/ipsec.conf /etc/

sudo service strongswan-starter stop
sudo service strongswan-starter start
sudo service strongswan-starter status
sudo cp -r ~/pki/* .

