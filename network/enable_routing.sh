echo "Enabling ipv4 routing"
cp /etc/sysctl.conf sysctl.conf.new
echo '/^#net.ipv4.ip_forward=1/s/^#// | x' | ex ./sysctl.conf.new
diff /etc/sysctl.conf sysctl.conf.new
echo 'Remember to apply (copy and sysctl -p -) looking at you @Georcon'
