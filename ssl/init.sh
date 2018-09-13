#!/bin/bash

echo "## generate Certificate Authority"
openssl genrsa -aes256 -out ca.key 4096
openssl req -x509 -new -nodes -extensions v3_ca -key ca.key -days 99999 -out ca.pem -sha512

echo "## generate wildcard key"
openssl genrsa -out wildcard.key 4096

echo "## generate Certificate Signing Request"
openssl req -nodes -new -key wildcard.key -out wildcard.csr -sha512

echo "## generate Certificate"
openssl x509 -req -in wildcard.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out wildcard.pem -days 99999 -sha512

echo "## chain the ca-root to the certificate"
cat ca.pem >> wildcard.pem
