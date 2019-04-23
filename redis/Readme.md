Bootstrapping the cluster

```
NODE1:
NODE2:
NODE3:

docker run -it --rm docker.io/redis:latest redis-cli --cluster create $NODE1:6379 $NODE2:6379 $NODE3:6379 --cluster-replicas 0
docker run -it --rm docker.io/redis:latest redis-cli --cluster add-node $NODE1:26379 $NODE1:6379 --cluster-slave
docker run -it --rm docker.io/redis:latest redis-cli --cluster add-node $NODE2:26379 $NODE1:6379 --cluster-slave
docker run -it --rm docker.io/redis:latest redis-cli --cluster add-node $NODE3:26379 $NODE1:6379 --cluster-slave

```
