#!/bin/bash

cd /etc/caddy/ || exit
sudo mv Caddyfile Caddyfile.bkp
touch Caddyfile

if [ "$ENVIRONMENT" = "prod" ]; then
  echo "${DOMAIN_NAME} {
  root * /usr/share/caddy
  reverse_proxy localhost:8080
}" | tee ./Caddyfile
else
  echo "{
  acme_ca https://acme-staging-v02.api.letsencrypt.org/directory
}
${DOMAIN_NAME} {
  root * /usr/share/caddy
  reverse_proxy localhost:8080
}" | tee ./Caddyfile

fi

sudo systemctl restart caddy.service
