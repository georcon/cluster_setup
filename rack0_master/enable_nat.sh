echo -e "\n\nLoading simple rc.firewall-iptables version $FWVER..\n"

DEPMOD=/sbin/depmod
MODPROBE=/sbin/modprobe

EXTIF="enp5s0"
INTIF="enp9s0"

echo "   External Interface:  $EXTIF"
echo "   Internal Interface:  $INTIF"

#======================================================================
#== No editing beyond this line is required for initial MASQ testing == 
echo -en "   loading modules: "
echo "  - Verifying that all kernel modules are ok"
$DEPMOD -a
echo "----------------------------------------------------------------------"
echo -en "ip_tables, "
$MODPROBE ip_tables
echo -en "nf_conntrack, " 
$MODPROBE nf_conntrack
echo -en "nf_conntrack_ftp, " 
$MODPROBE nf_conntrack_ftp
echo -en "nf_conntrack_irc, " 
$MODPROBE nf_conntrack_irc
echo -en "iptable_nat, "
$MODPROBE iptable_nat
echo -en "nf_nat_ftp, "
$MODPROBE nf_nat_ftp
echo "----------------------------------------------------------------------"
echo -e "   Done loading modules.\n"
echo "   Enabling forwarding.."
echo "1" > /proc/sys/net/ipv4/ip_forward
echo "   Enabling DynamicAddr.."
echo "1" > /proc/sys/net/ipv4/ip_dynaddr 
echo "   Clearing any existing rules and setting default policy.."

###THIS IS THE RULE CONFIGURATION USED

#-P INPUT ACCEPT

#-P FORWARD ACCEPT
#-P OUTPUT ACCEPT
#-A FORWARD -i enp9s0 -o enp5s0 -j ACCEPT
#-A FORWARD -j LOG

#MAKE SURE IT MATCHES (sudo iptables -S)


#THIS IS THE CURRENT RULE IN USE:
# sudo iptables --table nat --append POSTROUTING --out-interface enp5s0 -j MASQUERADE
# sudo iptables --append FORWARD --in-interface enp9s0 -j ACCEPT
#NOTE THAT THE FOLLOWING BLOCKS ROUTED CLUSTER-LOCAL TRAFFIC AND THE VPN!!!"


#*filter
#:INPUT ACCEPT [0:0]
#:FORWARD DROP [0:0]
#:OUTPUT ACCEPT [0:0]

#-A FORWARD -i "$EXTIF" -o "$INTIF" -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT 

iptables-restore <<-EOF
*nat
-A POSTROUTING -o "$EXTIF" -j MASQUERADE
COMMIT
*filter
-A FORWARD -i "$INTIF" -o "$EXTIF" -j ACCEPT
-A FORWARD -j LOG
COMMIT
EOF

echo -e "\nrc.firewall-iptables v$FWVER done.\n":
