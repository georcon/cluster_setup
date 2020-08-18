    1  git 
    2  git clone https://github.com/georcon/cluster_set
    3  git clone https://github.com/georcon/cluster_setup.git
    4  ls
    5  cd cluster_setup/
    6  ls
    7  sudo cp 00-installer-config.yaml /etc/netplan/00-installer-config.yaml 
    8  sudo netplan apply
    9  ssh-keygen -t rsa -b 4096 -o -a 100 -f ~/.ssh/id_rsa -q -N ""
   10  history
   11  history > net_and_ssh.sh
