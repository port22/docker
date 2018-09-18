docker service create --name gitlab \
  --constraint 'engine.labels.task == gitlab' \
  --hostname git.example.com \
  --mount type=bind,source="$PWD/config",destination="/etc/gitlab" \
  --mount type=bind,source="$PWD/data",destination="/var/opt/gitlab" \
  --mount type=bind,source="/var/run/docker.sock",destination="/var/run/docker.sock" \
  --publish mode=ingress,target=22,published=222 \
  --network private \
gitlab/gitlab-ce:latest

docker service create --name gitlab-runner \
  --mount type=bind,source="$PWD/config.toml",destination="/etc/gitlab-runner/config.toml" \
  --mount type=bind,source="/etc/hosts",destination="/etc/hosts" \
  --mount type=bind,source="/var/run/docker.sock",destination="/var/run/docker.sock" \
gitlab/gitlab-runner:latest
