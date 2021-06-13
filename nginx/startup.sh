#!/bin/bash

if [ ! -f /etc/nginx/ssl/default.crt ]; then
    openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
      -keyout "/etc/nginx/ssl/default.key" -out "/etc/nginx/ssl/default.crt" -subj "/CN=local.idbi.pe" \
      -addext "subjectAltName=DNS:backend.test,DNS:delivery.test"
fi

# Start crond in background
crond -l 2 -b

# Start nginx in foreground
nginx
