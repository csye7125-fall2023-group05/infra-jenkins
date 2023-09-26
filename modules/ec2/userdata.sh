#!/bin/bash

cd /etc/caddy/ || exit
sudo mv Caddyfile Caddyfile.backup
touch Caddyfile
echo "${DOMAIN_NAME}" > domain.txt

tee -a ./Caddyfile << END
${DOMAIN_NAME} {
  root * /usr/share/caddy
  reverse_proxy localhost:8080
}
END

sudo systemctl restart caddy.service