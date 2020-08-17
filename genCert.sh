mkdir -p ~/pki/{cacerts,certs,private}
chmod 700 ~/pki

pki --gen --type rsa --size 4096 --outform pem > ~/pki/private/ca-key.pem
pki --self --ca --lifetime 3650 --in ~/pki/private/ca-key.pem     --type rsa --dn "CN=ETDS Root CA" --outform pem > ~/pki/cacerts/ca-cert.pem
pki --gen --type rsa --size 4096 --outform pem > ~/pki/private/server-key.pem



pki --pub --in ~/pki/private/server-key.pem --type rsa \
| pki --issue --lifetime 1825 \
--cacert ~/pki/cacerts/ca-cert.pem \
--cakey ~/pki/private/ca-key.pem \
--dn "CN=vpn.etds.me" --san vpn.etds.me \
--flag serverAuth --flag ikeIntermediate --outform pem \
>  ~/pki/certs/server-cert.pem

sudo cp -r ~/pki/* /etc/ipsec.d/

