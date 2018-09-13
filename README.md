# Collection of Docker Service Definitions and tools to create a docker swarm cluster

### Plan your infrastructure 
- define a (preferedly network-shared) place where the docker definitions are stored, like `/opt/docker/`
- define a place where machine-dependent local data is stored, like `/data`
- define a place where machine-independent data is stored (for services not bound to a machine and not performance-critical), like `/mnt/share/data`

In each folder exists a `run.sh` script, which can be used to re-run every service from ground up.
This `run.sh` script must be executed from this folder, because it relies on `$PWD` to discover the mount paths.

Be careful and inspect every `run.sh` script before you execute, especially adjust the variables in it.

### Considerations
- Every mount path which will be used with docker swarm must exist on the/any target machine where the service will be running (unlike with legacy standalone containers, the folder will not be created automatically if not exist)

