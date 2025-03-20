#!/usr/bin/sh

mkdir -p secrets

KEYFILE=secrets/private-key.pem
CERTFILE=secrets/self-signed.pem
P12FILE=secrets/self-signed.p12

# Generate an RSA private key
openssl genrsa >$KEYFILE
chmod 600 $KEYFILE

# Generate a self-signed certificate based on that key
openssl req -key $KEYFILE -new -x509 -days 365 -out $CERTFILE \
    -subj "/CN=test-self-signed"

# Create PKCS12 keystore from private key and public certificate.
openssl pkcs12 -export -name key10 -passout pass:password -in $CERTFILE -inkey $KEYFILE -out $P12FILE
