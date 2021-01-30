#!/bin/bash

docker pull gitlab/gitlab-ce:latest
docker stop gitlab
docker rm gitlab

docker run -d --restart=always --name gitlab \
 --hostname gitlab.example.com \
 --publish 222:22 \
 --volume $PWD/config:/etc/gitlab \
 --volume $PWD/data/gitlab:/var/opt/gitlab \
 --volume /var/run/docker.sock:/var/run/docker.sock \
 --label "traefik.enable=true" \
 --label "traefik.port=80" \
 --label "traefik.frontend.rule=Host:gitlab.example.com" \
gitlab/gitlab-ce:latest

# tbd: traefikv2
