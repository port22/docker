# Collection of Docker Service Definitions and tools to create a Docker Swarm cluster

### Requirements:
- for redundancy, run three (better 5) swarm managers
- create a global swarm ingress network under which all services can communicate with each other
  - `docker network create --driver=overlay global`

- in case you want to use the registry, create a CA and wildcard certs for your intranet domain (`ssl/init.sh`) and put the ca.pem in every host's `/etc/docker/certs.d/example.com/ca.crt`
A better registry alternative is VMWare Harbor, but is built to run on legacy docker host (not swarm). If you need auth (ldap...), projects, users+groups+rights and datacenter-replication, give it a try!

### Plan your infrastructure 
- define a network-shared place where this docker definitions are accessible on every manager, like `/opt/docker/`
- define a place where machine-dependent local data is stored, like `/data`
- define a network-shared place where machine-independent data is stored on every host (for services not bound to a specific host and not performance-critical), like `/opt/data`   (alternatively use the nfs-volume driver or else like rexray)

In each folder is a `run.sh` script, which can be used to re-run every service from scratch.
It should be executed from this folder while relying on `$PWD`.
Be careful and inspect every `run.sh` script before you execute, especially adjusting the variables in it. Also look for .env files in the current dirs.

### Informative
- Every mount path which will be used with docker swarm must exist on the/any target machine where the service will be running (unlike with legacy standalone containers, the folder will *not* be created automatically if not exists)
- You can stick services to nodes by either putting labels in every host's `/etc/docker/daemon.json`:
  - single label: `{"labels": ["task=example"]}`
  - multiple labels: `{"labels": ["task=example"],"labels":["arch=amd64"],"labels":["cpu=strong"]}`
  or use placement constraints (see below)
- a node can only have one label (think of key-value) of the same name

Swarm constraint examples:

- Run a service on a specific host: `--constraint 'node.hostname == example'`
- Run a service on managers only: `--constraint 'node.role == manager'`
- Run a service on a node with engine label: `--constraint 'engine.labels.task == example'`
- Run a service on a node with node label: `--constraint 'node.labels.task == example'`
