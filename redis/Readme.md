Deploy the Stack

```
docker stack deploy -c docker-compose.yml redis
```

Bootstrap the cluster

```
NODE1: 1.2.3.4
NODE2: 1.2.3.5
NODE3: 1.2.3.6

i=6379

docker run -it --rm docker.io/redis:latest redis-cli --cluster create \
 ${NODE1}:${i}  ${NODE2}:${i}  ${NODE3}:${i} \
 ${NODE1}:$2{i} ${NODE2}:2${i} ${NODE3:2${i} \
--cluster-replicas 1
```
