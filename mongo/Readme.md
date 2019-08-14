
Add Labels to desired nodes:
```
docker node update --label-add mongo1=true swarm1
docker node update --label-add mongo2=true swarm2
docker node update --label-add mongo3=true swarm3
docker node update --label-add mongo3=true swarm4
docker node update --label-add mongo3=true swarm5
#docker node update --label-add mongo_arbiter=true swarm4
```

Deploy Mongo Stack:
```
docker stack deploy -c docker-compose.yml mongo
```

Connect to one of the mongo instances:
```
docker exec -it mongo_mongo1.1.ymdh7w3rvxp6f5yiitjk2w3n3 mongo
```

Manually initiate replicaSet:
```
rs.initiate( {
   _id : "rs0",
   members: [
      { _id: 0, host: "mongo1:27017" },
      { _id: 1, host: "mongo2:27017" },
      { _id: 2, host: "mongo3:27017" }
      { _id: 3, host: "mongo4:27017" }
      { _id: 4, host: "mongo5:27017" }      
   ]
})
```
Check status:
```
rs.status()
```

Add Arbiter:
```
rs.addArb("mongo_arbiter:27017")
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
