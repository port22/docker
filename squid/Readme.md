```
#!/bin/bash

IMAGE=""
SERVICE="squid"

docker service rm $SERVICE

docker service create --with-registry-auth --detach --name $SERVICE \
  --constraint 'node.role == manager' \
  --mount type=bind,source=$PWD/squid.conf,destination=/etc/squid/squid.conf \
  --mount type=bind,source=$PWD/auth,destination=/auth \
  --publish mode=ingress,published=3128,target=3128 \
$IMAGE
```
