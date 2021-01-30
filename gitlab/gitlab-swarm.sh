docker service create --name gitlab \
  --constraint 'engine.labels.task == gitlab' \
  --hostname git.example.com \
  --mount type=bind,source="$PWD/config",destination="/etc/gitlab" \
  --mount type=bind,source="$PWD/data",destination="/var/opt/gitlab" \
  --mount type=bind,source="/var/run/docker.sock",destination="/var/run/docker.sock" \
  --publish mode=ingress,target=22,published=222 \
  --network private \
  --label "traefik.enable=true" \
  --label "traefik.port=80" \
  --label "traefik.frontend.rule=Host:git.example.com" \
gitlab/gitlab-ce:latest
