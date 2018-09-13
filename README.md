# Collection of Docker Service Definitions and tools to create a docker swarm cluster

### Plan your infrastructure 
- define a (preferedly network-shared) place where the docker definitions are stored, like `/opt/docker/`
- define a place where machine-dependent local data is stored, like `/data`
- define a place where machine-independent data is stored (for services not bound to a machine and not performance-critical), like `/mnt/share/data`


