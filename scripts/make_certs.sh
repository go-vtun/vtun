#!/bin/bash

domain="govtun.top"
email="admin@govtun.top"

echo "make cert"
openssl req -new -nodes -x509 -out ./certs/server.pem -keyout ./certs/server.key -days 3650 -subj "/C=CN/ST=NRW/L=Earth/O=Random Company/OU=IT/CN=$domain/emailAddress=$email"

