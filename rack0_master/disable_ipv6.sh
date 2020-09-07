#! /bin/bash

echo "Disabling ipv6"

cat /etc/sysctl.conf | grep -i ipv
echo
echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
echo "net.ipv6.conf.lo.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
echo
sudo sysctl -p
cat /etc/sysctl.conf | grep -i ipv


