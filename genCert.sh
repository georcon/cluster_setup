pki --pub --in ~/pki/private/server-key.pem --type rsa \
| pki --issue --lifetime 1825 \
--cacert ~/pki/cacerts/ca-cert.pem \
--cakey ~/pki/private/ca-key.pem \
--dn "CN=vpn.etds.me" --san vpn.etds.me \
--flag serverAuth --flag ikeIntermediate --outform pem \
>  ~/pki/certs/server-cert.pem
