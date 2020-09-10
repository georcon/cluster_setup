#! /bin/bash

echo "Configuring Backups"
echo ""

sudo vgs
sudo lvcreate -L 55G -n backup_volume ubuntu-vg
sudo vgs
sudo lvs
sudo mkfs.ext4 /dev/ubuntu-vg/backup_volume 
