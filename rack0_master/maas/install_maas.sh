#! /bin/bash

source .env

echo "Installing MAAS"
sudo snap install maas

echo "Patching MAAS"
sudo mkdir -p /usr/src/maas_hooks
sudo cp hooks.py /usr/src/maas_hooks/
sudo cp rc.local /etc/

#Ensure that rc.local is executable
sudo chmod a+x /etc/rc.local

sudo mount --bind /usr/src/maas_hooks/hooks.py /snap/maas/current/lib/python3.6/site-packages/metadataserver/builtin_scripts/hooks.py


echo "Installing PostgreSQL"
sudo apt install postgresql -y

echo "Creating Database"
sudo -u postgres psql -c "CREATE USER \"$MAAS_DBUSER\" WITH ENCRYPTED PASSWORD '$MAAS_DBPASS'"
sudo -u postgres createdb -O "$MAAS_DBUSER" "$MAAS_DBNAME"

echo "Applying Permissions"
echo "host    $MAAS_DBNAME    $MAAS_DBUSER    0/0     md5" | sudo tee -a /etc/postgresql/12/main/pg_hba.conf

echo "Initialising MAAS"
sudo maas init region+rack --database-uri "postgres://$MAAS_DBUSER:$MAAS_DBPASS@$MAAS_DBHOST/$MAAS_DBNAME"

sudo maas createadmin --username $MAAS_USER --password $MAAS_PASS --email $MAAS_EMAIL

echo 
echo "Done!"
