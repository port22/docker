# Collection of Docker Service Definitions and tools to create a Docker Swarm cluster

### Requirements:
- for redundancy, run three swarm managers (from where all commands are run)
  - `docker swarm init` and `docker swarm join`
- create a private swarm ingress network under which all services can communicate with each other
  - `docker network create --driver=overlay private`
- create a CA and wildcard certs for your intranet domain (`ssl/init.sh`) and put the ca.pem in every host's `/etc/docker/certs.d/example.com/ca.crt`

### Plan your infrastructure 
- define a network-shared place where the docker definitions are accessible on every machine, like `/opt/docker/`
- define a place where machine-dependent local data is stored, like `/data`
- define a place where machine-independent data is stored (nfs) (for services not bound to a machine and not performance-critical), like `/opt/data`

In each folder exists a `run.sh` script, which can be used to re-run every service from ground up.
This `run.sh` script must be executed from this folder, because it relies on `$PWD` to discover the mount paths.
Be careful and inspect every `run.sh` script before you execute, especially adjusting the variables in it.

### Informative
- Every mount path which will be used with docker swarm must exist on the/any target machine where the service will be running (unlike with legacy standalone containers, the folder will not be created automatically if not exist)
- You can target services to be run on specific nodes by putting labels in every host's `/etc/docker/daemon.json`:
  - single label: `{"labels": ["task=example"]}`
  - multiple labels: `{"labels": ["task=example"],"labels":["arch=amd64"],"labels":["cpu=strong"]}`

Swarm constraint examples:

- Run a service on a specific host: `--constraint 'node.hostname == example'`
- Run a service on a node with label: `--constraint 'engine.labels.task == example'`


