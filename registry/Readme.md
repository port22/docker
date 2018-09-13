# Docker Registry

## Requirements:
- CA and wildcard certificate is generated
- Traefik is running with wildcard certificate (running in swarm mode)

## Preparation: 
- Configure `$DATAPATH` in `run.sh` where your persistent docker images are being stored (default `/data`)
