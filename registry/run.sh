#!/bin/bash

DATAPATH="/data/registry"
DOMAIN="registry.example.com"

docker network create driver=overlay registry

docker service rm registry

docker secret rm wildcard.pem wildcard.key
docker secret create wildcard.pem ../ssl/wildcard.pem
docker secret create wildcard.key ../ssl/wildcard.key

docker service create --name registry \
  --constraint 'engine.labels.task == registry' \
  --restart-condition=on-failure \
  --secret wildcard.pem \
  --secret wildcard.key \
  --env "REGISTRY_HTTP_ADDR=0.0.0.0:5000" \
  --env "REGISTRY_HTTP_TLS_CERTIFICATE=/run/secrets/wildcard.pem" \
  --env "REGISTRY_HTTP_TLS_KEY=/run/secrets/wildcard.key" \
  --mount type=bind,source=$PWD/config.yml,destination=/etc/docker/registry/config.yml \
  --mount type=bind,source=$DATAPATH/data,destination=/var/lib/registry \
  --publish mode=host,target=5000,published=5000 \
  --network registry \
  --label "traefik.enable=true" \
  --label "traefik.port=5000" \
  --label traefik.frontend.rule="Host:$DOMAIN" \
docker.io/registry:2
