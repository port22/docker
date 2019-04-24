
Add Labels to desired nodes:
```
docker node update --label-add rocketchat_mongo1=true swarm1
docker node update --label-add rocketchat_mongo2=true swarm2
docker node update --label-add rocketchat_mongo3=true swarm3
```

Deploy Mongo Services:
```
docker stack deploy -c docker-compose.yml mongo
```

Manually initiate replicaSet:
```
rs.initiate( {
   _id : "rs0",
   members: [
      { _id: 0, host: "mongo_mongo1:27017" },
      { _id: 1, host: "mongo_mongo2:27017" },
      { _id: 2, host: "mongo_mongo3:27017" }
   ]
})
```

Shutdown Stack:
```
docker stack rm mongo
```
on every swarm node, leftover volumes must be deleted manually:
```
docker container prune -f
docker volume rm mongo_mongo1 mongo_mongo2 mongo_mongo3
```
