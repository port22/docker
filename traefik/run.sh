#!/bin/bash

docker service rm traefik

touch acme.json
chmod 600 acme.json

docker service create --name traefik \
  --constraint 'engine.labels.task == traefik' \
  --network private \
  --mount type=bind,source=$PWD/traefik.toml,destination=/etc/traefik/traefik.toml \
  --mount type=bind,source=/var/run/docker.sock,destination=/var/run/docker.sock \
  --mount type=bind,source=$PWD/acme.json,destination=/etc/traefik/acme/acme.json \
  --publish mode=host,published=80,target=80 \
  --publish mode=host,published=8080,target=8080 \
  --publish mode=host,published=443,target=443 \
docker.io/traefik
