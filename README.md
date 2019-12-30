# Collection of Docker Service Definitions and tools to create a Docker Swarm cluster

### Requirements:
- three (better 5) swarm managers
- global swarm ingress network `docker network create --driver=overlay global`

- in case you want to use the registry, create a CA and wildcard certs for your intranet domain (`ssl/init.sh`) and put the ca.pem in every host's `/etc/docker/certs.d/example.com/ca.crt`
A better registry alternative is VMWare Harbor, but is built to run on legacy docker host (not swarm). If you need auth (ldap...), projects, users+groups+rights and datacenter-replication, give it a try!

### Plan your infrastructure 
- define a network-shared place where this docker definitions are accessible on every manager, like `/opt/docker/`
- define a network-shared place where machine-independent data is stored on every host (for services not bound to a specific host and not performance-critical), like `/opt/data`   (alternatively use the nfs-volume driver or else like rexray)
- define a place where machine-dependent local data is stored, like `/data`. If you need to have this storage synced to all workers, try glusterfs.

Each folder contains a `run.sh` script, which can be used to re-run every service from scratch. It relies on `$PWD`, so it has to be run from this folder. Be careful and inspect every `run.sh` script before you execute, especially adjusting the variables in it. Also look for .env files in the current dirs.

### Information
- Every mount path used with docker swarm must exist on any target machine (folder will *not* be created automatically if not existing)

Swarm constraint examples:

- Run a service on a specific host: `--constraint 'node.hostname == example'`
- Run a service on managers only: `--constraint 'node.role == manager'`
- Run a service on a node with engine label: `--constraint 'engine.labels.task == example'`
- Run a service on a node with node label: `--constraint 'node.labels.task == example'`
