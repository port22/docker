Bootstrapping the cluster

```
NODE1: 1.2.3.4
NODE2: 1.2.3.5
NODE3: 1.2.3.6

docker run -it --rm docker.io/redis:latest redis-cli --cluster create \
 $NODE1:6379 $NODE2:6379 $NODE3:6379 \
 $NODE1:26379 $NODE2:26379 $NODE3:26379 \
 --cluster-replicas 3
```
