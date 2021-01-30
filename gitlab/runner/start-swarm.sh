#!/bin/bash

docker service create --name gitlab-runner \
  --mount type=bind,source="$PWD/config.toml",destination="/etc/gitlab-runner/config.toml" \
  --mount type=bind,source="/etc/hosts",destination="/etc/hosts" \
  --mount type=bind,source="/var/run/docker.sock",destination="/var/run/docker.sock" \
gitlab/gitlab-runner:latest
