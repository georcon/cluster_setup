#! /bin/bash

sudo cp 00-installer-config.yaml /etc/netplan/00-installer-config.yaml
sudo netplan generate
sudo netplan apply
