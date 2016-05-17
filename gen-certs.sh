#!/bin/sh

#CA cert
openssl genrsa -out ca-key.pem 4096
openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem -subj "/CN=peragro.org"

#DAEMON key and cert
openssl genrsa -out server-key.pem 4096
openssl req -subj "/CN=sueastside.chickenkiller.com" -sha256 -new -key server-key.pem -out server.csr

#DAEMON cert signing with CA
echo subjectAltName = IP:10.10.10.20,IP:127.0.0.1 > extfile.cnf
openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile extfile.cnf


#CLIENT key and cert
openssl genrsa -out key.pem 4096
openssl req -subj '/CN=docker-commander' -new -key key.pem -out client.csr

#CLIENT cert signing with CA
echo extendedKeyUsage = clientAuth > extfile.cnf
openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out cert.pem -extfile extfile.cnf

rm -v client.csr server.csr