#!/bin/bash

# preferred as shell-executor

IMAGE="registry/ops/gitlab-runner"
docker pull $IMAGE

for i in 1 2 3 4 5 6
do

 docker rm -f runner$i

 docker run -d --restart=always --name runner$i \
  --privileged=true \
  --env-file=.env \
  -v $PWD/config${i}.toml:/etc/gitlab-runner/config.toml \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $PWD/.docker/config.json:/home/gitlab-runner/.docker/config.json \
  -v /auto/docker/gitlab/gitlab-runner/.gitconfig:/home/gitlab-runner/.gitconfig \
$IMAGE

done
